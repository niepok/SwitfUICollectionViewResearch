//
//  PokemonPlaygroundView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct PokemonPlaygroundView: View {
    @EnvironmentObject var networkManager: NetworkingManager

    var body: some View {
        List {
            NavigationLink(destination: pagedExample(), label: { Text("3 collections - different model base, no paging") })
            NavigationLink(destination: genericExample(), label: { Text("3 collections - cell view independency example") })
            NavigationLink(destination: differentLayoutStyle(), label: { Text("3 collections - different layout style") })
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Catch them all!")
    }

    private var pagedCollectionParameters = PagedCollectionParameters(pageSize: 20)

    private func pagedExample() -> some View {
        let pagedRandomAccessCollection = PagedRandomAccessCollection(collection: networkManager.poks, pagedCollectionParameters: pagedCollectionParameters)
        return LazySwiftUICollectionView(
            data: pagedRandomAccessCollection,
            layout: .flow)
        {
            BigPokemonCell(pok: $0)
                .background(Color.yellow)
                .cornerRadius(5)
                .padding(10)
        }
        .navigationBarTitle("Catch them all!")
    }

    private func genericExample() -> some View {
        VStack {
            SwiftUICollectionView(data: networkManager.poks, layout: .multiLine(numberOfLines: 2)) {
                PokemonHorizontalCell(pok: $0)
                    .background(Color.green)
                    .cornerRadius(5)
                    .padding(10)

            }
            SwiftUICollectionView(data: networkManager.poks, layout: .flow) {
                PokemonSmallHorizontalCell(pok: $0)
                    .background(Color.pink)
                    .cornerRadius(5)

            }
            SwiftUICollectionView(data: networkManager.poks, layout: .singleLine) {
                PokemonCell(pok: $0)
                    .background(Color.yellow)
                    .cornerRadius(5)
                    .padding(10)

            }
        }
        .navigationBarTitle("Catch them all!")
    }

    private func differentLayoutStyle() -> some View {
        VStack {
            SwiftUICollectionView(data: networkManager.poks, layout: .multiLine(numberOfLines: 2)) {
                PokemonSmallHorizontalCell(pok: $0)
                    .background(Color.green)
                    .cornerRadius(5)
                    .padding(5)

            }
            SwiftUICollectionView(data: networkManager.poks, layout: .flow) {
                PokemonSmallHorizontalCell(pok: $0)
                    .background(Color.pink)
                    .cornerRadius(5)

            }
            SwiftUICollectionView(data: networkManager.poks, layout: .singleLine) {
                PokemonSmallHorizontalCell(pok: $0)
                    .background(Color.yellow)
                    .cornerRadius(5)
                    .padding(5)
            }
        }
        .navigationBarTitle("Catch them all!")
    }
}

struct PokemonPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPlaygroundView()
    }
}
