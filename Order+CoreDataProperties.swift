//
//  Order+CoreDataProperties.swift
//  YummieUI
//
//    Chan Yu Sing
//    3035930345

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dishIdsAndQuantity: [String]?
    @NSManaged public var items: Int16
    @NSManaged public var restaurantId: String?
    @NSManaged public var total: Double
    @NSManaged public var user: User?

}

extension Order : Identifiable {

    var status:OrderStatus {
        if Date() < deliverDate {
            return .pending
        } else {
            return .deliver
        }
        
    }
    
    var toDishes:[Dish] {
        var dishes:[Dish] = []
        let allDishes:[Dish] = restaurant?.dishes ?? []
        self.dishIdsAndQuantity?.forEach({ pair in
            let id = pair.components(separatedBy: ":")[0]
            let qty = pair.components(separatedBy: ":")[1]
            if let dish = allDishes.first(where: {$0.id == id}) {
                let intQty = Int(qty) ?? 0
                for _ in 0...intQty - 1 {
                    dishes.append(dish)
                }
            }
            
        })
        return dishes
    }

    var restaurant:Restaurant? {
        let allRests = Restaurant.allData()
        if let rest = allRests.first(where: {$0.id == restaurantId ?? ""}) {
            return rest
        } else {
            return nil
        }
    }
    
    var deliverDate:Date {
        let orderTime = date ?? Date()
        let maxDeliverSeconds:Double = 60 * 30 // 30 mins
        let deliveredOn = orderTime.addingTimeInterval(TimeInterval(maxDeliverSeconds))
        return deliveredOn
    }
    
    var uid:String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss SSS"
        return df.string(from: date!)
    }
}
