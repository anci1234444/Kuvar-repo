import UIKit
import Alamofire
import MBProgressHUD

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = RecipeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "RecipesTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RecipesCell")
        
        viewModel.fetchRecipes(query: "Meal") { [weak self] error in
            if let error = error {
                print("Failed to fetch recipes: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        
        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
}



