//
// ExploreRecipesViewController.swift
// KuvarApp
//
// Created by Ana Asceric on 20.5.24..
//

import UIKit
import Alamofire
import AlamofireImage


class ExploreRecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExploreCellDelegate {
    weak var coordinator: MainCoordinator?

    func didTapReadMore(for recipe: Recipe) {
     //   let recipeDetailsVC = RecipeDetailsViewController()
   //     recipeDetailsVC.recipe = recipe
    
        // Presenting the RecipeDetailsViewController modally
        //   present(recipeDetailsVC, animated: true, completion: nil)
        coordinator?.showRecipeDetails(for: recipe, controller: self)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var recipes: [Recipe] = []
    var isFavorite: Bool = false
    var viewModel = RecipeViewModel()
    
    
    
    let headingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let additionalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("numberOfPages in viewDidLoad:", pageControl.numberOfPages)
        
        view.addSubview(headingImageView)
        view.addSubview(additionalImageView)
        view.addSubview(pageControl)
        
        
      
        // Setup constraints for the image view
        NSLayoutConstraint.activate([
            headingImageView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -18), // Adjusting to below status bar
            headingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            headingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            headingImageView.heightAnchor.constraint(equalToConstant: 10)
        ])
        NSLayoutConstraint.activate([
            additionalImageView.topAnchor.constraint(equalTo: headingImageView.bottomAnchor, constant: 25), // Position below the heading image view
            additionalImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            additionalImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            additionalImageView.heightAnchor.constraint(equalToConstant: 20) // Adjust height as needed
        ])
        headingImageView.image = UIImage(named: "pageHeading")
        additionalImageView.image = UIImage(named: "Header")
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
      
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true // Enable paging
        // Set up the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
 
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray // Change to desired color
        //     collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        let cellNib = UINib(nibName: "RecipeCarouselItemCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "RecipeCarouselItemCell")
        // Fetch explore recipes
        fetchExploreRecipes()
       
    }
    
   
    func fetchExploreRecipes() {
        let viewModel = RecipeViewModel()
        viewModel.fetchExploreRecipes { [weak self] error in
            if let error = error {
                print("Error fetching explore recipes: \(error.localizedDescription)")
            } else {
                self?.recipes = viewModel.recipes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.pageControl.numberOfPages = 10
                    print("numberOfPages after fetching recipes:", self?.pageControl.numberOfPages)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        print("numberOfPages in viewDidAppear:", pageControl.numberOfPages)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCarouselItemCell", for: indexPath) as! RecipeCarouselItemCell
        let recipe = recipes[indexPath.item]
        cell.configure(with: recipe)
        cell.delegate = self
        
   
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return collectionView.bounds.size
        let width = collectionView.bounds.width - 10 // Subtracting 20 for left and right margin
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    
    
    
}
//}
// MARK: - UIScrollViewDelegate
extension ExploreRecipesViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
       
       pageControl.currentPage = min(max(0, Int(pageIndex)), 9) // Ensure currentPage doesn't exceed 10
  }
}

// MARK: - Actions
extension ExploreRecipesViewController {
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {

        // Log collectionView bounds width
            print("CollectionView Width:", collectionView.bounds.width)
            
            // Log sender currentPage value
            print("Current Page:", sender.currentPage)
            
            // Calculate the target offset X based on the currentPage
            let targetOffsetX = CGFloat(sender.currentPage) * collectionView.bounds.width
            
            // Log the target offset X
            print("Target Offset X:", targetOffsetX)
            
            // Scroll the collection view to the target content offset without animation
            collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
}




