import UIKit
import Alamofire
import MBProgressHUD

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var viewModel = RecipeViewModel()
    let headingImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
            // Set any other properties you need for your image view
            imageView.contentMode = .scaleAspectFill // Adjust the content mode as per your requirement
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headingImageView)
            
            // Setup constraints for the image view
        NSLayoutConstraint.activate([
                headingImageView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -18), // Adjust to below status bar
                headingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                headingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                headingImageView.heightAnchor.constraint(equalToConstant: 10) // Adjust the height as per your requirement
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
        

        viewModel.fetchRecipes(query: "Meal") { [weak self] error in
            if let error = error {
                print("Failed to fetch recipes: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        return cell
    }
}




