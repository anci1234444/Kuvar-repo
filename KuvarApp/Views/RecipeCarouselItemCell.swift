//
// RecipeCarouselItemCell.swift
// KuvarApp
//
// Created by Ana Asceric on 20.5.24..
//
import UIKit
import Alamofire
import AlamofireImage


protocol ExploreCellDelegate: AnyObject {
    func didTapReadMore(for recipe: Recipe)
}

class RecipeCarouselItemCell: UICollectionViewCell {
    weak var delegate: ExploreCellDelegate?
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var ingredientsLabel:UILabel!
   var scrollView:UIScrollView!
    var contentContainerView:UIView!
    var favoritesButton: UIButton! // New favorites button...
    
    var recipe: Recipe!
    var isFavorite: Bool = false // Tracking favorite state..
    
    private let favoritesKey = "coovarFavorites"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Adding a new tap gesture recognizer to the image view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        contentView.addSubview(imageView)
        
        
        
        // Creating title label
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear // Set background color to clear..
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        
        // Creating a UIScrollView
       scrollView = UIScrollView()
     scrollView.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(scrollView)
        
        // Creating a container view for the content within the scroll view
        contentContainerView = UIView()
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentContainerView)
        
        //    creating ingredients label
        ingredientsLabel = UILabel()
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.textColor = .black
        ingredientsLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(ingredientsLabel)
        
        
        //creating fav button
        favoritesButton = UIButton(type: .custom)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.setImage(UIImage(named: "favorite.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        favoritesButton.tintColor = .red // Setting default tint color
        favoritesButton.isUserInteractionEnabled = true
        contentContainerView.addSubview(favoritesButton) // Adding button to the content view
        
        // Adding constraints for imageView.
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -220)
        ])
        
        // Adding constraints for titleLabel.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        // Constraints for scrollView.
      NSLayoutConstraint.activate([
           scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
       ])
        
        // Constraints for contentContainerView..
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        // Constraints for ingredientsLabel inside contentContainerView..
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant:15),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -20),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
        ])
        
        
        // Constraints for favorites button..
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant:15),
            favoritesButton.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 250),
            favoritesButton.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            favoritesButton.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
        ])
        
        
        // Calculate the height required for the ingredientsLabel based on its content..
        let labelSize = ingredientsLabel.sizeThatFits(CGSize(width: contentView.bounds.width - 40, height: .greatestFiniteMagnitude))
        
        // updating the frame of the ingredientsLabel and the contentSize of the scrollView
        ingredientsLabel.frame = CGRect(x: 20, y: titleLabel.frame.maxY + 35, width: contentView.bounds.width - 40, height: labelSize.height)
        
        // Adjusting content size of the scrol view to enable scrolling.
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: ingredientsLabel.frame.maxY)
    }
    
    
    
    
    func configure(with recipe: Recipe) {
        guard let imageURL = URL(string: recipe.imageURL ) else {
            print("Invalid URL format:", recipe.imageURL)
            imageView.image = nil
            return
        }
        
        print("Image URL:", imageURL)
        // Loading the image asynchronously..
        imageView.af.setImage(withURL: imageURL)
        
        // Set recipe label..
        print("Recipe label:", recipe.label)
        titleLabel.text = recipe.label
        
        // Set ingredients label..
        //   ingredientsLabel.text = "Ingredients:\n" + recipe.ingredientLines.joined(separator: "\n")
        
        if let ingredients = recipe.ingredientLines {
            ingredientsLabel.text = "Ingredients:\n" + ingredients.joined(separator: "\n")
        } else {
            ingredientsLabel.text = "Ingredients: N/A" //  when ingredient lines are not available..
        }
        
        // Updating favorite status.
        self.recipe = recipe
        updateFavoriteStatus()
        
       
    }
    
    // Function to update favorite status and UI
    func updateFavoriteStatus() {
        isFavorite = isRecipeFavorite()
        let favoriteImageName = isFavorite ? "favoriteFilled.png" : "favorite.png"
        favoritesButton.setImage(UIImage(named: favoriteImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    // Function to check if the recipe is a favorite...
    private func isRecipeFavorite() -> Bool {
        guard let favoriteRecipesData = UserDefaults.standard.array(forKey: favoritesKey) as? [Data],
              let currentRecipe = recipe,
              let currentIngredients = currentRecipe.ingredientLines else {
            return false
        }
        
        let currentIngredientsSet = Set(currentIngredients)
        
        for data in favoriteRecipesData {
            if let storedRecipe = try? JSONDecoder().decode(Recipe.self, from: data),
               let storedIngredients = storedRecipe.ingredientLines {
                let storedIngredientsSet = Set(storedIngredients)
                if storedIngredientsSet == currentIngredientsSet {
                    return true
                }
            }
        }
        
        return false
    }
    @objc func readMoreTapped() {
        print("Read More tapped")
        if let recipe = self.recipe {
            delegate?.didTapReadMore(for: recipe)
        }
        
    }
    
    
}
