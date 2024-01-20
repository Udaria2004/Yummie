
import Foundation

class Restaurant:Identifiable {
    
    let id:String
    let name:String
    let description:String
    let addressURL:URL
    let ratings:Double
    let numberOfRater:Int
    let latitude:Double
    let longitude:Double
    let dishes:[Dish]
    let categories:[Category]
    let cusine:Cousine
    let isFeatured:Bool
    let isPopular:Bool
    let timeForDelivery:String
    let chargesForDelivery:Double
    let address:String
    let bgCover:String
    let distance:Double
    
    
    init(id:String,name: String,
         description: String,
         addressURL: URL,
         ratings: Double,
         numberOfRater: Int,
         latitude: Double,
         longitude: Double,
         dishes: [Dish],
         categories: [Category],
         cusine:Cousine,
         isFeatured:Bool,
         isPopular:Bool,
         timeForDelivery:String,
         chargesForDelivery:Double,
         address:String,
         bgCover:String,
         distance:Double) {
        self.id = id
        self.name = name
        self.description = description
        self.addressURL = addressURL
        self.ratings = ratings
        self.numberOfRater = numberOfRater
        self.latitude = latitude
        self.longitude = longitude
        self.dishes = dishes
        self.categories = categories
        self.cusine = cusine
        self.isPopular = isPopular
        self.isFeatured = isFeatured
        self.timeForDelivery = timeForDelivery
        self.chargesForDelivery = chargesForDelivery
        self.address = address
        self.bgCover = bgCover
        self.distance = distance
    }
    
    var isFav:Bool {
        return CoreDataManager.shared.allFavRestsIds.contains(id)
    }
}


class Dish {
    
    let name:String
    let calories:Int
    let description:String
    let image:String
    let price:Double
    let rating:Double
    let numberOfRate:Int
    let dishType:Category
    
    init(name: String, calories: Int, description: String, image: String, price: Double, rating: Double, numberOfRate: Int, dishType: Category) {
        self.name = name
        self.calories = calories
        self.description = description
        self.image = image
        self.price = price
        self.rating = rating
        self.numberOfRate = numberOfRate
        self.dishType = dishType
    }
    
    var id:String {
        return image
    }
    
    
}


extension Restaurant {
    
