//
//  RandomPhotoManager.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import Foundation

class RandomPhotoManager {
    
    func searchPhoto(completion: @escaping (RandomPhoto?) -> Void ) {
    
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(APIKey.accessKey)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else { return }
            
            do {
                let result = try JSONDecoder().decode(RandomPhoto.self, from: data!)
                completion(result)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
