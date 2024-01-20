
import SwiftUI

class HomeViewModel:ObservableObject {
    
    let coreDatamanager = CoreDataManager.shared
    let locationManager = LocationManager.shared
    
    @Published var content:HomeModel!
    @Published var accountModel:[AccountModel] = []
    @Published var cartDishes:[Dish] = []
    
    @Published var allFavResturants:[Restaurant] = []
   
    @Published var filters:[Cousine] = [] {
        didSet {
            let fullModel = HomeModel.all()
            content.quickPics = fullModel.quickPics.filter({filters.contains($0.cusine)})
            content.populars = fullModel.populars.filter({filters.contains($0.cusine)})
            content.featureds = fullModel.featureds.filter({filters.contains($0.cusine)})
        }
    }
    
    @Published var locationText = "Getting Location..."
    @Published var isLocationEnable = false
    
    init() {
        content = HomeModel.all()
        accountModel = AccountModel.all()
        filters = Cousine.allCases
        locationManager.requestLocation()
        locationManager.onLocationUpdate = { location in
            self.isLocationEnable = true
            self.locationManager.getAddressFromLocation(location: location) { address in
                self.locationText = address ?? "Location..."
            }
        }
        locationManager.onPermissionDenied = {
            self.locationText = "Enable Location"
            self.isLocationEnable = false
        }
        getAllFavs()
    }
}

extension HomeViewModel {
    
    func getAllFavs() {
        coreDatamanager.allFavRestsIds.forEach { id in
            if let restaurent = Restaurant.allData().first(where: {$0.id == id}) {
                allFavResturants.append(restaurent)
            }
        }
    }
    
    func updateFav() {
        allFavResturants
    }
}
