

import SwiftUI

struct CartView:View {
    
    var restaurent:Restaurant
    @Binding var dishes:[Dish]
    @Binding var didToogleCart:Bool
    
   
    @State var finalDishes = [OrderDish]()
    
    var total:Double {
        return dishes.map({$0.price}).reduce(0, +)
    }
    
    
    @State var consolidatedDishes = [String: (dish: Dish, quantity: Int, totalPrice: Double)]() {
        didSet {
            for (_, dishInfo) in consolidatedDishes {
                let (dish, quantity, totalPrice) = dishInfo
                let consolidatedDish = OrderDish(name: dish.name, image: dish.image, price: totalPrice, quantity: quantity, restaurent: self.restaurent)
                finalDishes.append(consolidatedDish)
            }
        }
    }
    
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    ForEach(Array(finalDishes.enumerated()),id: \.offset) { itemIndex in
                        let item = finalDishes[itemIndex.offset]
                        CartCell(item: item,onAdd: {
                            let item = finalDishes[itemIndex.offset]
                            if let dish = dishes.first(where: {$0.name == item.name}) {
                                withAnimation {
                                    dishes.append(dish)
                                    updateData()
                                }
                            }
                        },onRemove: {
                            if let index = dishes.firstIndex(where: {$0.name == item.name}) {
                                withAnimation {
                                    dishes.remove(at: index)
                                    updateData()
                                }
                                if dishes.isEmpty {
                                    didToogleCart.toggle()
                                }
                            }
                        })
                            .frame(height: 72)
                    }
                } footer: {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Subtotal")
                                .poppins(size: 15, weight: .regular)
                            Spacer()
                            Text("$\(total.toStringWithDecimal())")
                                .poppins(size: 15, weight: .semibold)
                        }
                        .foregroundStyle(.black)
                        HStack {
                            Text("Delivery Charges")
                                .poppins(size: 15, weight: .regular)
                            Spacer()
                            Text("$0")
                                .poppins(size: 15, weight: .semibold)
                        }
                        .foregroundStyle(.black)
                        HStack {
                            Text("Total (incl. VAT)")
                                .poppins(size: 15, weight: .regular)
                            Spacer()
                            Text("$\(total.toStringWithDecimal())")
                                .poppins(size: 15, weight: .semibold)
                        }
                        .foregroundStyle(.black)
                        NavigationLink {
                            OrderSuccessView(showScreen: $didToogleCart,dishes: $dishes,restaurent: restaurent, finalDishes: finalDishes)
                        } label: {
                            Text("CHECKOUT $\(total.toStringWithDecimal())")
                                .poppins(size:16,weight: .semibold)
                                .foregroundStyle(Color.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color.colorPrimary)
                                        .frame(width: width - 64,height: 55)
                                }
                        }
                        .frame(width: width - 64,height: 55)
                    }
                }
            }
            .onAppear(perform: {
                updateData()
            })
       
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    didToogleCart.toggle()
                } label: {
                   Text("Close")
                }
                .buttonStyle(.plain)
            }
        })
       
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            consolidatedDishes = [:] // Reset consolidated dishes
            for dish in dishes {
                if let existingDish = consolidatedDishes[dish.name] {
                    consolidatedDishes[dish.name] = (dish: existingDish.dish,
                                                     quantity: existingDish.quantity + 1,
                                                     totalPrice: existingDish.totalPrice + dish.price)
                } else {
                    consolidatedDishes[dish.name] = (dish: dish, quantity: 1, totalPrice: dish.price)
                }
            }
            updateFinalDishes()
        }
       
    }
 
    private func updateFinalDishes() {
        finalDishes = consolidatedDishes.map { (_, dishInfo) in
            let (dish, quantity, totalPrice) = dishInfo
            return OrderDish(name: dish.name, image: dish.image, price: totalPrice, quantity: quantity, restaurent: self.restaurent)
        }
        finalDishes = finalDishes.sorted(by: {$0.quantity > $1.quantity})
    }
    
 
}


struct CartCell:View {
    var item:OrderDish
    var onAdd:(() ->())
    var onRemove:(() ->())
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60,height: 60)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(item.name)
                    .poppins(size: 15, weight: .bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Spacer()
                Text("$\(item.price.toStringWithDecimal())")
                    .poppins(size: 15, weight: .bold)
                    .foregroundStyle(.colorFF6C42)
            }
            .frame(height: 60)
            Spacer()
            HStack(spacing: 0) {
                Button {
                    onRemove()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.red)
                        Image(systemName: "minus")
                            .foregroundStyle(.white)
                        
                    }
                    .frame(width: 32, height: 32)
                        
                }
                .buttonStyle(.plain)
                .frame(width: 32, height: 32)
                Text("\(item.quantity)")
                    .poppins(size: 16, weight: .bold)
                    .frame(width: 30, height: 30)
                Button {
                    onAdd()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.green)
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                        
                    }
                    .frame(width: 32, height: 32)
                }
                .buttonStyle(.plain)
                .frame(width: 32, height: 32)
                
                    
            }
            .frame(width: 110,height: 44)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 110,height: 44)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
                    .foregroundStyle(.white)
            }
           
        }
    }
}
