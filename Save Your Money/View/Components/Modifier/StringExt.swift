//
//  StringExt.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 1.07.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) localize error")
    }
}
