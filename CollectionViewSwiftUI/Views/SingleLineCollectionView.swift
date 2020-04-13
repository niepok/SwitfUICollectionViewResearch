//
//  SingleLineCollectionView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct SingleLineCollectionView: View {
    @State var stringModel: [String] = (1...500).map {
        "Item \($0) " + String(repeating: "x", count: Int.random(in: 0...10))
    }

    private var pagedCollectionParameters = PagedCollectionParameters(pageSize: 40)

    var body: some View {
        buildBody()
        .navigationBarTitle("Singleline collection")
    }

    private func buildBody() -> some View {
        let pagedRandomAccessCollection = PagedRandomAccessCollection(collection: stringModel, pagedCollectionParameters: pagedCollectionParameters)
        return LazySwiftUICollectionView(
            data: pagedRandomAccessCollection,
            layout: .singleLine)
        {
            TextCollectionViewCell(text: $0)
                .background(Color.yellow)
                .cornerRadius(5)
                .padding(5)
        }
    }
}

struct SingleLineCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleLineCollectionView()
    }
}
