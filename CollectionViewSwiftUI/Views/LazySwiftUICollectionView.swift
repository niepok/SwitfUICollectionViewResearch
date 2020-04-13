//
//  LazySwiftUICollectionView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 10/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct LazySwiftUICollectionView<Elements, Content>: View where
    Elements: RandomAccessCollection,
    Content: View,
    Elements.Element: Identifiable
{
    private var pagedCollection: PagedRandomAccessCollection<Elements>
    private var layout: CollectionViewLayout
    private var contentView: (Elements.Element) -> Content

    init(data: PagedRandomAccessCollection<Elements>, layout: CollectionViewLayout, contentView: @escaping (Elements.Element) -> Content) {
        self.pagedCollection = data
        self.layout = layout
        self.contentView = contentView
    }

    var body: some View {
        LazySwiftUIPagedCollectionViewProvider<Elements, Content>(layout: layout, contentView: contentView)
        .environmentObject(pagedCollection)
    }

    private struct LazySwiftUIPagedCollectionViewProvider<Elements, Content>: View where
        Elements: RandomAccessCollection,
        Content: View,
        Elements.Element: Identifiable
    {
        private var layout: CollectionViewLayout
        private var contentView: (Elements.Element) -> Content
        @EnvironmentObject private var pagedCollection: PagedRandomAccessCollection<Elements>

        init(layout: CollectionViewLayout, contentView: @escaping (Elements.Element) -> Content) {
            self.layout = layout
            self.contentView = contentView
        }

        var body: some View {
            SwiftUICollectionView(
                pagedData: pagedCollection,
                layout: layout
            ) {
                self.contentView($0)
            }
        }
    }
}
