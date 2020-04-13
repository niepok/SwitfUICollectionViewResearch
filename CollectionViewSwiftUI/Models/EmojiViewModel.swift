//
//  EmojiViewModel.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 30/12/2019.
//  Copyright © 2019 Adam Niepokój. All rights reserved.
//

import UIKit
import Foundation

struct EmojiViewModel: Identifiable {
    let id: UUID
    let image: UIImage
    let emojisInText: String

    static func getOneExample() -> EmojiViewModel {
        return EmojiViewModel(
            id: UUID(),
            image: "🎉".image(),
            emojisInText: "🎉🎉🎉🎉"
        )
    }

    static func getArrayExample() -> [EmojiViewModel] {
        let emojis = "🥩🍗🍖🥓🍕🥔🥦🥒🥬🍆🌶🌽🍊🍇🥩🍗🍖🥓🍕🥔🥦🥒🥬🍆🌶🌽🍊🍇"
        let emojisArray = emojis.map { "\($0)" }
        return emojisArray.map {
            EmojiViewModel(
                id: UUID(),
                image: $0.image(),
                emojisInText: $0+$0+$0+$0
            )
        }
    }
}
