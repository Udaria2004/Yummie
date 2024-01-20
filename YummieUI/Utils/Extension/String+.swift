//
//  String+.swift
//  YummieUI
//
//  Created by Macbook 5 on 11/25/23.
//

import Foundation
import UIKit
import AVFoundation

extension String: Error {
        
    func toUrl() -> URL {
        return URL(string: self)!
    }
    
    func toHijriDate() -> Date? {
        let formmatter = DateFormatter()
        formmatter.dateFormat = "dd MMMM yyyy"
        formmatter.calendar = Calendar(identifier: .islamicUmmAlQura)
        return formmatter.date(from: self)
    }
    
    func toDate() -> Date? {
        let formmatter = DateFormatter()
        formmatter.dateFormat = "dd-MMMM-yyyy"
        formmatter.calendar = Calendar(identifier: .gregorian)
        return formmatter.date(from: self)
    }
    
    func width(withHeight height: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
  
  
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
  
    var numberOfWords:Int {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = self.components(separatedBy: chararacterSet)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    func replaceExtraAgo() -> String {
        let ago1 = self.replacingOccurrences(of: "ago", with: "")
        let ago2 = ago1.replacingOccurrences(of: ".ago", with: "")
        let ago3 = ago2.replacingOccurrences(of: "Ago", with: "")
        return ago3
    }
    
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

