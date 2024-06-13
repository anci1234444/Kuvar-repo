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
    
    func fetchExploreRecipes(completion: @escaping (Error?) -> Void) {
     
        let query = "explore"
        
        // calling a method from RecipeUseCase that will retrieve the desired recipes
        recipeUseCase.fetchRecipes(query: query) { [weak self] result in
            switch result {
            case .success(let recipes):
                // save first 10 recipes
                self?.recipes = Array(recipes.prefix(10))
               // self?.recipes = recipes
           //     print("Fetched recipes successfully:", self?.recipes)
                completion(nil)
            case .failure(let error):
           //     print("Failed to fetch recipes:", error)
                completion(error)
            }
        }
    }
}

