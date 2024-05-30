import UIKit
import Alamofire
import MBProgressHUD

class RecipeViewController: UIViewController, RecipeCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var viewModel = RecipeViewModel()
    let headingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headingImageView)
        
        // Setup constraints for the image view
        NSLayoutConstraint.activate([
            headingImageView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -18), // Adjusting to below status bar
            headingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            headingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            headingImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
        headingImageView.image = UIImage(named: "pageHeading")
        
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 0
        let itemsPerRow: CGFloat = 2
        let width = (collectionView.bounds.width - itemSpacing * (itemsPerRow + 1)) / itemsPerRow
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        collectionView.collectionViewLayout = layout
        
        let cellNib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        
        
        viewModel.fetchExploreRecipes { error in
            if let error = error {
                print("Failed to fetch recipes: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    // Reload your collection view here
                    self.collectionView.reloadData()
                }
            }
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // adding an observer for favorite recipes updated notification.
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteRecipesUpdated), name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
    }
    
    @objc private func handleFavoriteRecipesUpdated() {
        // reloading collection view
        collectionView.reloadData()
    }
    
    deinit {
        // removing an observer when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
        let recipe = viewModel.recipes[indexPath.item]
        cell.configure(with: recipe)
        cell.delegate = self
        return cell
    }
    
    func didTapReadMore(for recipe: Recipe) {
        // Instantiating RecipeDetailsViewController
        let recipeDetailsVC = RecipeDetailsViewController()
        recipeDetailsVC.recipe = recipe
        
    
        
        navigationController?.pushViewController(recipeDetailsVC, animated: true)
        
    }
}




