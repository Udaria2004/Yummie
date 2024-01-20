

import SwiftUI

struct OrderSuccessView:View {
    
    @Binding var showScreen:Bool
    @Binding var dishes:[Dish]
    var restaurent:Restaurant
    var finalDishes:[OrderDish]
   
    var body: some View {
        VStack {
            Image("party-popper")
                .resizable()
                .scaledToFit()
                .frame(width: width - 150,height: width - 150)
                .padding(.top,100)
            Text("Congratulations")
                .euclardCircular(size: 30, weight: .semibold)
                .padding(.top,20)
            Text("Payment was successfully made!")
                .euclardCircular(size: 16, weight: .medium)
            Spacer()
            Button {
                showScreen.toggle()
            } label: {
                Text("DONE")
                    .poppins(size:16,weight: .semibold)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.colorPrimary)
                            .frame(width: width - 64,height: 55)
                    }
            }
            .frame(width: width - 64,height: 55)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            orderCreated()
            
        }
    }
    
    func orderCreated()  {
        let totalPrice = finalDishes.map({$0.price}).reduce(0, +)
        let items = finalDishes.count
        let id = restaurent.id
        let dict = countSameTitles(allDishes: dishes)
        var dishIdQty = [String]()
        dict.forEach { (key: String, value: Int) in
            dishIdQty.append("\(key):\(value)")
        }
        CoreDataManager.shared.createOrder(items: items, totalPrice: totalPrice, id: id,dishIdQty: dishIdQty)
        dishes.removeAll()
    }
    
    
     func countSameTitles(allDishes: [Dish]) -> [String: Int] {
         let titleCounts = Dictionary(grouping: allDishes, by: { $0.id })
                             .mapValues { $0.count }
         return titleCounts
     }

     
}
