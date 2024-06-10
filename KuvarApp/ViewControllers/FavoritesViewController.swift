//
//  FavoritesViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 15.5.24..
//

import UIKit
import Alamofire
import MBProgressHUD

class FavoritesViewController: UIViewController, FavoriteRecipeCellDelegate  {
    weak var coordinator: MainCoordinator?
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var favoriteRecipes: [Recipe] = []
    let headingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "circle"), for: .normal)
        button.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        return button
    }()
    private let noFavoritesView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           
           let imageView = UIImageView(image: UIImage(named: "background_02"))
           imageView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(imageView)
           
        let mainLabel = UILabel()
                mainLabel.text = "Really no favorites?"
                mainLabel.font = UIFont.boldSystemFont(ofSize: 18) // Bold and bigger text
                mainLabel.textAlignment = .center
                mainLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(mainLabel)
                
                let subLabel = UILabel()
                subLabel.text = "C'mon, we all have some favorite recipes, right?\nLet's add some together. You can browse some or create your own!"
                subLabel.numberOfLines = 0
                subLabel.font = UIFont.systemFont(ofSize: 14) // Regular text
                subLabel.textAlignment = .center
                subLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(subLabel)
           
           let button = UIButton(type: .system)
           button.setTitle("Browse Recipes", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.backgroundColor = .red
           button.setTitleColor(.white, for: .normal)
           button.layer.cornerRadius = 5
           button.layer.shadowColor = UIColor.black.cgColor
           button.layer.shadowOffset = CGSize(width: 0, height: 2)
           button.layer.shadowOpacity = 1
           button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(browseRecipesButtonTapped), for: .touchUpInside)
           
           view.addSubview(button)
           
           NSLayoutConstraint.activate([
               imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
               imageView.widthAnchor.constraint(equalToConstant: 200),
               imageView.heightAnchor.constraint(equalToConstant: 200),
               
               mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                          
                subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
                subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                          
                button.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 20),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 150),
                button.heightAnchor.constraint(equalToConstant: 50)
           ])
           
           return view
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadFavoriteRecipes()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteRecipesUpdated), name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
  //      NotificationCenter.default.addObserver(self, selector: #selector(loadFavoriteRecipes), name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
        view.addSubview(headingImageView)
        view.addSubview(noFavoritesView)
        view.addSubview(uploadButton) 
        
        // Setup constraints for the image view
        NSLayoutConstraint.activate([
            headingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            headingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            headingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            headingImageView.heightAnchor.constraint(equalToConstant: 30) // height constraint
        ])
        
        headingImageView.image = UIImage(named: "pageHeading")
        
        NSLayoutConstraint.activate([
            uploadButton.widthAnchor.constraint(equalToConstant: 60),
            uploadButton.heightAnchor.constraint(equalToConstant: 60),
            uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            uploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            noFavoritesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                      noFavoritesView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                      noFavoritesView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
                      noFavoritesView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -200)
                  ])
        
        
        
        uploadButton.layer.zPosition = view.layer.zPosition + 1
        noFavoritesView.isHidden = true
    }
    @objc private func browseRecipesButtonTapped() {
        // Method to handle the "Browse Recipes" button tap
              let recipeVC = RecipeViewController()
              navigationController?.pushViewController(recipeVC, animated: true)
          
    }
    @objc private func favoriteRecipesUpdated() {
        loadFavoriteRecipes()
    }
 /*   @objc private func uploadButtonTapped() {
        // only print statement for now...
        print("Upload button tapped")
      let newViewController = NewRecipeViewController()
     //        newViewController.onRecipeCreated = { [weak self] newRecipe in
        newViewController.onRecipeCreated = { [weak self] (newRecipe: Recipe, imageData: Data) in
            guard let self = self else { return }
            self.favoriteRecipes.append(newRecipe)
            self.saveFavoriteRecipesToUserDefaults()
            // Convert imageData to UIImage
            guard let image = UIImage(data: imageData) else {
                print("Failed to convert imageData to UIImage")
                return
            }

            // Call the method with the converted UIImage
            newViewController.saveImageDataToDocumentsDirectory(image: image)
            self.tableView.reloadData()
            self.noFavoritesView.isHidden = true
                   
              }
               present(newViewController, animated: true, completion: nil)
        
     
    } */
    
    @objc private func uploadButtonTapped() {
        print("Upload button tapped")
        let newViewController = NewRecipeViewController()
        newViewController.onRecipeCreated = { [weak self] newRecipe, imageData in
            guard let self = self else { return }
            self.favoriteRecipes.append(newRecipe)
            self.saveFavoriteRecipesToUserDefaults()
            
            // Save the image data
            self.saveImageData(imageData)
            
            self.tableView.reloadData()
            self.noFavoritesView.isHidden = true
        }
        present(newViewController, animated: true, completion: nil)
    }

    private func saveImageData(_ imageData: Data) {
        // Get the documents directory URL
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Could not access the documents directory")
            return
        }

        // Generate a unique file name for the image
        let imageFileName = UUID().uuidString + ".jpeg"
        let imageURL = documentsDirectory.appendingPathComponent(imageFileName)

        // Write the image data to the file
        do {
            try imageData.write(to: imageURL)
            print("Image saved to documents directory: \(imageURL)")
        } catch {
            print("Error saving image to documents directory: \(error)")
        }
    }

    private func setupTableView() {
        tableView.register(FavoriteRecipeTableViewCell.self, forCellReuseIdentifier: "FavoriteRecipeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        // refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh(_ sender: Any) {
        //refresh
        loadFavoriteRecipes()
    }
    
    let recipeCollectionVC = RecipeCollectionViewCell()
    public var favoritesKey: String { return recipeCollectionVC.favoritesKey }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteRecipes() // Reload data when the view appears
    }
   @objc public func loadFavoriteRecipes() {
        guard let favoriteRecipesData = UserDefaults.standard.array(forKey: favoritesKey) as? [Data] else {
            print("No favorite recipes found in UserDefaults")
            return
        }
      
        
        favoriteRecipes = favoriteRecipesData.compactMap { data in
            do {
                return try JSONDecoder().decode(Recipe.self, from: data)
            } catch {
                print("Error decoding recipe: \(error.localizedDescription)")
                return nil
            }
        }
        
        if favoriteRecipes.isEmpty {
                   displayNoFavoritesView()
               } else {
                   noFavoritesView.isHidden = true
               }
        
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing() // end refreshing
        
   
           
    }
    

    private func displayNoFavoritesView() {
         noFavoritesView.isHidden = false
     }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeTableViewCell", for: indexPath) as! FavoriteRecipeTableViewCell
        let recipe = favoriteRecipes[indexPath.row]
        
        // Debugging log to print out the recipe being displayed
          print("Displaying recipe: \(recipe)")
        cell.configure(with: recipe)
        cell.delegate = self
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return the height for each row (cell)
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //return the height for the section header
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Creating a custom view for the section header..
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        headerView.backgroundColor = .clear // Set the background color as needed to match your UI
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Return the height for the section footer
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // creating a custom view for the section footer to add space between cells
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            // deletion
            self?.favoriteRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self?.saveFavoriteRecipesToUserDefaults()
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "swipe_delete.png") //icon
        deleteAction.backgroundColor = .black
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    private func saveFavoriteRecipesToUserDefaults() {
        let favoriteRecipesData = favoriteRecipes.compactMap { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(favoriteRecipesData, forKey: favoritesKey)
        
        // post notification when favorites are updated...
        NotificationCenter.default.post(name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
    }
    
  
    
    
    func didTapReadMore(for recipe: Recipe) {
    
        
        coordinator?.showRecipeDetails(for: recipe, controller: self)
        
    }
    
    
}