    static func allData() -> [Restaurant] {
        let timHoWan = Restaurant(id: "tim",
                                  name: "Tim Ho Wan",
                                  description: "",
                                  addressURL: URL.timHoWan,
                                  ratings: 4.5,
                                  numberOfRater: 200,
                                  latitude: 2,
                                  longitude: 2,
                                  dishes: Dish.timHoWanDishes(),
                                  categories: [.noodles,.chicken],
                                  cusine: .chinese,
                                  isFeatured: true,
                                  isPopular: true,
                                  timeForDelivery: "10 min",
                                  chargesForDelivery: 10,
                                  address: "Central",
                                  bgCover: "tim",
                                  distance: 2.7)
        
        let chariman = Restaurant(id: "chair",
                                  name: "The Chairman",
                                  description: "",
                                  addressURL: URL.chariman,
                                  ratings: 4.8,
                                  numberOfRater: 182,
                                  latitude: 1,
                                  longitude: 1,
                                  dishes: Dish.theChairman(),
                                  categories: [.chinese],
                                  cusine: .chinese,
                                  isFeatured: true,
                                  isPopular: false,
                                  timeForDelivery: "8 min",
                                  chargesForDelivery: 9,
                                  address: "Central",
                                  bgCover: "chair",
                                  distance: 4.0)
        
        let lungKing = Restaurant(id: "lung",
                                  name: "Lung King Heen",
                                  description: "",
                                  addressURL: URL.lungKing,
                                  ratings: 4.9,
                                  numberOfRater: 311,
                                  latitude: 1,
                                  longitude: 1,
                                  dishes: Dish.theLungKing(),
                                  categories: [.chinese,.noodles,.chicken],
                                  cusine: .japenese,
                                  isFeatured: false,
                                  isPopular: true,
                                  timeForDelivery: "12 min",
                                  chargesForDelivery: 11,
                                  address: "Sheung Wan",
                                  bgCover: "lung",
                                  distance: 3.9)
        
        let yardBird = Restaurant(id: "yard",
                                  name: "Yardbird",
                                  description: "",
                                  addressURL: URL.lungKing,
                                  ratings: 4.9,
                                  numberOfRater: 311,
                                  latitude: 1,
                                  longitude: 1,
                                  dishes: Dish.yardBud(),
                                  categories: [.chicken],
                                  cusine: .korean,
                                  isFeatured: true,
                                  isPopular: true,
                                  timeForDelivery: "15 min",
                                  chargesForDelivery: 5,
                                  address: "Sheung Wan",
                                  bgCover: "yard",
                                  distance: 5.0)
        
        let taiPan = Restaurant(id: "tai",
                                  name: "The Tai Pan",
                                  description: "",
                                  addressURL: URL.taiPan,
                                  ratings: 4.7,
                                  numberOfRater: 411,
                                  latitude: 1,
                                  longitude: 1,
                                  dishes: Dish.theThaiPan(),
                                categories: [.chicken],
                                  cusine: .chinese,
                                isFeatured: true,
                                isPopular: false,
                                timeForDelivery: "21 min",
                                chargesForDelivery: 7,
                                address: "Central",
                                bgCover: "tai",
                                distance: 1.2)
        
        let falafal = Restaurant(id: "fala",
                                  name: "Falafel Hut",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 3.5,
                                  numberOfRater: 121,
                                  latitude: 1,
                                  longitude: 1,
                                 dishes: Dish.flafalDishes(),
                                categories: [.kebab],
                                  cusine: .middle_east,
                                isFeatured: false,
                                isPopular: true,
                                timeForDelivery: "15 min",
                                chargesForDelivery: 12,
                                address: "kennedy Town",
                                bgCover: "fala",
                                 distance: 2.0)
        
        let mac = Restaurant(id: "mac",
                                  name: "McDonalds",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 4.2,
                                  numberOfRater: 551,
                                  latitude: 1,
                                  longitude: 1,
                             dishes: Dish.macDishes(),
                                categories: [.burger],
                                  cusine: .american,
                                isFeatured: false,
                                isPopular: true,
                                timeForDelivery: "10 min",
                                chargesForDelivery: 4,
                                address: "kennedy Town",
                                bgCover: "mac",
                                 distance: 1.2)
        
        let gold = Restaurant(id: "gold",
                                  name: "Gold Thai Heng",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 3.8,
                                  numberOfRater: 166,
                                  latitude: 1,
                                  longitude: 1,
                              dishes: Dish.goldThaiDieshes(),
                               categories: [.noodles,.chicken],
                                  cusine: .thai,
                                isFeatured: false,
                                isPopular: false,
                                timeForDelivery: "10 min",
                                chargesForDelivery: 4,
                                address: "kennedy Town",
                                bgCover: "gold",
                                 distance: 1.2)
        
        let paisa = Restaurant(id: "paisa",
                                  name: "Paisano Pizzeria",
                                  description: "",
                                  addressURL: URL.taiPan,
                               ratings: 4.1,
                                  numberOfRater: 211,
                                  latitude: 1,
                                  longitude: 1,
                               dishes: Dish.paisanoDishes(),
                               categories: [.pizza],
                                  cusine: .italian,
                                isFeatured: false,
                                isPopular: false,
                                timeForDelivery: "11 min",
                                chargesForDelivery: 7,
                                address: "Central",
                                bgCover: "paisa",
                                 distance: 1.6)
        
        let sub = Restaurant(id: "sub",
                                  name: "Subway",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 4.3,
                                  numberOfRater: 499,
                                  latitude: 1,
                                  longitude: 1,
                             dishes: Dish.subwayDishes(),
                               categories: [.burger],
                                  cusine: .american,
                                isFeatured: false,
                                isPopular: true,
                                timeForDelivery: "8 min",
                                chargesForDelivery: 4,
                                address: "Kennedy Town",
                                bgCover: "sub",
                                distance: 2.0)
        
        let shake = Restaurant(id: "shake",
                                  name: "Shake Shack",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 4.0,
                                  numberOfRater: 344,
                                  latitude: 1,
                                  longitude: 1,
                               dishes: Dish.shakeDishes(),
                               categories: [.burger],
                                  cusine: .american,
                                isFeatured: true,
                                isPopular: false,
                                timeForDelivery: "18 min",
                                chargesForDelivery: 9,
                                address: "Central",
                                bgCover: "shake",
                                distance: 1.0)
        
        let clay = Restaurant(id: "clay",
                                  name: "Clay Oven",
                                  description: "",
                                  addressURL: URL.taiPan,
                                 ratings: 4.3,
                                  numberOfRater: 111,
                                  latitude: 1,
                                  longitude: 1,
                                dishes: Dish.clayOvenDishes(),
                                categories: [.indian],
                                  cusine: .middle_east,
                                 isFeatured: false,
                                isPopular: false,
                                timeForDelivery: "12 min",
                                chargesForDelivery: 11,
                                address: "Kennedy Town",
                                bgCover: "clay",
                                distance: 1.0)
        
        return [timHoWan,chariman,lungKing,yardBird,taiPan,falafal,mac,gold,paisa,sub,shake,clay]
    }
}


