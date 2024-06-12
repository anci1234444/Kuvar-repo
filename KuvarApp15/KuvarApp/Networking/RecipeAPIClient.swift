//
//  RecipeViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 26.4.24..
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD

class RecipeAPIClient {
    
    private let baseUrl = "https://api.edamam.com"
    private let appId = "e665eb00"
    private let appKey = "dccdbdb6f2eff307a167d4a8e8050ca3"
    
    func searchRecipes(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let endpoint = "\(baseUrl)/api/recipes/v2"
        
        var urlComponents = URLComponents(string: endpoint)!
        urlComponents.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "app_id", value: appId),
            URLQueryItem(name: "app_key", value: appKey)
        ]
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "URL Construction Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to construct URL"])
            completion(.failure(error))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: RecipeResponse.self) { response in
            switch response.result {
            case .success(let recipeResponse):
                let recipes = recipeResponse.hits.map { $0.recipe }
                completion(.success(recipes))
            case .failure(let error):
                print("Error: \(error)")
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Response data: \(utf8Text)")
                }
                completion(.failure(error))
            }
        }
        
    }
}




struct RecipeResponse: Codable {
    let hits: [Hit]
    
    struct Hit: Codable {
        let recipe: Recipe
        
    }
}







