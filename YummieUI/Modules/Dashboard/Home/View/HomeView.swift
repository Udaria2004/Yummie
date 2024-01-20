
import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @EnvironmentObject var favVm:FavoriteViewModel
    
    var body: some View {
        GeometryReader { proxy in
                List {
                    Section {
                        AdContentView(images: vm.content.advertise.map({$0.icon}))
                            .frame(width: width,height: 170,alignment: .center)
                            .listRowSeparator(.hidden)
                        CategoryContentView(categories: vm.content.categories)
                            .frame(width: width,height: 100,alignment: .center)
                            .listRowSeparator(.hidden)
                            .environmentObject(favVm)
                        PopularContentView(populars: vm.content.populars)
                            .frame(width: width,height: 190,alignment: .center)
                            .listRowSeparator(.hidden)
                            .environmentObject(favVm)
                        FeatureContentView(featured: vm.content.featureds)
                            .frame(width: width,height: 195,alignment: .center)
                            .listRowSeparator(.hidden)
                            .environmentObject(favVm)
                        HStack {
                            Text("Quick Picks")
                                .poppins(size: 12, weight: .semibold)
                                .frame(height: 20,alignment: .bottom)
                                .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
                            Spacer()
                        }
                        .frame(width: width)
                        ForEach(vm.content.quickPics,id: \.id) { quickPick in
                            NavigationLink {
                                RestaurantView(restaurent: quickPick)
                                    .environmentObject(favVm)
                            } label: {
                                QuickPickCell(restaurent: quickPick,isFav: favVm.allFavResturants.contains(where: {$0.id == quickPick.id}),onChangeFav: {
                                    favVm.updateFav(rest: quickPick)
                                })
                                    .frame(width: width,height: 175)
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                    } header: {
                        LocationContentView(vm: vm, locationText: $vm.locationText)
                            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                            .frame(width: width,height: 140 + safeArea.top)
                            .environmentObject(favVm)
                    }
                    
                }
                .listStyle(.grouped)
                Spacer()
            
//            .frame(width: width,height: height)
            .onAppear {
//              let tableHeaderView = UIView(frame: .zero)
//              tableHeaderView.frame.size.height = 1
//              UITableView.appearance().tableHeaderView = tableHeaderView
              UITableView.appearance().sectionHeaderTopPadding = 0
              UITableView.appearance().contentInset = .zero
            }
        }
        .ignoresSafeArea()
        
        
    }
}

struct LocationContentView: View {
    
    var vm:HomeViewModel
    @Binding var locationText:String
    @EnvironmentObject var favVm:FavoriteViewModel
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.white
                VStack(alignment: .leading,spacing: 0) {
                    Spacer().frame(height: safeArea.top)
                    HStack {
                        NavigationLink {
                            MapView()
                        } label: {
                            Image("location-icon")
                            VStack(alignment: .leading,spacing: 4) {
                                Text("Deliver To")
                                    .poppins(size: 10,weight: .regular)
                                    .opacity(0.5)
                                HStack(spacing: 5) {
                                    Text(vm.locationText)
                                        .poppins(size: 10,weight: .regular)
                                    Image("chev.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 12)
                                }
                            }
                            .padding(.leading,10)
                        }
                        .buttonStyle(.plain)
                        Spacer()
                        NavigationLink {
                            AccountView()
                                .environmentObject(vm)
                        } label: {
                            Image("user-icon")
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 26)
                    Spacer().frame(height: 20)
                   
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Welcome Back")
                            .poppins(size: 16,weight: .semibold)
                            .padding(.leading,8)
                        RoundedRectangle(cornerRadius: 22)
                            .foregroundStyle(Color.white)
                            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                            .overlay {
                                HStack {
                                    NavigationLink {
                                        SearchRestaurantView()
                                            .environmentObject(favVm)
                                    } label: {
                                        Image("search-icon")
                                        Text("Search for your favourite food..")
                                            .opacity(0.5)
                                    }.buttonStyle(.plain)
                                    Spacer()
                                    NavigationLink {
                                        FilterView()
                                            .environmentObject(vm)
                                    } label: {
                                        Image("filter-icon")
                                            .frame(width: 44,height: 44)
                                    }.buttonStyle(.plain)
                                   
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 44)
                    }
                }
                .padding()
            }
            
        }
        
        
    }
    
}

struct AdContentView:View {
    
    var images:[String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 0) { // Adjust spacing between items as needed
                ForEach(images,id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 274, height: 137) // Adjust width as needed
                        .cornerRadius(24)
                        .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
                }
            }
            
        }
    }
}




//Categories
struct CategoryContentView:View {
    
    var categories:[Category]
    @EnvironmentObject var favvm:FavoriteViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Categories")
                    .poppins(size: 12, weight: .semibold)
                Spacer()
                Button {
                    
                } label: {
                    Text("View All")
                        .poppins(size: 10, weight: .regular)
                        .foregroundStyle(Color.black)
                }
                
            }
            .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            .frame(height: 20)
           
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 14) { // Adjust spacing between items as needed
                    ForEach(categories,id: \.self) { category in
                        NavigationLink {
                            CategoryRestaurantsView(category: category)
                                .environmentObject(favvm)
                        } label: {
                            CategoryIconView(category: category)
                                .frame(width: 69, height: 80)
                        }.buttonStyle(.plain)
                        
                    }
                    
                }
                .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            }
           
            .frame(width: width,height: 80)
           
        }
       
    }
}

