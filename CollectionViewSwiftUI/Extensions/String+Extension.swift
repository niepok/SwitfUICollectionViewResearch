//
//  String+Extension.swift
//  CAEmitterLayerResearch
//
//  Created by Adam Niepokój on 20/11/2019.
//  Copyright © 2019 Adam Niepokój. All rights reserved.
//

import UIKit

extension String {
    func image(with font: UIFont = UIFont.systemFont(ofSize: 16.0)) -> UIImage {
        let string = NSString(string: "\(self)")
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let size = string.size(withAttributes: attributes)

        return UIGraphicsImageRenderer(size: size).image { _ in
            string.draw(at: .zero, withAttributes: attributes)
        }
    }

    func images(with font: UIFont = UIFont.systemFont(ofSize: 16.0)) -> [UIImage] {
        return self.map { "\($0)".image() }
    }
}

// hack for this example
extension String: Identifiable {
    public var id: String { self }
}
