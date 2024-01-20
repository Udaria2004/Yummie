

import SwiftUI

struct OrderView: View {
    
    @StateObject var vm = OrderViewModel()
    @State var showCart = false
    @State var restaurnt:Restaurant?
    @State var dishes:[Dish] = []
    
    var body: some View {
        VStack {
            HistoryOnGoingView()
                .environmentObject(vm)
            if vm.ordersChunk.isEmpty {
                Spacer()
                Image("cart")
                Text("Your  \(vm.mode.title) orders list is empty")
                    .poppins(size: 16, weight: .semibold)
                Spacer()
            } else {
                List {
                    ForEach(Array(vm.ordersChunk.enumerated()),id:\.offset) { (index,chunk) in
                        Section {
                            let items = vm.ordersChunk[index]
                            ForEach(Array(items.enumerated()),id:\.offset) { (i,order) in
                                OrderCell(order:order,rest: order.restaurant!,dishes:order.toDishes,onReorder: {
                                    restaurnt = order.restaurant
                                    dishes = order.toDishes
                                    showCart = restaurnt != nil && !dishes.isEmpty
                                })
                                    .frame(height:155)
                            }
                        } header: {
                            Text(chunk[0].date!, style: .date)
                        }
                    }
                }
            }
           
        }
        .sheet(isPresented: $showCart, onDismiss: {
            vm.changeMode(mode: self.vm.mode)
        }, content: {
            if let restaurnt = restaurnt {
                NavigationView {
                    CartView(restaurent: restaurnt, dishes: $dishes, didToogleCart: $showCart)
                }
            }
        })
        .navigationTitle("Orders")
        .onChange(of: showCart) { newValue in
            if let _ = restaurnt {
                
            } else {
                showCart = false
            }
            
        }
    }
}

struct HistoryOnGoingView: View {
    
    @EnvironmentObject var vm:OrderViewModel
    var body: some View {
        HStack {
            Button {
                vm.changeMode(mode: .history)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(vm.mode == .history ? Color.colorFF6C42 : Color.colorFF6C42.opacity(0.16))
                    Text("History")
                        .poppins(size: 12, weight: .semibold)
                        .foregroundStyle(vm.mode == .history ? Color.white : Color.colorFF6C42)
                }.frame(width: 130, height: 44)
            }
            .frame(width: 130, height: 44)
            Spacer()
            Button {
                vm.changeMode(mode: .ongoing)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(vm.mode == .ongoing ? Color.colorFF6C42 : Color.colorFF6C42.opacity(0.16))
                    Text("Ongoing")
                        .poppins(size: 12, weight: .semibold)
                        .foregroundStyle(vm.mode == .ongoing ? Color.white : Color.colorFF6C42)
                }.frame(width: 130, height: 44)
            }
            .frame(width: 130, height: 44)

        }
        .padding(.horizontal)
    }
}

struct OrderCell: View {
    
    var order:Order
    var rest:Restaurant
    var dishes:[Dish]
    var onReorder: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(order.restaurant?.bgCover ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(order.restaurant?.name ?? "")
                        .poppins(size: 16, weight: .bold)
                    let date = order.date!.toStringWithFormat(format: "dd MMM, HH:mm")
                    
                    Text("\(date) . \(order.items) Items")
                        .euclardCircular(size: 12, weight: .regular)
                        .opacity(0.77)
                    HStack {
                        Circle()
                            .frame(width: 7)
                            .foregroundStyle(.colorPrimary)
                        Text(order.status.title)
                            .poppins(size: 14,weight: .medium)
                            .foregroundStyle(.colorPrimary)
                    }
                   
                }
                Spacer()
                VStack(alignment: .trailing) {
                    let deliverTime = order.deliverDate.toStringWithFormat(format: "HH:mm")
                    Text("$\(order.total.toStringWithDecimal())")
                        .poppins(size: 16, weight: .bold)
                        .foregroundStyle(.colorFF6C42)
                    Text("")
                    Text("Deliver at: \(deliverTime)")
                        .euclardCircular(size: 12, weight: .regular)
                        .opacity(0.6)
                }
            }
            
            HStack {
                Button {
                    onReorder?()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.colorFF6C42)
                        Text("Re-Order")
                            .poppins(size: 12, weight: .semibold)
                            .foregroundStyle(Color.white)
                    }.frame(width: 130, height: 44)
                }
                .frame(width: 130, height: 44)
                Spacer()
                Button {
                  
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.colorFF6C42.opacity(0.16))
                        Text("Rate")
                            .poppins(size: 12, weight: .semibold)
                            .foregroundStyle(Color.colorFF6C42)
                    }.frame(width: 130, height: 44)
                }
                .frame(width: 130, height: 44)
            }
        }
        
    }
    
}

extension Date {
    func toStringWithFormat(format: String) -> String {
        let formmatter = DateFormatter()
        formmatter.dateFormat = format
        return formmatter.string(from: self)
    }
}
