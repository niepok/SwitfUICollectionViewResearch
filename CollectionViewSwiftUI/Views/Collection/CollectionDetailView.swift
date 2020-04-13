//
//  CollectionDetailView.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 03/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct CollectionDetailView<Content>: View where Content: View {
    var contentView: Content
    var body: some View {
        contentView
    }
}