struct CategoryIconView:View {
    
    var category:Category
    
    var body: some View {
        VStack {
            Image(category.icon)
            Text(category.title)
                .poppins(size: 10, weight: .regular)
        }
        .frame(width: 69,height: 69)
        .background(content: {
            Color.white
                .frame(width: 69,height: 69)
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 3, y: 3)
        })
    }
}




//Popular
struct PopularContentView:View {
    
    var populars:[Restaurant]
    var onSelect:((Restaurant) -> ())?
    @EnvironmentObject var favVm:FavoriteViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("Popular Today")
                .poppins(size: 12, weight: .semibold)
                .frame(height: 20)
                .padding(.bottom,6)
                .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 14) { // Adjust spacing between items as needed
                    ForEach(populars,id: \.id) { restrant in
                        NavigationLink {
                            RestaurantView(restaurent: restrant)
                                .environmentObject(favVm)
                        } label: {
                            PopularCell(restaurent: restrant)
                                .frame(width: 275, height: 142)
                                .cornerRadius(20)
                        }
                        .buttonStyle(.plain)
                    }
                    
                }
                
            }
            .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            .frame(width: width,height: 142)
        }
        
    }
    
}

struct PopularCell:View {
    
    var restaurent:Restaurant
    var body: some View {
        ZStack {
            Image(restaurent.bgCover)
                .resizable()
                
                .scaledToFill()
            VStack(alignment: .leading) {
               Spacer()
                VStack(alignment: .leading) {
                    Text(restaurent.name)
                        .poppins(size: 16, weight: .semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 240,alignment: .leading)
                        .padding(.horizontal)
                    Text(restaurent.cusine.title)
                        .poppins(size: 14, weight: .regular)
                        .foregroundStyle(Color.white)
                        .frame(width: 240,alignment: .leading)
                        .padding(.horizontal)
                }
                .padding()
                .background(content: {
                    Rectangle()
                        .frame(width: 275,height: 79)
                        .foregroundStyle(Color.black.opacity(0.44))
                })
            }.frame(width: 275,height: 142,alignment: .bottom)
            
        }
        
    }
}





//Featured
struct FeatureContentView:View {
    
    var featured:[Restaurant]
    var onSelect:((Restaurant) -> ())?
    @EnvironmentObject var favVm:FavoriteViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("Featured Restaurants")
                .poppins(size: 12, weight: .semibold)
                .frame(height: 20)
                .padding(.bottom,6)
                .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 14) { // Adjust spacing between items as needed
                    ForEach(featured,id: \.id) { restrant in
                        
                        NavigationLink {
                            RestaurantView(restaurent: restrant)
                                .environmentObject(favVm)
                        } label: {
                            FeatureCell(restaurent: restrant)
                                .frame(width: 144, height: 150)
                        }
                        .buttonStyle(.plain)
                    }
                    
                }
                .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
            }
            
            .frame(width: width,height: 142)
        }
    }
    
}

struct FeatureCell:View {
    
    var restaurent:Restaurant
    var body: some View {
        VStack {
            Image(restaurent.bgCover)
                .resizable()
                .scaledToFill()
                .frame(width: 134,height: 84)
                .cornerRadius(12)
            Text(restaurent.name)
                .euclardCircular(size: 12, weight: .medium)
            Text("$$ . \(restaurent.cusine.title) . \(restaurent.address)")
                .euclardCircular(size: 9, weight: .regular)
                .opacity(0.5)
            HStack {
                Text(restaurent.ratings.toStringWithDecimal())
                    .poppins(size: 9, weight: .semibold)
                    .foregroundStyle(.white)
                    .background {
                        Color.color7747FF
                            .frame(width: 23, height: 15)
                            .cornerRadius(4)
                    }
                    .frame(width: 23, height: 15)
                Text("Charges: $\(restaurent.chargesForDelivery.toStringWithDecimal()) - \(restaurent.timeForDelivery)")
                    .euclardCircular(size: 9, weight: .regular)
                    .opacity(0.75)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
        }
    }
}


//Quick
struct QuickPickCell:View {
    
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
                        .opacity(0.5)
                        .frame(width: 46, height: 46, alignment: .center)
                    Image("heart-tab-u")
                        .renderingMode(.template)
                        .foregroundStyle(isFav ? Color.red : Color.white)
                }
                .frame(width: 46, height: 46, alignment: .center)
                
            }
            .buttonStyle(.plain)
            .padding(.bottom,100)
            .opacity(0)
        }
        .conditionalPadding(paddingForiOS17: 14, defaultPadding: 0)
//        .padding(.horizontal)
    }
    
}

#Preview {
    HomeView()
}
