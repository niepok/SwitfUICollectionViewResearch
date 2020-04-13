//
//  PagedCollectionView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 06/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

final class WrappedInt {
    var value: Int

    init(_ value: Int = 0) {
        self.value = value
    }

    static var zero: WrappedInt {
        WrappedInt(0)
    }
}


final class PagedCollectionParameters {
    var pageSize: Int?
    var currentPage: WrappedInt

    init(pageSize: Int?, currentPage: WrappedInt = WrappedInt.zero) {
        self.pageSize = pageSize
        self.currentPage = currentPage
    }
}

final class PagedRandomAccessCollection<Elements>: ObservableObject where Elements: RandomAccessCollection {
    private var collection: Elements {
        willSet {
            if newValue.count < collection.count {
                observablePage.value = newValue.count / pageSize - 1
            }
        }
    }
    private var currentPage: Int = 0
    private var observablePage: WrappedInt
    private var pageSize: Int
    private var pages: [Elements.SubSequence] {
        return collection.split(size: pageSize)
    }
    private var hasNextPage: Bool {
        return collection.count / pageSize - 1 > currentPage
    }
    @Published var dataDisplayed: [Elements.Element] = []
    var canGetNextPage = true


    init(collection: Elements, pagedCollectionParameters: PagedCollectionParameters? = nil) {
        self.collection = collection
        if let pagedCollectionParameters = pagedCollectionParameters {
            self.pageSize = pagedCollectionParameters.pageSize ?? collection.count
            self.observablePage = pagedCollectionParameters.currentPage
        } else {
            self.pageSize = collection.count
            self.observablePage = WrappedInt.zero
        }
        setCurrentPage()
        recalculateDisplayedData()
    }

    private func setCurrentPage() {
        if observablePage.value > self.currentPage && observablePage.value < collection.count / pageSize {
            self.currentPage = observablePage.value
        } else if observablePage.value >= collection.count / pageSize - 1 {
            self.currentPage = collection.count / pageSize - 1
        }
    }

    private func recalculateDisplayedData() {
        var data = [Elements.Element]()
        for index in 0...currentPage {
            data.append(contentsOf: pages[index].map { $0 })
        }
        dataDisplayed = data
    }

    func nextPage() {
        guard hasNextPage else { return }
        canGetNextPage = false
        currentPage += 1
        observablePage.value += 1
        recalculateDisplayedData()
    }
}
