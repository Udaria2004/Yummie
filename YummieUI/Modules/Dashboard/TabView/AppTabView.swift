
import SwiftUI

struct AppTabView: View {
    
    @State var selectedTab = 0
    @StateObject var favVm = FavoriteViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                    .environmentObject(favVm)
            }
            .tag(0)
            .tabItem {
                Image(selectedTab == 0 ? "home-tab-s" : "home-tab-u")
            }
            
            
            NavigationView {
                ChatView()
                    .navigationTitle("Virtual Assistant")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tag(1)
            .tabItem {
                Image(selectedTab == 1 ? "chat-tab-s" : "chat-tab-u")
            }
            
            
            NavigationView {
                FavoriteView()
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(favVm)
            }
            .tag(2)
            .tabItem {
                Image(selectedTab == 2 ? "heart-tab-s" : "heart-tab-u")
            }
            
            
            
            NavigationView {
                OrderView()
                    .navigationTitle("Orders")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tag(3)
            .tabItem {
                Image(selectedTab == 3 ? "order-tab-s" : "order-tab-u")
            }
            
        }
    }
}

#Preview {
    AppTabView()
}
