
import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject var vm  = LocationViewModel()
    @State var visibility:Visibility = .automatic
    
    var body: some View {
        Map(coordinateRegion: $vm.region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
            .toolbar(visibility, for: .tabBar)
            .onAppear {
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
}
