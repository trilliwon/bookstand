//
//  NumberFormatterExtensions.swift
//  bookstand
//
//  Created by Won on 2019/09/27.
//  Copyright © 2019 Won. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        return formatter
    }()
}
