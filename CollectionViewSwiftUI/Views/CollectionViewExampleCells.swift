//
//  CollectionViewExampleCells.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 10/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import SwiftUI

struct TextCollectionViewCell: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(10)
    }
}

struct ImageCellView: View {
    let model: PhotosViewModel
    var body: some View {
        VStack {
            Image(uiImage: model.image)
            Text(model.name)
        }
    }
}

struct ImageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCellView(model: PhotosViewModel.getOneExample())
    }
}

struct EmojiCollectionViewCell: View {
    let model: EmojiViewModel
    var body: some View {
        VStack {
            getImageStack(with: model.image)
                .padding()
            getTextStack(with: model.emojisInText)
                .padding()
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

    private func getTextStack(with string: String) -> some View {
        let amount = Int.random(in: 1...4)

        switch amount {
        case 2:
            return AnyView(VStack {
                Text(string)
                Text(string)

            })
        case 3:
            return AnyView(VStack {
                Text(string)
                Text(string)
                Text(string)
            })
        case 4:
            return AnyView(VStack {
                Text(string)
                Text(string)
                Text(string)
                Text(string)
            })
        default:
            return AnyView(Text(string))

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
