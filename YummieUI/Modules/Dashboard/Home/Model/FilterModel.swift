
import Foundation


struct FilterModel {
    let title:String
    let cousines:[Cousine]
    let dishes:[DishType]
    let sorts:[SortOfferDietry]
    
    init(title: String, cousines: [Cousine], dishes: [DishType], sorts: [SortOfferDietry]) {
        self.title = title
        self.cousines = cousines
        self.dishes = dishes
        self.sorts = sorts
    }
   
}

enum SortOfferDietry:Int,CaseIterable  {
    case sort
    case offers
    case dietary
    
    var title:String {
        return String(describing: self).capitalized
    }
    
    var icon:String {
        return String(describing: self) + "-icon"
    }
}
enum Cousine:Int,CaseIterable {
    case american
    case italian
    case middle_east
    case thai
    case chinese
    case japenese
    case korean
  
    
    var title:String {
        let name = String(describing: self)
        let compnnts = name.components(separatedBy: "_")
        var _name = ""
        compnnts.forEach { n in
            _name += "\(n.capitalized) "
        }
        return _name
    }
}

enum DishType:Int,CaseIterable {
    
//    case alcohol
//    case bbq
//    case bakery
//    case bento
    case burgers
//    case cakes
//    case chicken
//    case coffee
//    case curry
//    case desert
//    case grill
    case noodles
//    case pasta
    case pizza
//    case salads
    case kebab
    case indian
    
    var title:String {
        let name = String(describing: self)
      
            let compnnts = name.components(separatedBy: "_")
            var _name = ""
            compnnts.forEach { n in
                _name += "\(n.capitalized) "
            }
            return _name
      
    }
}

enum Category:Int,CaseIterable {
    
    case burger
    case pizza
//    case chicken
//    case coffee
    case noodles
//    case salads
//    case sushi
    case indian
//    case pasta
    case kebab
    case chicken
    case chinese
//    case thai
//    case korean
    
    var icon:String {
        return "c-\(self.rawValue)"
    }
    
    var title:String {
        return String(describing: self).capitalized
    }
}
