
import SwiftUI

class FavoriteViewModel:ObservableObject {
    
    let coreDatamanager = CoreDataManager.shared
    @Published var allFavResturants:[Restaurant] = []
    
    init() {
        getAllFavs()
    }
}

extension FavoriteViewModel {
    
    private
    func getAllFavs() {
        coreDatamanager.allFavRestsIds.forEach { id in
            if let restaurent = Restaurant.allData().first(where: {$0.id == id}) {
                allFavResturants.append(restaurent)
            }
        }
    }
    
    func updateFav(rest:Restaurant) {
        if let index = allFavResturants.firstIndex(where: {$0.id == rest.id}) {
            allFavResturants.remove(at: index)
        } else {
            allFavResturants.append(rest)
        }
        coreDatamanager.updateFav(restrntId: rest.id)
    }
    
    func isFav(rest:Restaurant) -> Bool {
        return allFavResturants.contains(where: {$0.id == rest.id})
    }
}

