//
//  SwiftUICollectionView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 31/12/2019.
//  Copyright © 2019 Adam Niepokój. All rights reserved.
//
// Inspiration: https://talk.objc.io/episodes/S01E167-building-a-collection-view-part-1

import SwiftUI
import UIKit

typealias CollectionViewElementSize<Elements> = [Elements.Element.ID: CGSize] where Elements: RandomAccessCollection, Elements.Element: Identifiable

struct SwiftUICollectionView<Elements, Content>: View where
    Elements: RandomAccessCollection, // crucial: RandomAccessCollection required by for each
    Content: View,
    Elements.Element: Identifiable // required by for each
{
    private var layout: CollectionViewLayout
    private var contentView: (Elements.Element) -> Content // cell for row at index Path from
    private var pagedCollection: PagedRandomAccessCollection<Elements>

    @State private var sizes: CollectionViewElementSize<Elements> = [:] // here we store sizes of elements

    init(data: Elements, layout: CollectionViewLayout, contentView: @escaping (Elements.Element) -> Content) {
        self.pagedCollection = PagedRandomAccessCollection<Elements>(collection: data)
        self.layout = layout
        self.contentView = contentView
    }

    init(pagedData: PagedRandomAccessCollection<Elements>, layout: CollectionViewLayout, contentView: @escaping (Elements.Element) -> Content) {
        self.layout = layout
        self.contentView = contentView
        self.pagedCollection = pagedData
    }

    var body: some View {
        GeometryReader { proxy in // container size
            return self.bodyFor(self.layout, containerSize: proxy.size, offsets: self.layout.layout(for: self.pagedCollection.dataDisplayed, containerSize: proxy.size, sizes: self.sizes))
        }
    }

    private func bodyFor(
        _ layout: CollectionViewLayout,
        containerSize: CGSize,
        offsets: CollectionViewElementSize<Elements>
    ) -> some View {
        switch layout {
        case .singleLine:
            return AnyView(singleLineLayoutBody(containerSize: containerSize, offsets: offsets))
        case .flow:
            return AnyView(flowLayoutBody(containerSize: containerSize, offsets: offsets))
        case .multiLine(let numberOfLines):
            return AnyView(multiLineLayoutBody(containerSize: containerSize,
                                               offsets: offsets,
                                               lines: numberOfLines))
        }
    }

    private func flowLayoutBody(
        containerSize: CGSize,
        offsets: CollectionViewElementSize<Elements>
    ) -> some View {
        let maxOffset = offsets.map { $0.value.height }.max()
        let padding = maxOffset == nil ? CGFloat.zero : maxOffset! - 3 * containerSize.height / 4
        self.pagedCollection.canGetNextPage = true
        return ScrollView {
            ZStack(alignment: .topLeading) {
                ForEach(self.pagedCollection.dataDisplayed) {
                    PropagateSize(content: self.contentView($0).embededInNavigationLink, id: $0.id)
                        .offset(offsets[$0.id] ?? CGSize.zero)
                        .animation(.default)
                        .onFrameChange { frame in
                            if -frame.origin.y > padding && self.pagedCollection.canGetNextPage {
                                self.pagedCollection.nextPage()
                            }
                        }
                }
                Color.clear.frame(width: containerSize.width, height: containerSize.height) // to tell ZStack that the content is large so it lays out from the top
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: padding, trailing: 0))
        }
        .onPreferenceChange(CollectionViewSizeKey<Elements.Element.ID>.self) {
            self.sizes = $0
        }
    }

    private func singleLineLayoutBody(
        containerSize: CGSize,
        offsets: CollectionViewElementSize<Elements>
    ) -> some View {
        let maxOffset = offsets.map { $0.value.width }.max()
        let padding = maxOffset == nil ? CGFloat.zero : maxOffset!
        self.pagedCollection.canGetNextPage = true
        return ScrollView(.horizontal) {
            ZStack(alignment: .topLeading) {
                ForEach(pagedCollection.dataDisplayed) {
                    PropagateSize(content: self.contentView($0).embededInNavigationLink, id: $0.id)
                        .offset(offsets[$0.id] ?? CGSize.zero)
                        .animation(.default)
                        .onFrameChange { frame in
                            if -frame.origin.x > padding && self.pagedCollection.canGetNextPage {
                                self.pagedCollection.nextPage()
                            }
                        }
                }
                Color.clear.frame(width: containerSize.width, height: containerSize.height) // to tell ZStack that the content is large so it lays out from the top
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: padding))
        }
        .onPreferenceChange(CollectionViewSizeKey<Elements.Element.ID>.self) {
            self.sizes = $0
        }
    }

    private struct MultilineCollectionColumn<Elements>: Identifiable where
        Elements: RandomAccessCollection,
        Elements.Element: Identifiable
    {
        var id: Elements.Element.ID
        var elements: [Elements.Element]
    }

    private struct MultilineCollectionColumnView<Elements, Cell>: View where
        Elements: RandomAccessCollection,
        Cell: View,
        Elements.Element: Identifiable
    {
        let column: MultilineCollectionColumn<Elements>
        let cell: (Elements.Element) -> Cell

        var body: some View {
            HStack {
                VStack(spacing: 10) {
                    ForEach(column.elements) {
                        self.cell($0).embededInNavigationLink
                    }
                }
                Divider()
            }
        }
    }

    private func multiLineLayoutBody(
        containerSize: CGSize,
        offsets: CollectionViewElementSize<Elements>,
        lines: Int
    ) -> some View {
        let columns = pagedCollection.dataDisplayed.split(size: lines).map {
            return MultilineCollectionColumn<Elements>(id: $0.first!.id, elements: Array($0))
        }
        let maxOffset = offsets.map { $0.value.width }.max()
        let padding = maxOffset == nil ? CGFloat.zero : maxOffset! - 3 * containerSize.width / 4
        self.pagedCollection.canGetNextPage = true
        return ScrollView(.horizontal) {
            ZStack(alignment: .topLeading) {
                ForEach(columns) {
                    PropagateSize(
                        content: MultilineCollectionColumnView(
                            column: $0,
                            cell: self.contentView
                        ),
                        id: $0.id
                    )
                    .offset(offsets[$0.id] ?? CGSize.zero)
                    .animation(.default)
                    .onFrameChange { frame in
                        if -frame.origin.x > padding && self.pagedCollection.canGetNextPage {
                            self.pagedCollection.nextPage()
                        }
                    }
                }
                Color.clear.frame(width: containerSize.width, height: containerSize.height) // to tell ZStack that the content is large so it lays out from the top
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: padding))
        }
        .onPreferenceChange(CollectionViewSizeKey<Elements.Element.ID>.self) {
            self.sizes = $0
        }
    }

    private struct PropagateSize<V: View, ID: Hashable>: View {
        var content: V
        var id: ID
        var body: some View {
            content.background(
                GeometryReader { proxy in
                    Color.clear // we don't want content twice so we just place transparent background
                        .preference(key: CollectionViewSizeKey<ID>.self, value: [self.id: proxy.size]) //Preference is sending a value up the hierarchy -> in contrast to EnviromentObject which sends it down to it's children
                }
            )
        }
    }

    // this is to calculate next sizes of objects
    private struct CollectionViewSizeKey<ID: Hashable>: PreferenceKey {
        typealias Value = [ID: CGSize]

        static var defaultValue: [ID: CGSize] { [:] }
        static func reduce(value: inout [ID: CGSize], nextValue: () -> [ID: CGSize]) {
            value.merge(nextValue(), uniquingKeysWith: { $1 }) // here we don't calculate sizes, just tell the compiler to use the second one
        }
    }
}



