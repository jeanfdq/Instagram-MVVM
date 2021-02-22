//
//  DateExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 21/02/21.
//

import Foundation

extension Date {
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
    
    func toRelativeString(_ date:Date) -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: date)
    }
    
    func todayRelativeString() -> String {
        return toRelativeString(Date())
    }
    
    func getDateToString(_ pattern:String) -> String {
            
            let datePattern = DateFormatter()
            datePattern.dateFormat = pattern
            return datePattern.string(from: self)
            
        }
    
}
