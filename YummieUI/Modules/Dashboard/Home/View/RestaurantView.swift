

import SwiftUI

struct RestaurantView:View {
    
    var restaurent:Restaurant
    @State var isFav = false
    @Environment(\.presentationMode) var presentationMode
    @State var uiTabarController: UITabBarController?
    @State private var vsblty:Visibility = .automatic
    @State private var dishes:[Dish] = []
    @State private var showCartScreen = false
    @EnvironmentObject var favVM:FavoriteViewModel
    var body: some View {
        List {
            Section {
                ForEach(restaurent.dishes, id:\.id) { dish in
                    NavigationLink {
                        DishDetailView(dish: dish)
                    } label: {
                        DishCell(dish: dish,onAdd: {
                            dishes.append(dish)
                        })
                            .frame(height: 160)
                    }.buttonStyle(.plain)
                  
                }
                Spacer().frame(height: 100)
            } header: {
                VStack(spacing: 0) {
                    RestaurantHeaderView(restaurant: restaurent)
                        .frame(width: width, height: 287, alignment: .center)
                        .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                    HorizontalScrollView(categories: restaurent.categories)
                        .frame(width: width,height: 50)
                }
            }
        }
        .overlay(content: {
            if !dishes.isEmpty {
                Button {
                    showCartScreen.toggle()
                } label: {
                    CartBannerView(dishes: $dishes)
                }.offset(y: (height / 2) - (safeArea.bottom + 40))
                .buttonStyle(.plain)

            }
        })
        .sheet(isPresented: $showCartScreen, content: {
            NavigationView {
                CartView(restaurent:restaurent,dishes: $dishes, didToogleCart: $showCartScreen)
            }
        })
        .toolbar(vsblty, for: .tabBar)
        .listStyle(.grouped)
        .onDisappear(perform: {
            withAnimation {
                vsblty = .visible
            }
        })
        .onAppear(perform: {
            withAnimation {
                vsblty = .hidden
            }
            UITableView.appearance().sectionHeaderTopPadding = 0
            UITableView.appearance().contentInset = .zero
            isFav = favVM.isFav(rest: restaurent)
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .opacity(0.5)
                            .frame(width: 44, height: 44, alignment: .center)
                        Image("back-icon")
                            .renderingMode(.template)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 44, height: 44, alignment: .center)
                }.buttonStyle(.plain)
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favVM.updateFav(rest: restaurent)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .opacity(0.5)
                            .frame(width: 44, height: 44, alignment: .center)
                        Image("heart-tab-u")
                            .renderingMode(.template)
                            .foregroundStyle(favVM.allFavResturants.contains(where: {$0.id == restaurent.id}) ? Color.red : Color.white)
                    }
                    .frame(width: 44, height: 44, alignment: .center)
                    
                }
                .buttonStyle(.plain)
            }
        })
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct RestaurantHeaderView: View {
    
    var restaurant:Restaurant
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Image(restaurant.bgCover)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: 168)
                .clipped()
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .euclardCircular(size: 20, weight: .semibold)
                    .foregroundStyle(Color.black)
                    .padding(.top,5)
                Text("$$ . \(restaurant.cusine.title) . \(restaurant.address)")
                    .euclardCircular(size: 9, weight: .regular)
                    .opacity(0.6)
                HStack {
                    IconLabelView(title: "Free", sub: "Delivery", icon: "delivery-truck")
                    Spacer()
                    IconLabelView(title: "\(restaurant.distance.toStringWithDecimal()) km", sub: "Distance", icon: "locaiton-away")
                    Spacer()
                    IconLabelView(title: "\(restaurant.ratings.toStringWithDecimal())", sub: "(\(restaurant.numberOfRater)+ ratings)", icon: "rating-star")
                }
                .padding(.top,5)
                
            }
            .padding(.horizontal)
            .background(content: {
                Color.white
                    .frame(width: width,height: 119)
            })
        }
    }
}

struct IconLabelView:View {
    
    var title:String
    var sub:String
    var icon:String
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 20,height: 20)
            VStack(alignment: .leading) {
                Text(title)
                    .euclardCircular(size: 9, weight: .semibold)
                Text(sub)
                    .euclardCircular(size: 7, weight: .regular)
                    .opacity(0.7)
            }
        }
    }
}



struct HorizontalScrollView:View {
    
    var categories:[Category]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(categories,id: \.self) { cate in
                Text(cate.title)
                    .euclardCircular(size: 13, weight: .semibold)
                    .foregroundStyle(.colorPrimary)
            }
        }
    }
}


struct DishCell:View {
    
    var dish:Dish
    var onAdd:(() -> ())
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 10) {
                Text(dish.name)
                    .euclardCircular(size: 16, weight: .semibold)
                Text("$\(dish.price.toStringWithDecimal())")
                
                    .euclardCircular(size: 13, weight: .semibold)
                    .foregroundStyle(.green)
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                        .foregroundStyle(.black.opacity(0.4))
                    Text("\(dish.rating.toStringWithDecimal()) (\(dish.numberOfRate)+ ratings)")
                        .poppins(size: 11,weight: .semibold)
                        .opacity(0.4)
                }
            }
            Spacer()
            Image(dish.image)
                .resizable()
                .scaledToFill()
                .frame(width: 135,height: 135)
                .cornerRadius(20)
                .overlay {
                    Button {
                        onAdd()
                    } label: {
                        Text("ADD")
                            .euclardCircular(size: 20, weight: .semibold)
                            .foregroundStyle(Color.green)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color.white)
                                    .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                                    .frame(width: 110, height: 35, alignment: .center)
                            }
                            .offset(y:67)
                    }
                    
                    .frame(width: 110, height: 35, alignment: .center)
                }
        }
    }
}


struct CartBannerView:View {
    
    @Binding var dishes:[Dish]
    
    var body: some View {
        HStack(spacing: 15) {
            Image("cart-icon")
                .resizable()
                .frame(width: 42, height: 42)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 3, y: 3)
            VStack(alignment: .leading) {
                Text("\(dishes.count) \(dishes.count > 1 ? "Items" : "Item")")
                    .poppins(size: 16,weight: .medium)
                Text("In your cart")
                    .poppins(size: 9,weight: .regular)
                    .opacity(0.5)
            }
            Spacer()
            Text("$\(dishes.map({$0.price}).reduce(0, +).toStringWithDecimal())")
                .poppins(size: 15,weight: .semibold)
                .foregroundStyle(.brown)
        }
        .padding(.horizontal)
        .frame(width: width - 64,height: 74)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 8, x: 5, y: 5)
                .frame(width: width - 64,height: 74)
        }
    }
}