extension Dish {
    
    static func timHoWanDishes() -> [Dish] {
        return [Dish(name: "Baked BBQ Pork Buns",
                     calories: 320,
                     description: "Fluffy buns filled with savory BBQ pork",
                     image: "tim-0",
                     price: 10,
                     rating: 4.1,
                     numberOfRate: 100,
                     dishType: .burger),
                Dish(name: "Steamed Rice Rolls",
                     calories: 280,
                     description: "Delicate rice rolls filled with shrimp or beef",
                     image: "tim-1",
                     price: 12,
                     rating: 4.2,
                     numberOfRate: 112,
                     dishType: .burger),
                Dish(name: "Pan-Fried Turnip Cake",
                     calories: 200,
                     description: "Crispy on the outside, soft on the inside turnip cake",
                     image: "tim-2",
                     price: 12,
                     rating: 4.8,
                     numberOfRate: 112,
                     dishType: .burger),
                Dish(name: "Vermicelli Roll with Pig’s Liver in XO Sauce",
                     calories: 280,
                     description: "Thin rice noodles filled with barbecue pork",
                     image: "tim-3",
                     price: 14,
                     rating: 4.6,
                     numberOfRate: 87,
                     dishType: .burger)]
    }
    
    static func theChairman() -> [Dish] {
        return [Dish(name: "Steamed Flower Crab with Chicken, Dried Shrimp, and Glass Noodles",
                     calories: 380,
                     description: "Fresh crab steamed with aged Shaoxing wine",
                     image: "chair-0",
                     price: 11,
                     rating: 3.7,
                     numberOfRate: 200,
                     dishType: .noodles),
                Dish(name: "Wok-Fried Iberico Pork with Black Truffle Sauce",
                     calories: 450,
                     description: "Premium pork cooked in a traditional Chinese wok",
                     image: "chair-1",
                     price: 18,
                     rating: 3.9,
                     numberOfRate: 82,
                     dishType: .burger),
                Dish(name: "Red-Braised Pork Belly",
                     calories: 320,
                     description: "Slow-cooked pork belly in soy sauce and spices",
                     image: "chair-2",
                     price: 10,
                     rating: 3.1,
                     numberOfRate: 112,
                     dishType: .burger)]
    }
    
