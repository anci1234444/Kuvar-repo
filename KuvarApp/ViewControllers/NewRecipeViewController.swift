import UIKit
import Photos
import Alamofire
import AlamofireImage

class NewRecipeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //var selectedImage: UIImage?
    var onRecipeCreated: ((Recipe,Data) -> Void)?
    
    var addNewRecipeView: NewRecipeView!
    
    var selectedImage:URL?
    
    @IBOutlet weak var btnVis: UIButton!
    
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and configure the view
        addNewRecipeView = NewRecipeView()
        // addNewRecipeView.delegate = self
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
        // Add constraints
        addNewRecipeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewRecipeView.topAnchor.constraint(equalTo: view.topAnchor),
            addNewRecipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addNewRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addNewRecipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        checkPhotoLibraryPermission()
        
        //  if let selectedImageURLString = UserDefaults.standard.string(forKey: "SelectedImageURL"),
        
        //       let imageURL = URL(string: selectedImageURLString) {
        //      print("Image URL to load: \(imageURL)")
        //  selectedImage = imageURL
        // Load the image from the URL and display it
        //    if let imageData = try? Data(contentsOf: imageURL),
        //     let image = UIImage(data: imageData) {
        //      addNewRecipeView.imageView.image = image
        //  selectedImage = image
        //     }
        if let selectedImageURLString = UserDefaults.standard.string(forKey: "SelectedImageURL") {
            let imageURL = URL(string: selectedImageURLString)
            print("Image URL to load: \(imageURL)")
            if let imageURL = imageURL, let imageData = try? Data(contentsOf: imageURL),
               let image = UIImage(data: imageData) {
                addNewRecipeView.imageView.image = image
            }
            
        }
        //Old image is not displayed again when trying to create new recipe
        addNewRecipeView.imageView.image = UIImage(named: "input_field")
        selectedImage = nil
        UserDefaults.standard.removeObject(forKey: "SelectedImageURL")
    }
    
    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        /*   guard let title = addNewRecipeView.recipeNameTextField.text, !title.isEmpty,
         let preparingTimeText = addNewRecipeView.preparingTimeTextField.text, !preparingTimeText.isEmpty,
         let preparingTime = Int(preparingTimeText),
         let ingredients = addNewRecipeView.ingredientsTextView.text, !ingredients.isEmpty,
         let imageURL = selectedImage else {
         // let image = selectedImage else {
         let alert = UIAlertController(title: "Error", message: "Please enter the title, preparing time, and ingredients", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
         return
         }
         
         let ingredientsArray = ingredients.components(separatedBy: "\n")
         
         var newRecipe = Recipe(
         createdFromNewRecipeViewController: true, imageURL: imageURL.absoluteString, // Use the selected image URL directly
         label: title,
         totalTime: preparingTime,
         ingredientLines: ingredientsArray,
         calories: 0.0,
         totalCO2Emissions: 0.0,
         cuisineType: [],
         mealType: [],
         dishType: [],
         dietLabels: [] // Set this property to true
         )
         // Call saveRecipeToFavorites
         if let imageData = try? Data(contentsOf: imageURL) {
         saveRecipeToFavorites(newRecipe, imageData: imageData)
         } else {
         print("Failed to load image data")
         }
         onRecipeCreated?(newRecipe)
         dismiss(animated: true, completion: nil)
         */
        
        
        
        // Check if all required fields are filled
    /*    guard let title = addNewRecipeView.recipeNameTextField.text, !title.isEmpty,
              let preparingTimeText = addNewRecipeView.preparingTimeTextField.text, !preparingTimeText.isEmpty,
              let preparingTime = Int(preparingTimeText),
              let ingredients = addNewRecipeView.ingredientsTextView.text, !ingredients.isEmpty,
              let imageURL = selectedImage else {
            let alert = UIAlertController(title: "Error", message: "Please enter the title, preparing time, and ingredients", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        do {
            // Load image data from the file URL
            let imageData = try Data(contentsOf: imageURL)
            
            // Split ingredients into an array
            let ingredientsArray = ingredients.components(separatedBy: "\n")
            
            // Create a new recipe with the provided data
            var newRecipe = Recipe(
                createdFromNewRecipeViewController: true,
                imageURL: imageURL.absoluteString, // Use the absolute string of the URL
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
            
            // Save the recipe and image data to UserDefaults
            saveRecipeToFavorites(recipe: newRecipe, imageData: imageData)
            
            // Call the onRecipeCreated closure with the new recipe and image data
            onRecipeCreated?(newRecipe, imageData)
            
            // Dismiss the view controller
            dismiss(animated: true, completion: nil)
        } catch {
            // Handle errors related to loading image data
            print("Error loading image data: \(error)")
            let alert = UIAlertController(title: "Error", message: "Failed to load image data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } */
        
        guard let title = addNewRecipeView.recipeNameTextField.text, !title.isEmpty,
                  let preparingTimeText = addNewRecipeView.preparingTimeTextField.text, !preparingTimeText.isEmpty,
                  let preparingTime = Int(preparingTimeText),
                  let ingredients = addNewRecipeView.ingredientsTextView.text, !ingredients.isEmpty,
                  let imageURL = selectedImage else {
                let alert = UIAlertController(title: "Error", message: "Please enter the title, preparing time, and ingredients", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            do {
                // Load image data from the file URL
                let imageData = try Data(contentsOf: imageURL)
                
                // Split ingredients into an array
                let ingredientsArray = ingredients.components(separatedBy: "\n")
                
                // Create a new recipe with the provided data
                var newRecipe = Recipe(
                    createdFromNewRecipeViewController: true,
                    imageURL: imageURL.absoluteString, // Use the absolute string of the URL
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
                
                // Save the recipe and image data to UserDefaults
                saveRecipeToFavorites(recipe: newRecipe, imageData: imageData)
                
                // Call the onRecipeCreated closure with the new recipe and image data
                onRecipeCreated?(newRecipe, imageData)
                
               
                dismiss(animated: true, completion: nil)
            } catch {
                // Handle errors related to loading image data
                print("Error loading image data: \(error)")
                let alert = UIAlertController(title: "Error", message: "Failed to load image data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    
    
    
    
    
    
    private func saveRecipeToFavorites(recipe: Recipe, imageData:Data) {
        let favoritesKey = "favoriteRecipes"
        var favoriteRecipes = UserDefaults.standard.array(forKey: favoritesKey) as? [Data] ?? []
        
        // Get the documents directory URL
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Could not access the documents directory")
            return
        }
        
        // Create a directory path within the documents directory
        let directoryURL = documentsDirectory.appendingPathComponent("RecipeImages")
        
        // Check if the directory exists, create it if not
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            do {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                print("Directory created at: \(directoryURL.path)")
            } catch {
                print("Error creating directory: \(error)")
                return
            }
        }
        
        // Generate a unique file name for the image
        let imageFileName = UUID().uuidString + ".jpeg"
        let imageFileURL = directoryURL.appendingPathComponent(imageFileName)
        
        do {
            // Write the image data to the file
            try imageData.write(to: imageFileURL)
            print("Image saved successfully at path: \(imageFileURL.path)")
            
            // Update recipe with image path
            var updatedRecipe = recipe
            updatedRecipe.imageURL = imageFileURL.absoluteString
            
            // Encode the recipe data
            let recipeData = try JSONEncoder().encode(updatedRecipe)
            
            // Save the recipe data to UserDefaults
            favoriteRecipes.append(recipeData)
            UserDefaults.standard.set(favoriteRecipes, forKey: favoritesKey)
            
            // Notify observers
            NotificationCenter.default.post(name: Notification.Name("FavoriteRecipesUpdated"), object: nil)
        } catch {
            print("Error saving image: \(error)")
        }
    }
    
 /*   public func saveImageDataToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: Failed to convert image to data")
            return
        }
        
        // Get the documents directory URL
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Could not access the documents directory")
            return
        }
        
        // Specify the file URL for the image
        let imageURL = documentsDirectory.appendingPathComponent("selectedImage.jpeg")
        
        // Write the image data to the file
        do {
            try imageData.write(to: imageURL)
            print("Image saved to documents directory: \(imageURL)")
            selectedImage = imageURL
        } catch {
            print("Error saving image to documents directory: \(error)")
        }
    } */
    public func saveImageDataToDocumentsDirectory(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: Failed to convert image to data")
            return
        }

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
            selectedImage = imageURL
            // Store the image data in UserDefaults
            UserDefaults.standard.set(imageData, forKey: "selectedImageData")
        } catch {
            print("Error saving image to documents directory: \(error)")
        }
    }

    
    
    
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Photo library access authorized")
        case .denied, .restricted:
            print("Photo library access denied or restricted")
        case .notDetermined:
            print("Photo library access not determined. Requesting permission...")
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("Photo library access granted")
                case .denied, .restricted:
                    print("Photo library access denied or restricted")
                case .notDetermined:
                    print("Photo library access still not determined")
                @unknown default:
                    break
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
        print("Image selection completed")
        // if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
        // Displaying the selected image in the image view
        //       addNewRecipeView.imageView.image = editedImage
        // Set selectedImage to the URL of the edited image
        //       saveImageDataToDocumentsDirectory(image: editedImage)
        //      if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
        //          selectedImage = imageURL
        //   UserDefaults.standard.set(imageURL.absoluteString, forKey: "SelectedImageURL")
        //      }
        //    } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        //       addNewRecipeView.imageView.image = originalImage
        // Set selectedImage to the URL of the original image
        //      saveImageDataToDocumentsDirectory(image: originalImage)
        //      if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
        //         selectedImage = imageURL
        //  UserDefaults.standard.set(imageURL.absoluteString, forKey: "SelectedImageURL")
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Displaying the selected image in the image view
            addNewRecipeView.imageView.image = editedImage
            // Convert image to Data
            saveImageDataToDocumentsDirectory(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addNewRecipeView.imageView.image = originalImage
            // Convert image to Data
            saveImageDataToDocumentsDirectory(image: originalImage)
        }
        
        
        
        picker.dismiss(animated: true)
    }
    
    
}
