//
//  DateExtension.swift
//  X-Vault
//
//  Created by netset on 27/03/23.
//

import Foundation


extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month,.weekOfYear, .day, .hour, .minute], from: self, to: Date())
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
            "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
            "\(month)" + " " + "months ago"
        } else if let weak = interval.weekOfYear, weak > 0 {
            return weak == 1 ? "\(weak)" + " " + "week ago" :
            "\(weak)" + " " + "weeks ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
            "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
            "\(hour)" + " " + "hours ago"
        } else if let minuts = interval.minute, minuts > 0 {
            return minuts == 1 ? "\(minuts)" + " " + "minute ago" :
            "\(minuts)" + " " + "minutes ago"
        }  else {
            return "just now"
        }
    }
    
    func getTimeInterval() -> (String,Int,Int) {
        let interval = Calendar.current.dateComponents([.second], from: Date(), to: self)
        if (interval.second ?? 0) > 0 {
            return secondsToHoursMinutesSecondsStr(seconds: interval.second ?? 0)
        } else {
            return ("",0,0)
        }
    }
    
    func secondsToHoursMinutesSecondsStr(seconds : Int) -> (String,Int,Int) {
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: seconds)
        let hoursVal = hours == 0 ? "00" : "\(hours)".count == 2 ? "\(hours)" : "0\(hours)"
        let minutesVal = minutes == 0 ? "00" : "\(minutes)".count == 2 ? "\(minutes)" : "0\(minutes)"
        let secondsVal = seconds == 0 ? "00" : "\(seconds)".count == 2 ? "\(seconds)" : "0\(seconds)"
        return ("\(hoursVal):\(minutesVal):\(secondsVal) left",hours,minutes)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
