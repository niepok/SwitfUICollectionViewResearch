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

struct BigPokemonCell: View {
    let pok: PokemonImage
    var body: some View {
        VStack {
            Image(uiImage: pok.image)
                .resizable()
                .frame(maxWidth: 150,  maxHeight: 150)

            Text(pok.pokemon.pokeName)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
        }
    }
}

struct PokemonCell: View {
    let pok: PokemonImage
    var body: some View {
        VStack {
            Image(uiImage: pok.image)
                .resizable()
                .frame(maxWidth: 75,  maxHeight: 75)

            Text(pok.pokemon.pokeName)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
        }
    }
}

struct PokemonHorizontalCell: View {
    let pok: PokemonImage
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Image(uiImage: pok.image)
                    .resizable()
                    .frame(maxWidth: 100,  maxHeight: 100)

            }

            VStack(alignment: .center) {
                Text("No: \(pok.pokemon.id)")
                    .fontWeight(.bold)
                Text(pok.pokemon.pokeName)
                    .fontWeight(.semibold)
                Text("Type: \(pok.pokemon.typeString)")
            }
        }
        .frame(width: 300)
    }
}

struct PokemonSmallHorizontalCell: View {
    let pok: PokemonImage
    var body: some View {
        HStack {
            Image(uiImage: pok.image)
                .resizable()
                .frame(maxWidth: 75,  maxHeight: 75)
            VStack {
                Text(pok.pokemon.pokeName)
                    .fontWeight(.semibold)
            }
        }.padding(.trailing, 10)
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
