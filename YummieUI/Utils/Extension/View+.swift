//
//  View+.swift
//  YummieUI
//
//  Created by Macbook 5 on 11/25/23.
//

import SwiftUI


extension View {
    
    var safeArea:EdgeInsets {
        return SafeAreaInsetsManager.shared.getSafeAreaInsets()
    }
    
    var width:CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height:CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func euclardCircular(size: CGFloat, weight: FontWeight) -> Font {
        return Font.custom("EuclidCircularB-\(weight.rawValue)", size: size)
    }
    
    
    static func poppins(size: CGFloat, weight: FontWeight) -> Font {
        return Font.custom("Poppins-\(weight.rawValue)", size: size)
    }
    
}

extension Text {
    
    
    func euclardCircular(size: CGFloat, weight: FontWeight) -> Text {
        return font(.custom("EuclidCircularB-\(weight.rawValue)", size: size))
    }
    
    
    func poppins(size: CGFloat, weight: FontWeight) -> Text {
        return font(.custom("Poppins-\(weight.rawValue)", size: size))
    }
    
}

enum FontWeight:String {
    case regular   = "Regular"
    case medium    = "Medium"
    case bold      = "Bold"
    case semibold  = "SemiBold"
    case light     = "Light"
}

// Custom ViewModifier for conditional padding based on iOS version
struct ConditionalPaddingModifier: ViewModifier {
    let paddingForiOS17: CGFloat
    let defaultPadding: CGFloat

    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            return AnyView(content.padding(.horizontal,paddingForiOS17))
        } else {
            return AnyView(content.padding(.horizontal,defaultPadding))
        }
    }
}

extension View {
    func conditionalPadding(paddingForiOS17: CGFloat, defaultPadding: CGFloat) -> some View {
        modifier(ConditionalPaddingModifier(paddingForiOS17: paddingForiOS17, defaultPadding: defaultPadding))
    }
}


