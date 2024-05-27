
//
// ExploreRecipesView.swift
// KuvarApp
//
// Created by Ana Asceric on 20.5.24..
//
import UIKit
import Alamofire
import AlamofireImage
class ExploreRecipesView: UIView {
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    // var additionalImage: UIImage?
    var viewModel = RecipeViewModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        if let view = Bundle.main.loadNibNamed("ExploreRecipesView", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
        exploreCollectionView.register(RecipeCarouselItemCell.self, forCellWithReuseIdentifier: "RecipeCarouselItemCell")
        // Fetch recipes
        viewModel.fetchExploreRecipes { [weak self] error in
            if let error = error {
                print("Failed to fetch recipes: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.exploreCollectionView.reloadData()
                }
            }
        }
        // Set delegate and dataSource
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
    }
}
extension ExploreRecipesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCarouselItemCell", for: indexPath) as! RecipeCarouselItemCell
        let recipe = viewModel.recipes[indexPath.item]
        cell.configure(with: recipe)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // ..
    }
}
