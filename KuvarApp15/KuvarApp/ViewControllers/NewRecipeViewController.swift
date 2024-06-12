import UIKit
import Photos

class NewRecipeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var onRecipeCreated: ((Recipe) -> Void)?
    
    var addNewRecipeView: NewRecipeView!
    
    var selectedImageData: Data?
    
    @IBOutlet weak var btnVis: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and configure the view
        addNewRecipeView = NewRecipeView()
        view.addSubview(addNewRecipeView)
        view.addSubview(btnVis)
        view.addSubview(createButton)
        
        btnVis.layer.borderWidth = 1
        btnVis.layer.borderColor = UIColor.red.cgColor
        btnVis.layer.cornerRadius = 5
        
        createButton.layer.shadowColor = UIColor.black.cgColor
        createButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        createButton.layer.shadowOpacity = 1
        createButton.layer.shadowRadius = 4
        createButton.layer.cornerRadius = 5
        
        addNewRecipeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewRecipeView.topAnchor.constraint(equalTo: view.topAnchor),
            addNewRecipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addNewRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addNewRecipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        checkPhotoLibraryPermission()
        
        // Clear previous image
        addNewRecipeView.imageView.image = UIImage(named: "input_field")
        selectedImageData = nil
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let title = addNewRecipeView.recipeNameTextField.text, !title.isEmpty,
              let preparingTimeText = addNewRecipeView.preparingTimeTextField.text, !preparingTimeText.isEmpty,
              let preparingTime = Int(preparingTimeText),
              let ingredients = addNewRecipeView.ingredientsTextView.text, !ingredients.isEmpty,
              let imageData = selectedImageData else {
            let alert = UIAlertController(title: "Error", message: "Please enter the title, preparing time, ingredients, and select an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let ingredientsArray = ingredients.components(separatedBy: "\n")
        
        let newRecipe = Recipe(
            createdFromNewRecipeViewController: true,
            imageData: imageData,
            label: title,
            totalTime: preparingTime,
            ingredientLines: ingredientsArray,
            calories: 0.0,
            totalCO2Emissions: 0.0,
            cuisineType: [],
            mealType: [],
            dishType: [],
            dietLabels: []
        )
        
        // Save the recipe
        saveRecipeToUserDefaults(recipe: newRecipe)
        
        // Call the onRecipeCreated closure with the new recipe
        onRecipeCreated?(newRecipe)
        
        dismiss(animated: true, completion: nil)
    }
    
    private func saveRecipeToUserDefaults(recipe: Recipe) {
        let createdKey = "createdRecipes"
        var createdRecipes = UserDefaults.standard.array(forKey: createdKey) as? [Data] ?? []
        
        do {
            let recipeData = try JSONEncoder().encode(recipe)
            createdRecipes.append(recipeData)
            UserDefaults.standard.set(createdRecipes, forKey: createdKey)
            
            NotificationCenter.default.post(name: Notification.Name("RecipesUpdated"), object: nil)
        } catch {
            print("Error encoding recipe: \(error)")
        }
    }
    
    func saveImageDataToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: Failed to convert image to data")
            return
        }
        selectedImageData = imageData
       
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Photo library access authorized")
        case .denied, .restricted:
            print("Photo library access denied or restricted")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    print("Photo library access granted")
                }
            }
        @unknown default:
            break
        }
    }
    
    @IBAction func btnVisualize(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openPhotoLibrary()
        }
        alertController.addAction(photoLibraryAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        alertController.addAction(cameraAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            addNewRecipeView.imageView.image = editedImage
            saveImageDataToDocumentsDirectory(image: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            addNewRecipeView.imageView.image = originalImage
            saveImageDataToDocumentsDirectory(image: originalImage)
        }
        picker.dismiss(animated: true)
    }
}