    static
    func theLungKing() -> [Dish] {
        return [Dish(name: "Barbecued Pork",
                     calories: 280,
                     description: "Sweet and savory roasted pork",
                     image: "lung-0",
                     price: 20,
                     rating: 3.0,
                     numberOfRate: 87,
                     dishType: .burger),
                Dish(name: "Double-Boiled Fish Maw Soup",
                     calories: 220,
                     description: "Delicate soup made from fish maw and Chinese herbs",
                     image: "lung-1",
                     price: 18,
                     rating: 4.7,
                     numberOfRate: 192,
                     dishType: .burger),
                Dish(name: "Sauteed Lobster and Scallop",
                     calories: 380,
                     description: "Fresh seafood sautéed to perfection",
                     image: "lung-2",
                     price: 14,
                     rating: 4.7,
                     numberOfRate: 123,
                     dishType: .burger),
                Dish(name: "Fried Rice with Wagyu Beef",
                     calories: 450,
                     description: "Flavorful fried rice with premium Wagyu beef",
                     image: "lung-3",
                     price: 19,
                     rating: 4.9,
                     numberOfRate: 143,
                     dishType: .burger),
                Dish(name: "Braised Whole Abalone",
                     calories: 320,
                     description: "Tender abalone braised in a rich sauce",
                     image: "lung-4",
                     price: 21,
                     rating: 4.9,
                     numberOfRate: 81,
                     dishType: .burger)
        ]
    }
    
    static
    func yardBud() -> [Dish] {
        return [Dish(name: "Korean Fried Cauliflower",
                     calories: 320,
                     description: "Crispy cauliflower tossed in spicy Korean sauce",
                     image: "yard-0",
                     price: 10,
                     rating: 4.1,
                     numberOfRate: 102,
                     dishType: .burger),
                Dish(name: "KFC (Korean Fried Chicken)",
                     calories: 380,
                     description: "Crispy fried chicken glazed in sweet and spicy sauce",
                     image: "yard-1",
                     price: 12,
                     rating: 4.1,
                     numberOfRate: 23,
                     dishType: .burger),
                Dish(name: "Chicken Meatball Yakitori",
                     calories: 250,
                     description: "Grilled chicken meatballs on skewers",
                     image: "yard-2",
                     price: 12,
                     rating: 4.8,
                     numberOfRate: 54,
                     dishType: .burger),
                Dish(name: "Pork Belly and Kimchi",
                     calories: 420,
                     description: "Succulent pork belly served with tangy kimchi",
                     image: "yard-3",
                     price: 14,
                     rating: 4.5,
                     numberOfRate: 34,
                     dishType: .burger),
                Dish(name: "Chicken Liver Yakitori",
                     calories: 180,
                     description: "Skewered chicken liver grilled to perfection",
                     image: "yard-4",
                     price: 10,
                     rating: 3.9,
                     numberOfRate: 88,
                     dishType: .burger)
        ]
    }
    
