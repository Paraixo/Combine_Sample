//
//  Date+Extension.swift
//  SwiftUI_Sample
//
//  Created by 服部翼 on 2021/02/05.
//

import Foundation

extension Date {
    
    func stringConvert() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_jp")
        let now = Date()
        return formatter.string(from: now)
    }
}
