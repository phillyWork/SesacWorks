//
//  SingletonManager.swift
//  TMDBTrendingAllMultipleCellInTableViewCell
//
//  Created by Heedon on 2023/09/03.
//

import Foundation

class SingletonManager {
    
    static let shared = SingletonManager()
    private init() { }
    
    //MARK: - Network Properties
    private let url = "https://api.themoviedb.org/3/trending/all/day?page="
    
    //MARK: - Data Properties

    private var totalData: [Trend] = []
    
    private var pageNum = 1
    
    //MARK: - PASS DATA
    
    func getData() -> [Trend] {
        return totalData
    }
    
    func getPageNum() -> Int {
        return pageNum
    }
    
    //MARK: - UPDATE DATA
    
    func addPage() {
        pageNum += 1
    }
    
    //MARK: - GET FROM API
    
    func callRequest(page: Int, completionHandler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: url + "\(pageNum)") else { return }
        var request = URLRequest(url: url, timeoutInterval: 30)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(APIKey.tmdbAccessTokenAuth)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                completionHandler(false)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print(error)
                completionHandler(false)
                return
            }
            
            guard let data = data else {
                completionHandler(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingAllList.self, from: data)
                print(result)
                self.totalData.append(contentsOf: result.trendingList)
                completionHandler(true)
            } catch {
                print(error)
                completionHandler(false)
            }
        }.resume()
    }
    
}
