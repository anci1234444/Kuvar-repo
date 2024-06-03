//
//  RecipeDetailsViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 28.5.24..
//
import UIKit
import Alamofire
import AlamofireImage

class RecipeDetailsViewController: UIViewController {
    var recipe: Recipe?
    var titleLabel: UILabel!
    var recipeImageView:UIImageView!
    var ingredientsLabel:UILabel!
    var totalTimeLabel:UILabel!
    var caloriesLabel:UILabel!
    var totalCO2Label: UILabel!
    var cuisineTypeLabel: UILabel!
    var mealTypeLabel:UILabel!
    var dishTypeLabel:UILabel!
    var dietLabel:UILabel!
    var favoriteButton: UIButton!
    var isFavorite: Bool = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        displayRecipeDetails()
        
        // adding an observer for favorite recipes updated notification.
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteRecipesUpdated), name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
    }

    @objc private func handleFavoriteRecipesUpdated() {
        // reloading collection view
      //  collectionView.reloadData()
    }

    deinit {
        // removing an observer when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
        
    
    
    private func setupUI() {
        
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        recipeImageView = UIImageView()
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        //   recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10 // rounded corners
        
        view.addSubview(recipeImageView)
        
        ingredientsLabel = UILabel()
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.textColor = .black
        ingredientsLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ingredientsLabel)
        
        totalTimeLabel = UILabel()
        totalTimeLabel?.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel?.numberOfLines = 0
        totalTimeLabel?.font = UIFont(name: "Poppins-SemiBold", size: 12)
        view.addSubview(totalTimeLabel!)
        
        caloriesLabel = UILabel()
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        caloriesLabel.textAlignment = .left
        view.addSubview(caloriesLabel)
        
        totalCO2Label = UILabel()
        totalCO2Label.translatesAutoresizingMaskIntoConstraints = false
        totalCO2Label.font = UIFont(name: "Poppins-SemiBold", size: 12)
        totalCO2Label.textAlignment = .left
        view.addSubview(totalCO2Label)
        
        cuisineTypeLabel = UILabel()
        cuisineTypeLabel.numberOfLines = 0
        cuisineTypeLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        cuisineTypeLabel.textAlignment = .left
        cuisineTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cuisineTypeLabel)
        
        mealTypeLabel = UILabel()
        cuisineTypeLabel.numberOfLines = 0
        mealTypeLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        mealTypeLabel.textAlignment = .left
        mealTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mealTypeLabel)
        
        dishTypeLabel = UILabel()
        dishTypeLabel.numberOfLines = 0
        dishTypeLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        dishTypeLabel.textAlignment = .left
        dishTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dishTypeLabel)
        
        dietLabel = UILabel()
        dietLabel.numberOfLines = 0
        dietLabel.font = UIFont(name: "Poppins-SemiBold", size: 12)
        dietLabel.textAlignment = .left
        dietLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dietLabel)
        
        
        
        
        
        
        // Adding a "Close" button
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        //create and configure favorites button
        favoriteButton = UIButton(type: .custom)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: "favorite.png")?.withRenderingMode(.alwaysTemplate), for: .normal) // Seting the heart icon image with rendering mode .alwaysTemplate
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside) // Adding action for button tap
        favoriteButton.tintColor = .red // Setting default tint color
        favoriteButton.isUserInteractionEnabled = true
        view.addSubview(favoriteButton) // Adding button to the content view
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            // Add constraints for other UI elements
        ])
        
        NSLayoutConstraint.activate([
            
            recipeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            totalTimeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            recipeImageView.heightAnchor.constraint(equalToConstant: 225)
        ])
        
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant:15),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-10)
        ])
        NSLayoutConstraint.activate([
            totalTimeLabel.topAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant:265),
            totalTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalTimeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: totalTimeLabel.topAnchor, constant: 32),
            caloriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            caloriesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            caloriesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            totalCO2Label.topAnchor.constraint(equalTo: caloriesLabel.topAnchor, constant: 32),
            totalCO2Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalCO2Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalCO2Label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            cuisineTypeLabel.topAnchor.constraint(equalTo: totalCO2Label.topAnchor, constant: 32),
            cuisineTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cuisineTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cuisineTypeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            mealTypeLabel.topAnchor.constraint(equalTo: cuisineTypeLabel.topAnchor, constant: 32),
            mealTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mealTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mealTypeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dishTypeLabel.topAnchor.constraint(equalTo: mealTypeLabel.topAnchor, constant: 32),
            dishTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dishTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dishTypeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dietLabel.topAnchor.constraint(equalTo: dishTypeLabel.topAnchor, constant: 32),
            dietLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dietLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dietLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    private func displayRecipeDetails() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.label
        
        if let url = URL(string: recipe.imageURL) {
            recipeImageView.af.setImage(withURL: url)
        }
        if let ingredients = recipe.ingredientLines {
            ingredientsLabel.text = "Ingredients:\n" + ingredients.joined(separator: "\n")
        } else {
            ingredientsLabel.text = "Ingredients: N/A" //  when ingredient lines are not available..
        }
        totalTimeLabel?.text = "Total time: \(recipe.totalTime) min"
        caloriesLabel.text = "Calories: \(String(recipe.calories)) kcal"
        totalCO2Label.text = "Total CO2 emissions: \(String(recipe.totalCO2Emissions)) g"
        if let cuisineTypes = recipe.cuisineType {
            cuisineTypeLabel.text = "Cuisine type: " + cuisineTypes.joined(separator: "\n")
        } else {
            cuisineTypeLabel.text = "Cuisine type: N/A" //  when cuisine types are not available..
        }
        
        if let mealTypes = recipe.mealType {
            mealTypeLabel.text = "Meal type: " + mealTypes.joined(separator: "\n")
        } else {
            mealTypeLabel.text = "Meal type: N/A" //  when meal types are not available..
        }
        if let dishTypes = recipe.dishType {
            dishTypeLabel.text = "Dish type: " + dishTypes.joined(separator: "\n")
        } else {
            dishTypeLabel.text = "Dish type: N/A" //  when dish types are not available..
        }
        if let diet = recipe.dietLabels {
            dietLabel.text = "Diet label: " + diet.joined(separator: " ")
        } else {
            dietLabel.text = "Diet label: N/A" //  when dish types are not available..
        }
        
        // Updating favorite status.
        self.recipe = recipe
      updatedFavoriteStatus()
    }
    private func setupNavigationBar() {
        // Creating a back button
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        // set the back button as the left bar button item.
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    // Function to handle close button tap
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
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
                return storedRecipe.label == recipe?.label
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
                return storedRecipe.label == recipe?.label
            }
            return false
        }) {
            favoriteRecipes.remove(at: index)
            UserDefaults.standard.set(favoriteRecipes, forKey: favoritesKey)
        }
    }
    @objc func favoriteButtonTapped() {
        isFavorite = !isFavorite // Updating the state of favorites...
        // Update the button's image based on the favorite state
        let imageName = isFavorite ? "favoriteFilled.png" : "favorite.png"
        favoriteButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        // Add or remove the recipe from favorites based on the state
        if isFavorite {
            addToFavorites()
    } else {
          removeFromFavorites()
       }
       

    }
    // Function to update favorite status and UI
    func updatedFavoriteStatus() {
        isFavorite = isRecipeFavorite()
        let favoriteImageName = isFavorite ? "favoriteFilled.png" : "favorite.png"
        favoriteButton.setImage(UIImage(named: favoriteImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    

}

