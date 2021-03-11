//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by T  on 2021-03-11.
//

import Foundation
extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }

        }
        return nil
    }
}
