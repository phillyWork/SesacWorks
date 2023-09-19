//
//  ListConfigurationNetworkManager.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/14.
//

import Foundation
import UIKit

class ListConfigurationNetworkManager {
    
    func searchPhoto(query: String, completion: @escaping (Photo?) -> Void ) {
    
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.accessKey)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("URLSession dataTask Error: ", error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                print("HTTP status code error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Photo.self, from: data!)
                completion(result)
            } catch {
                print("JSON Decoder Error occurred")
                print(error)
            }
        }.resume()
        
    }
    
    func getImageFromNetwork(url: String, completionHandler: @escaping (UIImage) -> ()) {
        guard let url = URL(string: url) else {
            print("Can't get URL")
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
                
            } catch {
                print("Getting Image Failed")
            }
        }
    }
    
}
