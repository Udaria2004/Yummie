
import Foundation



struct AccountModel:Identifiable {
    
    let title:String
    let info:[AccountInfo]
    
    init(title: String, info: [AccountInfo]) {
        self.title = title
        self.info = info
    }
    
    static func all() -> [AccountModel] {
        return [AccountModel(title: "0", info: [AccountInfo(title: "Yummie", icon: "premium")]),
                AccountModel(title: "1", info: [AccountInfo(title: "Orders", icon: "orders-icon"),
                                               AccountInfo(title: "Favorites", icon: "fav-icon")]),
                AccountModel(title: "2", info: [AccountInfo(title: "My details", icon: "info-icon"),
                                               AccountInfo(title: "Payment method", icon: "payment-method"),
                                               AccountInfo(title: "Vouchers and credit", icon: "credit-card"),
                                               AccountInfo(title: "Address", icon: "address-icon"),
                                               AccountInfo(title: "Language", icon: "language"),
                                               AccountInfo(title: "Contact prefrences", icon: "content-pref"),
                                               AccountInfo(title: "App Mode", icon: "dark-mode"),
                                               AccountInfo(title: "FAQs", icon: ""),
                                               AccountInfo(title: "About YummieR for iOS", icon: ""),
                                               AccountInfo(title: "Logout", icon: "")])]
    }
    
    var id:String {
        return title
    }
}

struct AccountInfo:Identifiable {
    
    let title:String
    let icon:String?
    
    init(title: String, icon: String? = nil) {
        self.title = title
        self.icon = icon
    }
    
    var id:String {
        return title
    }
    
    var isLogout:Bool {
        self.title == "Logout"
    }
}