    static
    func theThaiPan() -> [Dish] {
        return [Dish(name: "Peking Duck",
                     calories: 1,
                     description: "Crispy duck served with thin pancakes and hoisin sauce",
                     image: "tai-0",
                     price: 12,
                     rating: 4.1,
                     numberOfRate: 123,
                     dishType: .noodles),
                Dish(name: "Dim Sum Platter",
                             calories: 1,
                             description: "Assortment of steamed and fried dim sum",
                             image: "tai-1",
                             price: 22,
                             rating: 4.5,
                             numberOfRate: 12,
                             dishType: .noodles),
                Dish(name: "Seafood Bird's Nest Soup",
                             calories: 1,
                             description: "Rich soup with seafood and bird's nest",
                             image: "tai-2",
                             price: 25,
                             rating: 4.1,
                             numberOfRate: 33,
                             dishType: .noodles),
                Dish(name: "Lobster with Ginger and Spring Onion",
                             calories: 1,
                             description: "Lobster cooked with ginger in a savory sauce",
                             image: "tai-3",
                             price: 11,
                             rating: 4.3,
                             numberOfRate: 55,
                             dishType: .noodles)]
    }
    
    
    static
    func flafalDishes() -> [Dish] {
        let array = [Dish(name: "Falafel Roll",
                          calories: 325,
                          description: "Roll filled with falafel, a flavorful blen of ground chickepeas and herbs.",
                          image: "fala-0",
                          price: 23,
                          rating: 4.1,
                          numberOfRate: 100,
                          dishType: .burger),
                     Dish(name: "Chicken Roll",
                          calories: 400,
                          description: "A roll packed with tender, marinated chicken pieces, typically served with an assortment of fresh vegetables and a creamy sauce.",
                          image: "fala-1",
                          price: 26,
                          rating: 4.5,
                          numberOfRate: 88,
                          dishType: .burger),
                     Dish(name: "Lamb Roll",
                          calories: 375,
                          description: "A roll featuring succulent, spiced lamb meat, often combined with fresh veggies and a rich sauce, giving it a distinct Mediterranean feel.",
                          image: "fala-2",
                          price: 28,
                          rating: 3.7,
                          numberOfRate: 66,
                          dishType: .burger),
                     Dish(name: "Vegetable Roll",
                           calories: 280,
                           description: "A roll filled with a variety of fresh, crunchy vegetables, often garnished with a light dressing, making it a perfect choice for vegetarians and health-conscious individuals.",
                           image: "fala-3",
                           price: 24,
                          rating: 4.2,
                           numberOfRate: 90,
                           dishType: .burger)
                     
                      ]
        return array
    }
    
    static
    func macDishes() -> [Dish] {
        let array = [Dish(name: "McChicken Burger",
                          calories: 300,
                          description: "A popular fast-food staple featuring a crispy, breaded chicken patty, topped with fresh lettuce and creamy mayonnaise, all nestled within a lightly toasted sesame bun.",
                          image: "mac-0",
                          price: 14,
                          rating: 4.6,
                          numberOfRate: 178,
                          dishType: .burger),
                     Dish(name: "Filet-o-fish ",
                           calories: 270,
                           description: "A unique seafood offering with a tender fish fillet that's lightly breaded and fried, topped with tangy tartar sauce, and served on a soft, steamed bun.",
                           image: "mac-1",
                           price: 13,
                          rating: 4.4,
                           numberOfRate: 150,
                           dishType: .burger),
        
                     Dish(name: "Ham N' Cheese Burger",
                         calories: 280 ,
                         description: "A delicious combination of smoky ham and melted cheese on a beef patty, complemented by various toppings and condiments, served in a toasted bun for a satisfyingly savory experience.",
                         image: "mac-2",
                         price: 17,
                          rating: 4.3,
                         numberOfRate: 123,
                         dishType: .burger),
        
                     Dish(name: "Sausage McMuffin",
                         calories: 320,
                         description: "A hearty breakfast sandwich with a savory, grilled sausage patty, a slice of melty American cheese, and a freshly cracked egg, all sandwiched between the halves of a warm, toasted English muffin.",
                         image: "mac-3",
                         price: 14,
                          rating: 3.9,
                         numberOfRate: 99,
                         dishType: .burger),
                     
                     Dish(name: "French Fries (Large)",
                         calories: 420,
                         description: "A quintessential side dish, these are thinly sliced potatoes that are deep-fried until golden and crispy, then lightly salted, providing a perfect balance of fluffy interior and crunchy exterior.",
                         image: "mac-4",
                         price: 20,
                          rating: 4.4,
                         numberOfRate: 189,
                         dishType: .burger)
        ]
        return array
    }
    
