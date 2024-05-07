//
//  RecipesTableViewCell.swift
//  KuvarApp
//
//  Created by Ana Asceric on 29.4.24..
//

import UIKit
import Alamofire
import MBProgressHUD

class RecipesTableViewCell: UITableViewCell {
    
    var recipeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // kreiranje i konfigurisanje ui elemenata
        recipeNameLabel = UILabel()
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.numberOfLines = 0 // dozvolice labeli da wrapuje tekst
        
        // dodavanje labele u celijin content view
        contentView.addSubview(recipeNameLabel)
        
        // podesavanje constrainta
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with recipe: Recipe) {
        recipeNameLabel.text = recipe.label
    }
}


