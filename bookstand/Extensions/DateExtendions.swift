//
//  DateExtendions.swift
//  bookstand
//
//  Created by Won on 2019/09/27.
//  Copyright © 2019 Won. All rights reserved.
//

import Foundation

extension Date {

    func string(_ dateStyle: DateFormatter.Style = .short) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: self)
    }
}

