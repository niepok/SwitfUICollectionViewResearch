//
//  View+Extension.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 09/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

extension View {

    func onFrameChange(enabled isEnabled: Bool = true, frameHandler: @escaping (CGRect) -> ()) -> some View {
        guard isEnabled else { return AnyView(self) }
        return AnyView(self.background(GeometryReader { (geometry: GeometryProxy) in
            Color.clear.beforeReturn {
                frameHandler(geometry.frame(in: .global))
            }
        }))
    }

    private func beforeReturn(_ onBeforeReturn: () -> ()) -> Self {
        onBeforeReturn()
        return self
    }
}

extension View {
    var embededInNavigationLink: some View {
        NavigationLink(
            destination: CollectionDetailView(contentView: self),
            label: { self }
        )
        .buttonStyle(PlainButtonStyle())
    }
}