    static
    func goldThaiDieshes() -> [Dish] {
        let array = [
            Dish(name: "Fried Flat Noodle with Pork",
                calories: 300,
                description: "Savory flat noodles stir-fried to perfection, complemented by tender and flavorful pork.",
                image: "gold-0",
                price: 23,
                 rating: 4.1,
                numberOfRate: 45,
                dishType: .burger),
            
            Dish(name: "Red Curry Pork with Rice",
                calories: 420,
                description: "Succulent pork cooked in a rich and aromatic red curry sauce, served with fragrant rice for a satisfying meal.",
                image: "gold-1",
                price: 26,
                 rating: 3.8,
                numberOfRate: 24,
                dishType: .burger),
            
            Dish(name: "Green Curry Chicken with Rice",
                calories: 380,
                description: " Tender chicken simmered in a creamy green curry sauce, paired with fluffy rice for a delightful Thai culinary experience.",
                image: "gold-2",
                price: 26,
                 rating: 4.5,
                numberOfRate: 56,
                dishType: .burger),
            
            Dish(name: "Fried Thai Noodle with Chicken",
                calories: 330 ,
                description: "A delicious combination of stir-fried Thai noodles and tender chicken, creating a flavorful and satisfying dish.",
                image: "gold-3",
                price: 25,
                 rating: 4.0,
                numberOfRate: 90,
                dishType: .burger),
            
            Dish(name: "Thai Suki Soup",
                calories: 250,
                description: "A comforting and nourishing Thai soup filled with a variety of meats, vegetables, and aromatic flavors, perfect for warming up on a chilly day.",
                image: "gold-4",
                price: 19,
                 rating: 3.6,
                numberOfRate: 76,
                dishType: .burger)
        ]
        return array
    }
    
    static
    func paisanoDishes() -> [Dish] {
        let array = [
            
            Dish(name: "Cheese Pizza",
                calories: 270,
                description: "A classic pizza topped with a generous layer of melted cheese, offering a simple yet delicious flavor.",
                image: "paisa-0",
                price: 19,
                 rating: 4.3,
                numberOfRate: 88,
                dishType: .burger),
            
            Dish(name: "Margherita Pizza",
                calories: 300,
                description: "A traditional Italian pizza topped with fresh tomatoes, mozzarella cheese, and basil, known for its simplicity and vibrant flavors.",
                image: "paisa-1",
                price: 15,
                 rating: 4.8,
                numberOfRate: 50,
                dishType: .burger),
            
            Dish(name: "Vegetarian Pizza",
                calories: 250,
                description: "A pizza loaded with a variety of vegetables like bell peppers, onions, mushrooms, olives",
                image: "paisa-2",
                price: 17,
                 rating: 4.0,
                numberOfRate: 23,
                 dishType: .burger),
            Dish(name: "Pepperoni Pizza",
                calories: 320,
                description: "A popular choice, featuring a savory combination of tomato sauce, melted cheese, and slices of spicy pepperoni, delivering a satisfying and slightly spicy taste.",
                image: "paisa-3",
                price: 18,
                 rating: 3.9,
                numberOfRate: 66,
                dishType: .burger),
            
            Dish(name: "Bacon Cheeseburger Pizza",
                calories: 340,
                description: " Inspired by the classic American cheeseburger, this pizza combines ground beef, bacon, cheese, and sometimes even pickles and onions, resulting in a unique and mouthwatering flavor fusion.",
                image: "paisa-4",
                price: 18,
                 rating: 4.8,
                numberOfRate: 100,
                dishType: .burger)
        ]
        
        return array
    }
    
