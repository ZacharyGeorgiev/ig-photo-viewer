//
//  Date+Extension.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 04/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation

extension Date {
    func relativeTimeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
}
