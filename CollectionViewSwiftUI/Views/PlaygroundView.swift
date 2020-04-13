//
//  PlaygroundView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 06/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct PlaygroundView: View {
    @State var stringModel: [String] = (1...500).map {
        "Item \($0) " + String(repeating: "x", count: Int.random(in: 0...10))
    }
    let imageModels = PhotosViewModel.getArrayExample()
    let emojiModels = EmojiViewModel.getArrayExample()

    var body: some View {
        List {
            NavigationLink(destination: threeDifferent(), label: { Text("3 collections - different model base, no paging") })
            NavigationLink(destination: threeStrings(), label: { Text("3 collections - string model base, no paging") })
            NavigationLink(destination: threePagedStrings(), label: { Text("3 paged collections - string model base") })
        }
        .navigationBarTitle("Playground")
        .environment(\.horizontalSizeClass, .compact)
    }

    private func threeDifferent() -> some View {
        VStack {
            SwiftUICollectionView(data: stringModel, layout: .multiLine(numberOfLines: 3)) {
                TextCollectionViewCell(text: $0)
                    .background(Color.yellow)
                    .cornerRadius(5)
                    .padding(5)
            }
            SwiftUICollectionView(data: emojiModels, layout: .flow) {
                EmojiCollectionViewCell(model: $0)
                    .background(Color( #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
                    .cornerRadius(20)
            }
            SwiftUICollectionView(data: imageModels, layout: .singleLine) {
                ImageCellView(model: $0)
                    .background(Color.green)
                    .cornerRadius(20)
                    .padding(5)
            }
        }
    }

    private func threeStrings() -> some View {
        VStack {
            SwiftUICollectionView(data: stringModel, layout: .multiLine(numberOfLines: 3)) {
                TextCollectionViewCell(text: $0)
                    .background(Color.green)
                    .padding(5)

            }
            SwiftUICollectionView(data: stringModel, layout: .flow) {
                TextCollectionViewCell(text: $0)
                    .background(Color.pink)

            }
            SwiftUICollectionView(data: stringModel, layout: .singleLine) {
                TextCollectionViewCell(text: $0)
                    .background(Color.yellow)
                    .padding(5)

            }
        }
    }

    private var pagedCollectionParametersArray = [
        PagedCollectionParameters(pageSize: 40),
        PagedCollectionParameters(pageSize: 40),
        PagedCollectionParameters(pageSize: 40)
    ]

    private func threePagedStrings() -> some View {
        let pagedCollectionsArray = pagedCollectionParametersArray.map { PagedRandomAccessCollection(collection: stringModel, pagedCollectionParameters: $0) }
        return VStack {
            LazySwiftUICollectionView(data: pagedCollectionsArray[0], layout: .multiLine(numberOfLines: 3)) {
                TextCollectionViewCell(text: $0)
                    .background(Color.green)
                    .cornerRadius(5)
                    .padding(5)

            }
            LazySwiftUICollectionView(data: pagedCollectionsArray[1], layout: .flow) {
                TextCollectionViewCell(text: $0)
                    .background(Color.pink)
                    .cornerRadius(5)


            }
            LazySwiftUICollectionView(data: pagedCollectionsArray[2], layout: .singleLine) {
                TextCollectionViewCell(text: $0)
                    .background(Color.yellow)
                    .cornerRadius(5)
                    .padding(5)

            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
