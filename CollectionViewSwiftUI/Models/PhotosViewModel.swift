//
//  ImageViewModel.swift
//  CollectionViewSwiftUI
//
//  Created by Adam Niepokój on 03/01/2020.
//  Copyright © 2020 Adam Niepokój. All rights reserved.
//

import UIKit
import Foundation

struct PhotosViewModel: Identifiable {
    let id: UUID
    let image: UIImage
    let name: String

    static func getOneExample() -> PhotosViewModel {
        PhotosViewModel.allPhotos().first!
    }

    static func getArrayExample() -> [PhotosViewModel] {
        (PhotosViewModel.allPhotos() + PhotosViewModel.allPhotos()).shuffled()
    }

    static func allPhotos() -> [PhotosViewModel] {
      var photos: [PhotosViewModel] = []
      guard
        let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
        let photosFromPlist = NSArray(contentsOf: URL) as? [[String: String]]
        else {
          return photos
      }
      for dictionary in photosFromPlist {
        if let image = dictionary["Photo"], let photo = UIImage(named: image), let name = dictionary["Caption"] {
          photos.append(PhotosViewModel(id: UUID(), image: photo, name: name))
        }
      }
      return photos
    }
}
