//
//  RandomAccessCollection+Extension.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 06/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import Foundation

extension RandomAccessCollection {

    func split(size: Int) -> [SubSequence] {
        precondition(size > 0, "Split size should be greater than 0.")
        var idx = startIndex
        var splits = [SubSequence]()
        splits.reserveCapacity(count/size)
        while idx < endIndex {
            let advanced = Swift.min(index(idx, offsetBy: size), endIndex)
            splits.append(self[idx..<advanced])
            idx = advanced
        }
        return splits
    }
}
