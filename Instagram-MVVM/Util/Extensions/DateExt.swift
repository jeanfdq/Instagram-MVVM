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
    
    func timeAgoDisplay() -> String {
            
            let secondsAgo = Int(Date().timeIntervalSince(self))
            
            let minute = 60
            let hour = 60 * minute
            let day = 24 * hour
            let week = 7 * day
            let month = 4 * week
            
            let quotient:Int
            let unit:String
            
            if secondsAgo < minute {
                quotient = secondsAgo / minute
                unit = "second"
            }else if secondsAgo < hour {
                quotient = secondsAgo / minute
                unit = "min"
            }else if secondsAgo < day {
                quotient = secondsAgo / hour
                unit = "hour"
            }else if secondsAgo < week {
                quotient = secondsAgo / day
                unit = "day"
            }else if secondsAgo < month {
                quotient = secondsAgo / week
                unit = "week"
            }else {
                quotient = secondsAgo / month
                unit = "month"
            }
            
            return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
            
        }
    
}
