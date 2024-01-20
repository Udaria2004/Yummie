//
//  Font+.swift
//  YummieUI
//
//  Created by Macbook 5 on 11/25/23.
//

import SwiftUI


extension Font {
    
    static func euclardCircular(size: CGFloat, weight: FontWeight) -> Font {
        return Font.custom("EuclidCircularB-\(weight.rawValue)", size: size)
    }
    
    
    static func poppins(size: CGFloat, weight: FontWeight) -> Font {
        return Font.custom("Poppins-\(weight.rawValue)", size: size)
    }
    
}
