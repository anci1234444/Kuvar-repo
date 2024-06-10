import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD

protocol RecipeCellDelegate: AnyObject {
    func didTapReadMore(for recipe: Recipe)
}
class RecipeCollectionViewCell: UICollectionViewCell {
    weak var delegate: RecipeCellDelegate?
    var recipe:Recipe!
    var recipeImageView: UIImageView!
    var recipeNameLabel: UILabel!
    var secondLabel: UILabel!
    var favoritesButton: UIButton! // Add favorites button
    var isFavorite: Bool = false // Track favorite state
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // create and configure UIImageView
        recipeImageView = UIImageView()
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true // Ensuring content does not overflow
        recipeImageView.layer.cornerRadius = 10 // Setting corner radius for rounded edges
        contentView.addSubview(recipeImageView)
        
        //create and configure favorites button
        favoritesButton = UIButton(type: .custom)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.setImage(UIImage(named: "favorite.png")?.withRenderingMode(.alwaysTemplate), for: .normal) // Seting the heart icon image with rendering mode .alwaysTemplate
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside) // Adding action for button tap
        favoritesButton.tintColor = .red // Setting default tint color
        favoritesButton.isUserInteractionEnabled = true
        contentView.addSubview(favoritesButton) // Adding button to the content view
        
        
        
        
        
        // create and configure UILabel for recipe name
        recipeNameLabel = UILabel()
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.numberOfLines = 0
        recipeNameLabel.font = UIFont(name: "Poppins-Regular", size: 12) // Setting font to Poppins
        contentView.addSubview(recipeNameLabel)
        
        // create and configure second UILabel
        secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.numberOfLines = 0
        secondLabel.font = UIFont(name: "Poppins-SemiBold", size: 10)
        secondLabel.textColor = .black // Changing the color for highlighting
        contentView.addSubview(secondLabel)
        
        
        
        // setup constraints for the Read More button
        
        
        
        // set up constraints
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            recipeImageView.heightAnchor.constraint(equalToConstant: 125), // Setting a fixed height for the image
            
            favoritesButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            favoritesButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -8),
            favoritesButton.widthAnchor.constraint(equalToConstant: 30), // Setting width of the button
            favoritesButton.heightAnchor.constraint(equalToConstant: 30), // Setting height of the button
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            secondLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 2),
            secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
            
        ])
    }
    
    
    
    public let favoritesKey = "coovarFavorites" // key to save favorites in UserDefaults
    
    // function to check if the recipe is in favorites..
    private func isRecipeFavorite() -> Bool {
        guard let favoriteRecipesData = UserDefaults.standard.array(forKey: favoritesKey) as? [Data] else {
            return false
        }
        
        // checking if a recipe exists in favorites based on its label.
        return favoriteRecipesData.contains {
            if let storedRecipe = try? JSONDecoder().decode(Recipe.self, from: $0) {
                return storedRecipe.label == recipe.label
            }
            return false
        }
    }
    
    // Function to add recipe to favorites.
    private func addToFavorites() {
        var favoriteRecipes = UserDefaults.standard.array(forKey: favoritesKey) as? [Data] ?? []
        
        //Storing the entire recipe object as Data in UserDefaults
        do {
            let recipeData = try JSONEncoder().encode(recipe)
            favoriteRecipes.append(recipeData)
            UserDefaults.standard.set(favoriteRecipes, forKey: favoritesKey)
        } catch {
            print("Error encoding recipe: \(error.localizedDescription)")
        }
    }
    
    // function to remove recipe from favorites
    private func removeFromFavorites() {
        var favoriteRecipes = UserDefaults.standard.array(forKey: favoritesKey) as? [Data] ?? []
        
        // removing the recipe from the list of favorites
        if let index = favoriteRecipes.firstIndex(where: { data in
            if let storedRecipe = try? JSONDecoder().decode(Recipe.self, from: data) {
                return storedRecipe.label == recipe.label
            }
            return false
        }) {
            favoriteRecipes.remove(at: index)
            UserDefaults.standard.set(favoriteRecipes, forKey: favoritesKey)
        }
    }
    
    
    
    @objc func favoritesButtonTapped() {
        isFavorite = !isFavorite // Updating the state of favorites...
        
        // Updating the heart display based on the favorite state
        if isFavorite {
            favoritesButton.setImage(UIImage(named: "favoriteFilled.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            addToFavorites()
        } else {
            favoritesButton.setImage(UIImage(named: "favorite.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            removeFromFavorites()
        }
    }
    
    
    func configure(with recipe: Recipe) {
        
        self.recipe = recipe
        
        // fetching the image asynchronously
        if let url = URL(string: recipe.imageURL) {
            recipeImageView.af.setImage(withURL: url)
        }
        
        // setting the recipe name and time
        recipeNameLabel.text = recipe.label
        secondLabel.text = "\(recipe.totalTime) min"
        
        
        contentView.subviews.forEach { subview in
            if subview.tag == 999 {
                subview.removeFromSuperview()
            }
        }
        
        
        if recipe.totalTime >= 0 {
            if let totalTimeLabel = contentView.viewWithTag(999) as? UILabel {
                totalTimeLabel.text = "\(recipe.totalTime) min"
            } else {
                let totalTimeLabel = UILabel()
                totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
                totalTimeLabel.font = UIFont(name: "Poppins-SemiBold", size: 10)
                totalTimeLabel.text = "\(recipe.totalTime) min"
                totalTimeLabel.tag = 999 // Setting a tag to identify the total time label..
                contentView.addSubview(totalTimeLabel) // Adding to contentView
                
                // Set constraints for the total time label
                NSLayoutConstraint.activate([
                    totalTimeLabel.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor),
                    totalTimeLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5), // Adjusted top constraint.
                    totalTimeLabel.trailingAnchor.constraint(equalTo: secondLabel.trailingAnchor),
                    totalTimeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
                ])
            }
        }
        
        let readMoreButton = UIButton(type: .custom)
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.setTitleColor(.red, for: .normal)
        readMoreButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 8)
        readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            readMoreButton.leadingAnchor.constraint(equalTo: secondLabel.trailingAnchor, constant: -40),
            readMoreButton.topAnchor.constraint(equalTo: secondLabel.topAnchor),
            readMoreButton.bottomAnchor.constraint(equalTo: secondLabel.bottomAnchor)
        ])
        
        
        // Checking and setting the status of favorites.
        isFavorite = isRecipeFavorite()
        let favoriteImageName = isFavorite ? "favoriteFilled.png" : "favorite.png"
        favoritesButton.setImage(UIImage(named: favoriteImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @objc func readMoreTapped() {
        print("Read More tapped")
        if let recipe = self.recipe {
            delegate?.didTapReadMore(for: recipe)
        }
    }
}
