//
//  CoreDataManager.swift
//  Yummie
//
//   Udayveer Singh
//    3035918634
import Foundation
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    lazy var coreDataStack = CoreDataStack(modelName: "YummieModel")
   
    var uid:String {
        return UserDefaults.standard.string(forKey: "user_id") ?? ""
    }
    
    var allFavRestsIds:[String] {
        return UserDefaults.standard.array(forKey: uid) as? [String] ?? []
    }
    
    @discardableResult
    func updateFav(restrntId:String) -> [String] {
        var favsOfcurrentUser = UserDefaults.standard.array(forKey: uid) as? [String] ?? []
        if let index = favsOfcurrentUser.firstIndex(of: restrntId) {
            favsOfcurrentUser.remove(at: index)
        } else {
            favsOfcurrentUser.append(restrntId)
        }
        UserDefaults.standard.set(favsOfcurrentUser, forKey: uid)
        return favsOfcurrentUser
    }
    
    
    @discardableResult
    func logOutUser() -> String {
        UserDefaults.standard.removeObject(forKey: "user_id")
        return uid
    }
}

extension CoreDataManager {
    
    func allUsers() -> [User] {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        do {
           let allUsers = try coreDataStack.managedContext.fetch(fetchRequest)
           return allUsers
        } catch {
            print("Unable to Fetch Journey, (\(error))")
        }
        return []
    }
    
    func createUser(name:String,email:String,password:String,phone:String,id:UUID = UUID()) -> User? {
        let user = User(context: coreDataStack.managedContext)
        user.uid = id
        user.email = email.lowercased()
        user.name = name
        user.password = password
        user.phone = phone
        coreDataStack.saveContext()
        return user
    }
    
    
    func getUser() -> User? {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", uid)
        do {
            let allUsers = try coreDataStack.managedContext.fetch(fetchRequest)
            return allUsers.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getUser(email:String) -> User? {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let allUsers = try coreDataStack.managedContext.fetch(fetchRequest)
            return allUsers.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func loginWith(email:String,password:String, completion: @escaping ([User]) -> ()) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        // Create predicates for email and password
        let mail = email.lowercased()
        let emailPredicate = NSPredicate(format: "email == %@", mail)
        let passwordPredicate = NSPredicate(format: "password == %@", password)

        // Combine predicates using AND operation
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [emailPredicate, passwordPredicate])

        // Set the compound predicate to the fetch request
        fetchRequest.predicate = compoundPredicate
        
        do {
            // Fetching records that match both email and password
            let matchingUsers = try coreDataStack.managedContext.fetch(fetchRequest)
            completion(matchingUsers)
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            completion([])
        }
    }
    
    @discardableResult
    func createOrder(time:Date = Date(),items:Int,totalPrice:Double,id:String,dishIdQty:[String]) -> Order? {
        let order = Order(context: coreDataStack.managedContext)
        order.date = time
        order.items = Int16(items)
        order.total = totalPrice
        order.restaurantId = id
        order.dishIdsAndQuantity = dishIdQty
        if let user = getUser() { //user logged in
            user.addToOrders(order)
            coreDataStack.saveContext()
            return order
        } else {
            return nil
        }
       
    }
    

}


class CoreDataStack {
    
    private let modelName: String
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {return}
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func updateContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func clearChange() {
        managedContext.rollback()
    }
    
 
}



