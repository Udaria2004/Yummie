
import SwiftUI

struct CategoryRestaurantsView: View {
    
    var category:Category
    
    @State var restaurents:[Restaurant] = []
    @State var visibility:Visibility = .automatic
    @EnvironmentObject var favVm:FavoriteViewModel
    var body: some View {
        List {
            ForEach(restaurents, id: \.id) { restaurent in
                NavigationLink {
                    RestaurantView(restaurent: restaurent)
                        .environmentObject(favVm)
                } label: {
                    QuickPickCell(restaurent: restaurent, isFav: favVm.isFav(rest: restaurent),onChangeFav: {
                        favVm.updateFav(rest: restaurent)
                    })
                        .frame(width: width,height: 175)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("\(category.title)'s Restaurant")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            restaurents = Restaurant.allData().filter({$0.categories.contains(category)})
            withAnimation {
                visibility = .hidden
            }
        }
        .toolbar(visibility, for: .tabBar)
        .onDisappear {
            withAnimation {
                visibility = .visible
            }
        }
    }
    
    
}

