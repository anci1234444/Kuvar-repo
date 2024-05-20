//
//  RecipeViewModel.swift
//  KuvarApp
//
//  Created by Ana Asceric on 30.4.24..
//

import UIKit
import Alamofire
import MBProgressHUD


class RecipeViewModel {
    private let recipeUseCase = RecipeUseCase()
    
    var recipes: [Recipe] = []
    
    func fetchRecipes(query: String, completion: @escaping (Error?) -> Void) {
        recipeUseCase.fetchRecipes(query: query) { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

