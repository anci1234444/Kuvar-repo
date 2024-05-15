//
//  Recipe.swift
//  KuvarApp
//
//  Created by Ana Asceric on 26.4.24..
//

import UIKit
import Alamofire
import MBProgressHUD

struct Recipe: Codable {
    
    let imageURL: String
    let label: String
    let totalTime:Int
    // var isFavorite: Bool? = false
    
    
    enum CodingKeys: String, CodingKey {
        
        case imageURL = "image"
        case label
        case totalTime
        // case isFavorite
    }
}


