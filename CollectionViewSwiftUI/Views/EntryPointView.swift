//
//  EntryPointView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 13/04/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct EntryPointView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ColumnedCollectionView(), label: { Text("App Store like collection with multiline columns") })
                NavigationLink(destination: FlowCollectionView(), label: { Text("Flow layout collection") })
                NavigationLink(destination: SingleLineCollectionView(), label: { Text("Singleline collection") })
                NavigationLink(destination: PlaygroundView(), label: { Text("Project playground") })
            }
            .navigationBarTitle("SwiftUICollectionView")
        }
    }
}

struct EntryPointView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPointView()
    }
}