    static
    func subwayDishes() -> [Dish] {
        
        let array = [
            
            
            Dish(name: "Spicy Italian",
                calories: 238,
                description: " A zesty combination of spicy pepperoni and flavorful salami, topped with melted cheese and a blend of tangy Italian herbs, all sandwiched in a freshly baked sub roll.",
                image: "sub-0",
                price: 23,
                 rating: 4.5,
                numberOfRate: 100,
                dishType: .burger),
            
            Dish(name: "Turkey Breast",
                calories: 309,
                description: "Tender and lean turkey slices, piled high on your choice of bread, complemented with crisp lettuce, juicy tomatoes, and a hint of mayo for a light and satisfying meal.",
                image: "sub-1",
                price: 23,
                 rating: 4.3,
                numberOfRate: 30,
                dishType: .burger),
            
            Dish(name: "Roast Chicken",
                calories: 312,
                description: "Succulent slices of roasted chicken, seasoned to perfection and served with a medley of fresh vegetables, creating a comforting and hearty sandwich that will leave you wanting more.",
                image: "sub-2",
                price: 25,
                 rating: 3.9,
                numberOfRate: 40,
                dishType: .burger),
            
            Dish(name: "Chicken Teriyaki",
                calories: 278,
                description: "Grilled chicken glazed with a sweet and savory teriyaki sauce, paired with a mix of crunchy vegetables and served in a soft bun, providing a delightful blend of flavors.",
                image: "sub-3",
                price: 25,
                 rating: 4.1,
                numberOfRate: 35,
                dishType: .burger),
            
            Dish(name: "Vegan Supreme",
                calories: 211,
                description: "A vibrant vegetarian delight packed with a variety of fresh and colorful veggies, including crisp lettuce, juicy tomatoes, crunchy cucumbers, and tangy pickles, all nestled between two slices of bread for a satisfying and healthy option.",
                image: "sub-4",
                price: 20,
                 rating: 4.2,
                numberOfRate: 54,
                dishType: .burger)
        ]
        
        return array
    }
    
    
    static
    func shakeDishes() -> [Dish] {
        
        let array = [
            
            
            Dish(name: "Shack Burger",
                calories: 295,
                description: "Cheeseburger with lettuce, tomato and ShackSauce",
                image: "shake-1",
                price: 24,
                 rating: 4.0,
                numberOfRate: 30,
                dishType: .burger),
            
            Dish(name: "Shroom Burger",
                calories: 215,
                description: "Crisp-fried portabella mushroom filled with melted muenster and cheddar cheed, topped with lettuce, tomato and ShackSauce",
                image: "shake-0",
                price: 26,
                 rating: 3.6,
                numberOfRate: 90,
                dishType: .burger),
            
            Dish(name: "Chick'n Shack",
                calories: 245,
                description: "Crispy chicken breast with lettuce, pickles, buttermilk herb mayo",
                image: "shake-2",
                price: 25,
                 rating: 3.9,
                numberOfRate: 60,
                dishType: .burger),
            
            Dish(name: "Smoke Shack",
                calories: 220,
                description: "Cheeseburger with all natural smoked Niman Ranch bacon, chopped cherry pepper and ShackSauce",
                image: "shake-3",
                price: 28,
                 rating: 4.3,
                numberOfRate: 30,
                dishType: .burger),
            
            Dish(name: "Hamburger",
                calories: 285,
                description: "A classic Ham on a Burger with lettuce, tomato, pickle or onion",
                image: "shake-4",
                price: 30,
                 rating: 4.2,
                numberOfRate: 26,
                dishType: .burger)
            
        ]
        return array
    }
    
