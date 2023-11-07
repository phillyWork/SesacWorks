//
//  RandomPhotoViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import UIKit

class RandomPhotoViewModel {
    
    let photoManager = RandomPhotoManager()
    
    var randomPhoto: Observable<RandomPhoto?> = Observable(nil)
    
    var imageFromURL: Observable<UIImage?> = Observable(nil)
    
    func callRequest() {
        photoManager.searchPhoto { randomPhoto in
            DispatchQueue.main.async {
                self.randomPhoto.value = randomPhoto
            }
        }
    }
    
    func getPhotoWithURL(url: String?) {
        if let urlString = url, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                do {
                    let imageData = try Data(contentsOf: url)
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.imageFromURL.value = image
                        }
                    }
                } catch {
                    print("Image From Network Error")
                }
            }
        }
    }
    
}
