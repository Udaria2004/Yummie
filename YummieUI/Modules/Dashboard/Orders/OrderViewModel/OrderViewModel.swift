
import SwiftUI

class OrderViewModel:ObservableObject {
    
    @Published var ordersChunk:[[Order]] = []
    @Published var mode: OrderSection = .ongoing
    
    init() {
        ordersToMode(mode: mode)
    }
    
    func changeMode(mode:OrderSection) {
        self.mode = mode
        self.ordersToMode(mode: mode)
    }
}


extension OrderViewModel {
    
    
    fileprivate
    func makeDayChunks(orders: [Order]) -> [[Order]] {
        let groupedOrders = orders.reduce(into: [Date: [Order]]()) { result, order in
            guard let orderDate = order.date else {
                // Handle the case where date is nil (you can skip or handle differently)
                return
            }

            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: orderDate)
            let dayDate = calendar.date(from: components) ?? Date()

            result[dayDate, default: []].append(order)
        }

        let chunks: [[Order]] = groupedOrders.values.map { $0 }
        return chunks
    }

    
    fileprivate
    func ordersToMode(mode:OrderSection) {
        let allOrders = CoreDataManager.shared.getUser()?.oders ?? []
        let allPending = allOrders.filter({ $0.status == .pending }).sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
        let allCompeleted = allOrders.filter({ $0.status == .deliver }).sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
        if mode == .ongoing {
            self.ordersChunk = self.makeDayChunks(orders: allPending)
        } else {
            self.ordersChunk = self.makeDayChunks(orders: allCompeleted)
        }
    }
    
    
}
