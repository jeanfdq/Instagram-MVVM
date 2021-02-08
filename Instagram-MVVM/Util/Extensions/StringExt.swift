//
//  StringExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Foundation

extension String {
    
    func replace(string:String, replacement:String) ->String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func execSubstring( _ startIndex:Int, _ endIndex:Int) -> String {
        
        let substr = self
        let start   = substr.index(substr.startIndex, offsetBy: startIndex)
        let end     = substr.index(substr.endIndex, offsetBy: (substr.count - endIndex) * (-1))
        let range   = start..<end
        
        return String(substr[range])
        
    }
    
    var isValidEmail: Bool {
        if self.isEmpty {
            return false
        } else {
            
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailMatch = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailMatch.evaluate(with: self)
            
        }
        
    }
    
}
