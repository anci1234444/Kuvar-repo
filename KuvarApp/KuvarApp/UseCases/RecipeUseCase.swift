//
//  RecipeUseCase.swift
//  KuvarApp
//
//  Created by Ana Asceric on 30.4.24..
//

import UIKit
import Alamofire
import MBProgressHUD


class RecipeUseCase {
    private let recipeAPIClient = RecipeAPIClient()
    
    func fetchRecipes(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        recipeAPIClient.searchRecipes(query: query, completion: completion)
    }
}
