//
//  BeerViewModel.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import UIKit

class BeerViewModel {
    
    var beers: Observable<[Beer]?> = Observable(nil)
    var page = Observable(1)
    var id: Int?
    
    private let networkManager = BeerNetworkManager.shared
    
    func networkCall(api: BeerAPI) {
        networkManager.callRequest(type: Beer.self, api: api) { response in
//        networkManager.callRequest(type: [Beer].self, api: api) { response in
            switch response {
            case .success(let success):
                self.beers.value?.append(success)
//                self.beers.value?.append(contentsOf: success)
                print("result: ", self.beers.value)
                self.id = self.beers.value?.first?.id
            case .failure(let failure):
                print("Can't bring beer data from API:", failure.localizedDescription)
            }
        }
    }
    
    func getImage(url: String, completionHandler: @escaping (UIImage) -> Void ) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                    completionHandler(image)
                }
            } catch {
                print("Can't get image from url")
            }
        }
    }
    
}
