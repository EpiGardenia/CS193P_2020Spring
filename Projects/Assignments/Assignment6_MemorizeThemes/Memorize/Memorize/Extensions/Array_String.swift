//
//  Array_String.swift
//  Memorize
//
//  Created by T  on 2021-04-29.
//

import Foundation

extension Array {
    func takeFirst(k: Int) -> [Element] {
        let count = self.count
        let dropCount = count < k ? 0 : count-k
        return Array(self.dropLast(dropCount))
    }
}

extension String {
    func takeFirst(k: Int) -> String {
        let count = self.count
        let dropCount = count < k ? 0 : count-k
        return String(self.dropLast(dropCount))
    }
}
