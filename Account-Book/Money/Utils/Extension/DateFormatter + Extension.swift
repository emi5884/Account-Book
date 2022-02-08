import UIKit

extension DateFormatter {
    
    static func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
    
    static func titleMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "ja_JP")
        let dateString = formatter.string(from: date)
        let monthString = dateString[dateString.index(dateString.startIndex, offsetBy: 5) ..< dateString.index(dateString.startIndex, offsetBy: 7)]
        return String(monthString)
    }
}
