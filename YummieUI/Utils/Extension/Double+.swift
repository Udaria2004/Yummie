//
//  Double+.swift
//  YummieUI
//
//  Created by Macbook 5 on 11/26/23.
//

import Foundation

extension Double {
    
    func toStringWithDecimal(decimal:Int = 1) -> String {
        return String(format: "%.\(decimal)f", self)
    }
}