    static
    func clayOvenDishes() -> [Dish] {
        
        let array = [
            
            Dish(name: "Chicken Butter Masala",
                calories: 627,
                description: "Tender chicken cooked in a rich and creamy tomato-based gravy, infused with aromatic spices and a touch of butter, resulting in a flavorful and indulgent dish that pairs perfectly with naan or rice.",
                image: "clay-0",
                price: 35,
                 rating: 4.3,
                numberOfRate: 130,
                dishType: .burger),
            
            Dish(name: "Saag Paneer",
                calories: 599,
                description: "A classic North Indian dish made with fresh spinach and chunks of paneer (Indian cottage cheese), delicately seasoned with spices, creating a wholesome and nutritious vegetarian option that is both comforting and satisfying.",
                image: "clay-1",
                price: 30,
                 rating: 4.5,
                numberOfRate: 40,
                dishType: .burger),
            
            Dish(name: "Chana Masala",
                calories: 428,
                description: "A popular vegetarian dish made with chickpeas simmered in a flavorful blend of spices, onions, and tomatoes, resulting in a hearty and tangy curry that is perfect with rice or naan.",
                image: "clay-2",
                price: 28,
                 rating: 4.8,
                numberOfRate: 30,
                dishType: .burger),
            
            Dish(name: "Chicken Tikka Masala",
                calories: 636,
                description: "Tender pieces of marinated chicken, grilled to perfection and simmered in a creamy tomato-based sauce, infused with a blend of aromatic spices, creating a mouthwatering dish that is a favorite in Indian cuisine.",
                image: "clay-3",
                price: 35,
                 rating: 4.4,
                numberOfRate: 50,
                dishType: .burger),
            
            Dish(name: "Lamb Korma",
                calories: 357,
                description: "Succulent chunks of lamb cooked in a rich and aromatic gravy, featuring a blend of spices, yogurt, and cream, resulting in a luxurious and flavorful dish that is best enjoyed with naan or fragrant rice.",
                image: "clay-4",
                price: 33,
                 rating: 4.1,
                numberOfRate: 90,
                dishType: .burger),
            
            Dish(name: "Paneer Chilli",
                calories: 358,
                description: "Cubes of paneer (Indian cottage cheese) stir-fried with colorful bell peppers, onions, and a tangy chili sauce, creating a spicy and savory Indo-Chinese fusion dish that is both satisfying and full of flavor.",
                image: "clay-5",
                price: 30,
                 rating: 4.0,
                numberOfRate: 35,
                dishType: .burger),
            
            Dish(name: "Dal Makhani",
                calories: 258,
                description: " A creamy and comforting lentil dish made with a mixture of black lentils and kidney beans, slow-cooked with spices, butter, and cream, resulting in a delicious and hearty vegetarian option that pairs well with rice or naan.",
                image: "clay-6",
                price: 28,
                 rating: 3.9,
                numberOfRate: 79,
                dishType: .burger)
        ]
        return array
        
    }
    
    
}


extension URL {
    static let timHoWan = URL(string: "https://maps.apple.com/?address=International%20Finance%20Centre,%201%20Harbour%20View%20St,%20Central,%20Hong%20Kong%20SAR,%20China&auid=4941141349138445120&ll=22.284755,114.157938&lsp=9902&q=Tim%20Ho%20Wan&t=m")!
    
    static let chariman = URL(string: "https://maps.apple.com/?address=The%20Wellington,%20198%20Wellington%20St,%20Central,%20Hong%20Kong%20SAR,%20China&auid=17100252830542940874&ll=22.284893,114.152940&lsp=9902&q=The%20Chairman&t=m")!
    
    static let lungKing = URL(string: "https://maps.apple.com/?address=4%20Finance%20St,%20Central,%20Hong%20Kong%20SAR,%20China&auid=8211688309474440271&ll=22.285159,114.158841&lsp=9902&q=Lung%20King%20Heen&t=m")!
    
    static let yardBird = URL(string: "https://maps.apple.com/?address=154-158%20Wing%20Lok%20St,%20Sheung%20Wan,%20Hong%20Kong%20SAR,%20China&auid=4430579888579564089&ll=22.287414,114.149194&lsp=9902&q=Yardbird&t=m")!
    
    static let taiPan = URL(string: "https://maps.apple.com/?address=22%20Cotton%20Tree%20Drive,%20Central,%20Hong%20Kong%20SAR,%20China&auid=1847326606465472158&ll=22.278087,114.160102&lsp=9902&q=The%20Tai%20Pan&t=m")!
}

