import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD

class RecipeCollectionViewCell: UICollectionViewCell {
    
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
        secondLabel.font = UIFont(name: "Poppins-SemiBold", size: 10) // Adjust font size and weight as needed
        secondLabel.textColor = .black // Changing the color as needed for highlighting
        contentView.addSubview(secondLabel)
        
        // set up constraints
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            recipeImageView.heightAnchor.constraint(equalToConstant: 125), // Setting a fixed height for the image
            
            favoritesButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8), // Adjusting top spacing as needed
            favoritesButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -8), // Adjust right spacing as needed
            favoritesButton.widthAnchor.constraint(equalToConstant: 30), // Setting width of the button
            favoritesButton.heightAnchor.constraint(equalToConstant: 30), // Setting height of the button
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            secondLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 2),
            secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func favoritesButtonTapped() {
        isFavorite.toggle()
        
        if isFavorite {
            // Setting tint color to red to represent favorited state
            favoritesButton.tintColor = .red
        } else {
            // Reset tint color to default to represent unfavorited state
            favoritesButton.tintColor = .black
        }
    }


    
    func configure(with recipe: Recipe) {
        // fetching the image asynchronously
        if let url = URL(string: recipe.imageURL) {
            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    self.recipeImageView.image = image
                }
            }
        }
        recipeNameLabel.text = recipe.label
        secondLabel.text = String(recipe.totalTime) + " min" // Provide text for the second label
        
        // Reset favorite state when configuring cell
        isFavorite = false
        favoritesButton.tintColor = .red // Setting initial tint color
    }
}
