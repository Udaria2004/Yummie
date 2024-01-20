
import Foundation

struct HomeModel {
    
    let advertise:[Advertise]
    let categories:[Category]
    var populars:[Restaurant]
    var featureds:[Restaurant]
    var quickPics:[Restaurant]
    
    init(advertise: [Advertise], categories: [Category], populars: [Restaurant], featureds: [Restaurant], quickPics: [Restaurant]) {
        self.advertise = advertise
        self.categories = categories
        self.populars = populars
        self.featureds = featureds
        self.quickPics = quickPics
    }
    
    static func all() -> HomeModel {
        let allRestaurants = Restaurant.allData()
        let featured = Restaurant.allData().filter({$0.isFeatured})
        let popular = Restaurant.allData().filter({$0.isPopular})
        return HomeModel(advertise: Advertise.all(),
                         categories: Category.allCases,
                         populars: popular,
                         featureds: featured,
                         quickPics: allRestaurants)
    }
    
    static var sections = ["","Categories","Popular Today","Featured Restaurants","Quick Picks"]
    
}
struct Advertise:Identifiable {
    
    let title:String
    let icon:String
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
    
    static func all() -> [Advertise] {
        return [Advertise(title: "", icon: "ad-0"),
                Advertise(title: "", icon: "ad-1"),
                Advertise(title: "", icon: "ad-2")]
    }
    
    var id:String {
        return icon
    }
}


struct CartItem {
    let id = UUID().uuidString
    let dish: Dish
    var quantity: Int
    var totalPrice: Double {
        return Double(quantity) * dish.price
    }
}

class Cart {
    var cartItems: [String: CartItem] = [:] // Dictionary to store cart items by dish ID
    
    func addToCart(dish: Dish) {
        if var existingCartItem = cartItems[dish.id] {
            existingCartItem.quantity += 1
            cartItems[dish.id] = existingCartItem
        } else {
            cartItems[dish.id] = CartItem(dish: dish, quantity: 1)
        }
    }
    
    func printCartItems() {
        for cartItem in cartItems.values {
            print("\(cartItem.dish.name) - Quantity: \(cartItem.quantity) - Total Price: \(cartItem.totalPrice)")
        }
    }
}
struct OrderDish {
    let name: String
    let image: String
    let price: Double
    let quantity:Int
    let restaurent:Restaurant
}
