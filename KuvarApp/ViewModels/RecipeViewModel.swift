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
        // Ovde možete postaviti query za pretragu recepata koje želite da prikažete na ekranu za istraživanje
        let query = "explore" // Primer: "explore"
        
        // Pozivamo metodu iz RecipeUseCase koja će dohvatiti željene recepte
        recipeUseCase.fetchRecipes(query: query) { [weak self] result in
            switch result {
            case .success(let recipes):
                // Čuvamo samo prvih 10 recepata za ekran za istraživanje
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

