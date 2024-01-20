//
//  YummieUIApp.swift
//  YummieUI
//

//    Chan Yu Sing
//    3035930345

//    Udayveer Singh
//    3035918634

//    Ishanvi Mohan
//    3035756311

import SwiftUI

@main
struct YummieUIApp: App {
    
    @State var id = CoreDataManager.shared.uid
    var body: some Scene {
        WindowGroup {
            if id.isEmpty { // no user
                GetStartedView()
            } else {
                AppTabView()
                    .onReceive(NotificationCenter.default.publisher(for: Notification.userLogout))
                           { data in
                               withAnimation {
                                   id = CoreDataManager.shared.logOutUser()
                               }
                     }
            }
        }
    }
    
    init() {
        UNUserNotificationCenter.current().delegate = AppDelegate.shared
    }
}
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    static let shared = AppDelegate() // Shared instance
    
    // MARK: - UNUserNotificationCenterDelegate Methods
    
    // Implement the necessary delegate method for handling notifications
    // Handle notification when app is in foreground
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Show the notification when the app is in the foreground
            completionHandler([.banner,.sound, .badge])
        }
        
    
    // Other delegate methods can be implemented here if needed
}
extension Notification {
    static let userLogout = Notification.Name.init("userLogout")
}
