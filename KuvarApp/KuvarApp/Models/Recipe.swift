//
//  Recipe.swift
//  KuvarApp
//
//  Created by Ana Asceric on 26.4.24..
//

import UIKit
import Alamofire
import MBProgressHUD

struct Recipe: Codable, Equatable {
    var createdFromNewRecipeViewController: Bool = true
    var imageURL: String?
    var imageData: Data?
    let label: String
    let totalTime:Int
    let ingredientLines:[String]?
    let calories:Double
    let totalCO2Emissions:Double
    let cuisineType: [String]?
    let mealType: [String]?
    let dishType:[String]?
    let dietLabels:[String]?
   
    
    
    enum CodingKeys: String, CodingKey {
        
        case imageURL = "image"
        case imageData
        case label
        case totalTime
        case ingredientLines
        case calories
        case totalCO2Emissions
        case cuisineType
        case mealType
        case dishType
        case dietLabels
       
    }
}


