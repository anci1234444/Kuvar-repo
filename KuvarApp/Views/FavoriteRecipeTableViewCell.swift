//
//  FavoriteRecipeTableViewCell.swift
//  KuvarApp
//
//  Created by Ana Asceric on 15.5.24..
//

import UIKit
import Alamofire
import AlamofireImage

protocol FavoriteRecipeCellDelegate: AnyObject {
    func didTapReadMore(for recipe: Recipe)
}
class FavoriteRecipeTableViewCell: UITableViewCell {
    weak var delegate: FavoriteRecipeCellDelegate?
    var recipe: Recipe!
    var recipeImageView: UIImageView!
    var recipeNameLabel: UILabel!
    var secondLabel: UILabel!
    var totalTimeLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setupCellAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupCellAppearance()
    }
    
    private func commonInit() {
        // configure image view....
        recipeImageView = UIImageView()
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10 // rounded corners
        
        
        contentView.addSubview(recipeImageView)
        
        
        recipeNameLabel = UILabel()
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.numberOfLines = 0
        recipeNameLabel.font = UIFont(name: "Poppins-Regular", size: 12)
        contentView.addSubview(recipeNameLabel)
        
        secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.numberOfLines = 0
        secondLabel.font = UIFont(name: "Poppins-Regular", size: 10)
        secondLabel.textColor = .gray
        contentView.addSubview(secondLabel)
        
        totalTimeLabel = UILabel()
        totalTimeLabel?.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel?.numberOfLines = 0
        totalTimeLabel?.font = UIFont(name: "Poppins-SemiBold", size: 10)
        contentView.addSubview(totalTimeLabel!)
        
        // setup constraints
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            recipeImageView.widthAnchor.constraint(equalToConstant: 60),
            
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            recipeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            secondLabel.leadingAnchor.constraint(equalTo: recipeNameLabel.leadingAnchor),
            secondLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 5),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            totalTimeLabel!.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor),
            totalTimeLabel!.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5),
            totalTimeLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupCellAppearance() {
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        
        if let url = URL(string: recipe.imageURL) {
            recipeImageView.af.setImage(withURL: url) { [weak self] _ in
                self?.setNeedsLayout()
            }
        }
        
        recipeNameLabel.text = recipe.label
        
        if let firstIngredient = recipe.ingredientLines?.first {
            secondLabel.text = firstIngredient
            
            // Checking if there are more than one ingredient lines....
            if (recipe.ingredientLines?.count ?? 0) > 1 {
                let readMoreButton = UIButton(type: .custom)
                readMoreButton.setTitle("Read More", for: .normal)
                readMoreButton.setTitleColor(.red, for: .normal)
                readMoreButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 8)
                readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
                readMoreButton.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(readMoreButton)
                
                // setup constraints for the Read More button
                NSLayoutConstraint.activate([
                    readMoreButton.leadingAnchor.constraint(equalTo: secondLabel.trailingAnchor, constant: -40),
                    readMoreButton.topAnchor.constraint(equalTo: secondLabel.topAnchor),
                    readMoreButton.bottomAnchor.constraint(equalTo: secondLabel.bottomAnchor)
                    
                    
                    
                ])
                
                
            }
        }
        
        totalTimeLabel?.text = "\(recipe.totalTime) min"
    }
    
    
    @objc func readMoreTapped() {
        print("Read More tapped")
        if let recipe = self.recipe {
            delegate?.didTapReadMore(for: recipe)
        }
    }
    
}
