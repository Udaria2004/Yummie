
import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var vm:FavoriteViewModel
    var body: some View {
        if vm.allFavResturants.isEmpty {
            VStack {
                Image("brokenhart")
                Text("You have no Favourites")
                    .poppins(size: 16, weight: .semibold)
            }
        } else {
            List {
                ForEach(vm.allFavResturants, id: \.id) { restaurent in
                    NavigationLink {
                        RestaurantView(restaurent: restaurent)
                            .environmentObject(vm)
                    } label: {
                        FavCell(restaurent: restaurent,isFav: vm.isFav(rest: restaurent), onChangeFav: {
                            vm.updateFav(rest: restaurent)
                        })
                            .frame(width: width,height: 175)
                    }
                }
            }
            .listStyle(.grouped)
        }
       
    }
}


//Quick
struct FavCell:View {
    
    var restaurent:Restaurant
    var isFav:Bool
    var onChangeFav:(() -> ())?
    var body: some View {
        HStack {
            Image(restaurent.bgCover)
                .resizable()
                .scaledToFill()
                .frame(width: 122, height: 150, alignment: .center)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(restaurent.name)
                    .poppins(size:18,weight: .medium)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.colorPrimary)
                    Text("\(restaurent.ratings.toStringWithDecimal()) (\(restaurent.numberOfRater)+) . \(restaurent.timeForDelivery)")
                        .poppins(size:14,weight: .medium)
                }
                Text(restaurent.cusine.title)
                    .poppins(size:16,weight: .regular)
                    .opacity(0.7)
                Text(restaurent.address)
                    .poppins(size:14,weight: .regular)
                    .opacity(0.5)
                
            }
            Spacer()
            Button {
                onChangeFav?()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 23)
                        .opacity(0.33)
                        .frame(width: 46, height: 46, alignment: .center)
                    Image("heart-tab-u")
                        .renderingMode(.template)
                        .foregroundStyle(isFav ? Color.red : Color.white)
                }
                .frame(width: 46, height: 46, alignment: .center)
                
            }
            .buttonStyle(.plain)
            .padding(.bottom,100)
        }
        .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
//        .padding(.horizontal)
    }
    
}


#Preview {
    FavoriteView()
}
