
import SwiftUI

struct SearchRestaurantView: View {
    
    @State private var searchText = ""
    @State var items:[Restaurant] = []
    @State var visibility:Visibility = .automatic
    @EnvironmentObject var favMm:FavoriteViewModel
    var filteredItems: [Restaurant] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        List {
                ForEach(filteredItems, id: \.id) { restaurent in
                    NavigationLink {
                        RestaurantView(restaurent: restaurent)
                            .environmentObject(favMm)
                    } label: {
                        QuickPickCell(restaurent: restaurent, isFav: favMm.isFav(rest: restaurent),onChangeFav: {
                            favMm.updateFav(rest: restaurent)
                        })
                            .frame(width: width,height: 175)
                    }
                    .buttonStyle(.plain)
                }
        }
        .listStyle(.grouped)
        .navigationTitle("Search Restaurant")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(visibility, for: .tabBar)
        .toolbar(content: {
            ToolbarItem(placement: .principal) { //<------------
                    searchBar
                }
        })
        .onAppear {
            items = Restaurant.allData()
            withAnimation {
                visibility = .hidden
            }
        }
        .onDisappear {
            withAnimation {
                visibility = .visible
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            TextField("Search Restaurant...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRestaurantView()
    }
}

