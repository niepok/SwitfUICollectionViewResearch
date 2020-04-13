//
//  EntryPointView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct EntryPointView: View {
    @EnvironmentObject var networkManager: NetworkingManager

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Research")) {
                    NavigationLink(destination: ColumnedCollectionView(), label: { Text("App Store like collection with multiline columns") })
                    NavigationLink(destination: FlowCollectionView(), label: { Text("Flow layout collection") })
                    NavigationLink(destination: SingleLineCollectionView(), label: { Text("Singleline collection") })
                }

                Section(header: Text("Example playgrounds")) {
                    NavigationLink(destination: PlaygroundView(), label: { Text("Project playground") })
                    NavigationLink(destination: PokemonPlaygroundView().environmentObject(networkManager), label: { Text("Pokemon presentation collections")})
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("SwiftUICollectionView")
        }
    }
}

struct EntryPointView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPointView()
    }
}
