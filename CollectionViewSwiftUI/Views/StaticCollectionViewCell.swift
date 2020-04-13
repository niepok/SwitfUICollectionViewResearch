//
//  StaticCollectionViewCell.swift
//  GifBrowserSwiftUI
//
//  Created by Adam Niepokój on 30/12/2019.
//  Copyright © 2019 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct EmojiCollectionViewCell: View {
    let model: EmojiViewModel
    var body: some View {
        VStack {
            getImageStack(with: model.image)
            Text(model.emojisInText)
        }
    }

    private func getImageStack(with image: UIImage) -> some View {
        let amount = Int.random(in: 1...4)

        switch amount {
        case 2:
            return AnyView(HStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
            })
        case 3:
            return AnyView(HStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
            })
        case 4:
            return AnyView(HStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 75,  maxHeight: 75)
            })
        default:
            return AnyView(Image(uiImage: image)
                .resizable()
                .frame(maxWidth: 75,  maxHeight: 75))

        }
    }
}

struct StaticCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCollectionViewCell(
            model: EmojiViewModel.getOneExample()
        )
    }
}
