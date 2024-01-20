//
//  SafeAreaInsetManager.swift
//  YummieUI
//
//    Udayveer Singh
//    3035918634

import Foundation
import SwiftUI

class SafeAreaInsetsManager {
    static let shared = SafeAreaInsetsManager()

    private var safeAreaInsets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

    private init() {
        let window = UIWindow.window()
        safeAreaInsets = EdgeInsets(top: window?.safeAreaInsets.top ?? 0, leading: window?.safeAreaInsets.left ?? 0, bottom: window?.safeAreaInsets.bottom ?? 0, trailing: window?.safeAreaInsets.right ?? 0)

        // Observe the safe area insets changes to update the property
//        NotificationCenter.default.addObserver(forName: UIWindow.safeAreaInsetsDidChangeNotification, object: nil, queue: .main) { [weak self] notification in
//            guard let strongSelf = self else { return }
//            strongSelf.safeAreaInsets = notification.userInfo?[UIWindow.safeAreaInsetsUserInfoKey] as? EdgeInsets ?? .zero
//        }
    }

    public func getSafeAreaInsets() -> EdgeInsets {
        return safeAreaInsets
    }
}
extension UIWindow {
    static func window() -> UIWindow? {
//        getting the all scenes
        let scenes = UIApplication.shared.connectedScenes
//        getting windowScene from scenes
        let windowScene = scenes.first as? UIWindowScene
//        getting window from windowScene
        let window = windowScene?.windows.first
        return window
      
    }
    
    static func windows() -> [UIWindow]? {
//        getting the all scenes
        let scenes = UIApplication.shared.connectedScenes
//        getting windowScene from scenes
        let windowScene = scenes.first as? UIWindowScene
//        getting window from windowScene
        let windows = windowScene?.windows
        return windows
      
    }
}
