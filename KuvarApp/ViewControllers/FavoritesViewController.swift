//
//  FavoritesViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 15.5.24..
//

import UIKit
import Alamofire
import MBProgressHUD

class FavoritesViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadFavoriteRecipes()
        
        view.addSubview(headingImageView)
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
        
        
        uploadButton.layer.zPosition = view.layer.zPosition + 1
    }
    @objc private func uploadButtonTapped() {
        // only print statement for now...
        print("Upload button tapped")
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
    public func loadFavoriteRecipes() {
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
        
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing() // end refreshing
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeTableViewCell", for: indexPath) as! FavoriteRecipeTableViewCell
        let recipe = favoriteRecipes[indexPath.row]
        cell.configure(with: recipe)
        
        
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
    
    
    
}
