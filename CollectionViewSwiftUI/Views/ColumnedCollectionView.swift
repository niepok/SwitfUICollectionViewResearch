//
//  ColumnedCollectionView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct ColumnedCollectionView: View {
    @State var stringModel: [String] = (1...500).map {
        "Item \($0) " + String(repeating: "x", count: Int.random(in: 0...10))
    }

    private var pagedCollectionParameters = PagedCollectionParameters(pageSize: 40)

    var body: some View {
        buildBody()
        .navigationBarTitle("Multiline columns")
    }

    private func buildBody() -> some View {
        let pagedRandomAccessCollection = PagedRandomAccessCollection(collection: stringModel, pagedCollectionParameters: pagedCollectionParameters)
        return LazySwiftUICollectionView(
            data: pagedRandomAccessCollection,
            layout: .multiLine(numberOfLines: 8))
        {
            TextCollectionViewCell(text: $0)
                .background(Color.green)
                .cornerRadius(5)
                .padding(5)
        }
    }
}

struct ColumnedCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColumnedCollectionView()
    }
}
