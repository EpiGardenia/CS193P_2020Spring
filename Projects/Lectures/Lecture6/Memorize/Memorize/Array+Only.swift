//
//  Array+Only.swift
//  Memorize
//
//  Created by T  on 2021-03-11.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
