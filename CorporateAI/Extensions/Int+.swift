//
//  Int+.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
