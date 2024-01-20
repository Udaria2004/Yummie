import foundation

enum OrderSection:Int {
    case history
    case ongoing
    
    var title:String {
        return String(describing: self).capitalized
    }
}

enum OrderStatus:Int,CaseIterable {
    case deliver
    case pending
    case cancel
    
    var title:String {
        switch self {
        case .deliver:
            return "Order Delivered"
        case .pending:
            return "Order Pending"
        case .cancel:
            return "Order Canceled"
        }
    }
}
