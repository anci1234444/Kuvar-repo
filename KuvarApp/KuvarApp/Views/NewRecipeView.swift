//
//  NewRecipeView.swift
//  KuvarApp
//
//  Created by Ana Asceric on 4.6.24..
//

import UIKit


class NewRecipeView: UIView {
    
    weak var viewController: NewRecipeViewController?
  
    // MARK: - UI Components
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "New Recipe"
        label.font = UIFont(name: "Poppins-SemiBold", size: 22)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You can create here new favorite recipe"
        label.textColor = .black
        return label
    }()
    let imageView: UIImageView = {
       let imageView = UIImageView()
       // Set default image
        imageView.image = UIImage(named: "input_field")
        imageView.contentMode = .scaleAspectFit
       return imageView
     }()
     let uploadLabel: UILabel = {
       let label = UILabel()
       label.text = "Make sure your recipe has some matching visuals. Upload or take a photo from your iPhone. Max 1MB size, square aspect ratio."
       label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 10)
       label.textColor = .black
       return label
     }()

     let recipeNameLabel: UILabel = {
       let label = UILabel()
       label.text = "Recipe Name"
       label.font = UIFont.boldSystemFont(ofSize: 12)
       return label
     }()
     let recipeNameTextField: UITextField = {
       let textField = UITextField()
       textField.placeholder = "Veggie Burger maybe?"
       textField.borderStyle = .roundedRect
       return textField
     }()
     let preparingTimeLabel: UILabel = {
       let label = UILabel()
       label.text = "Preparing Time"
       label.font = UIFont.boldSystemFont(ofSize: 12)
       return label
     }()
     let preparingTimeTextField: UITextField = {
       let textField = UITextField()
       textField.placeholder = "30? 40 mins?"
       textField.borderStyle = .roundedRect
       return textField
     }()
    
    private lazy var preparingTimeFormatLabel: UIButton = {
           let buttonFormatTime = UIButton(type: .system)
           buttonFormatTime.setTitle("hh:mm", for: .normal)
           buttonFormatTime.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
       
           return buttonFormatTime
       }()
                
  
     let ingredientsLabel: UILabel = {
       let label = UILabel()
       label.text = "Ingredients"
       label.font = UIFont.boldSystemFont(ofSize: 12)
       return label
     }()
     let ingredientsTextView: UITextView = {
       let textView = UITextView()
    //   textView.placeholder = "Don't forget something here, otherwise taste will be suck!"
       textView.textColor = .black
       textView.layer.borderWidth = 1.0
       textView.layer.cornerRadius = 5.0
       textView.layer.borderColor = UIColor.lightGray.cgColor
       return textView
     }()
    

    

    @objc private func preparingTimeLabelTapped() {
        // Create a date picker
             let timePicker = UIDatePicker()
             timePicker.datePickerMode = .countDownTimer
        timePicker.minuteInterval = 5
        timePicker.countDownDuration = 4500
   //     timePicker.preferredDatePickerStyle = .inline
             
             // Create an alert controller
        let alertController = UIAlertController(title: "Select Time", message: "\n\n\n\n\n\n\n\n\n\n",  preferredStyle: .alert)
             
             // Add the date picker to the alert controller
             alertController.view.addSubview(timePicker)
             
             // Add constraints to position the time picker
             timePicker.translatesAutoresizingMaskIntoConstraints = false
             timePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
             timePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 20).isActive = true
             
             // Add action buttons
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             alertController.addAction(cancelAction)
             
             let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "HH:mm"
                 let selectedTime = dateFormatter.string(from: timePicker.date)
                 self.preparingTimeTextField.text = selectedTime
             }
             alertController.addAction(okAction)
             
             // Present the alert controller
             if let topViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController ?? UIApplication.shared.windows.first?.rootViewController {
                 topViewController.present(alertController, animated: true, completion: nil)
             }
         }
    @objc private func createButtonTapped() {
          viewController?.perform(#selector(viewController?.createButtonTapped))
      }
       
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = .systemGray6 // Settign background color to gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
        backgroundColor = .systemGray6 // Setting background color to gray
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // Add subviews
        addSubview(headingLabel)
        addSubview(descriptionLabel)
        addSubview(imageView)
        addSubview(uploadLabel)
     //   addSubview(visualizeButton)
        addSubview(recipeNameLabel)
        addSubview(recipeNameTextField)
        addSubview(preparingTimeLabel)
        addSubview(preparingTimeTextField)
        addSubview(preparingTimeFormatLabel)
        addSubview(ingredientsLabel)
        addSubview(ingredientsTextView)
       // addSubview(createButton)
        
      
 
        preparingTimeFormatLabel.addTarget(self, action: #selector(preparingTimeLabelTapped), for: .touchUpInside)
        
     //   createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        // Add layout constraints
            headingLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            uploadLabel.translatesAutoresizingMaskIntoConstraints = false
       //     visualizeButton.translatesAutoresizingMaskIntoConstraints = false
            recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
            recipeNameTextField.translatesAutoresizingMaskIntoConstraints = false
            preparingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            preparingTimeTextField.translatesAutoresizingMaskIntoConstraints = false
            preparingTimeFormatLabel.translatesAutoresizingMaskIntoConstraints = false
            ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
            ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        //    createButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // Heading Label
                headingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
                headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                // Description Label
                descriptionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                // Image View
                       imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
                       imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                       imageView.widthAnchor.constraint(equalToConstant: 150),
                       imageView.heightAnchor.constraint(equalToConstant: 130),
                       
                       // Upload Label
                       uploadLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
                       uploadLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                       uploadLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                       
            
        
                       
                // Recipe Name Label
     //           recipeNameLabel.topAnchor.constraint(equalTo: visualizeButton.bottomAnchor, constant: 20),
                recipeNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                // Recipe Name Text Field
                recipeNameTextField.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 8),
                recipeNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                recipeNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                // Preparing Time Label
                preparingTimeLabel.topAnchor.constraint(equalTo: recipeNameTextField.bottomAnchor, constant: 20),
                preparingTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                // Preparing Time Text Field
                preparingTimeTextField.topAnchor.constraint(equalTo: preparingTimeLabel.bottomAnchor, constant: 8),
                preparingTimeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                preparingTimeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                // Preparing Time Format Label
                   preparingTimeFormatLabel.centerYAnchor.constraint(equalTo: preparingTimeTextField.centerYAnchor),
                   preparingTimeFormatLabel.trailingAnchor.constraint(equalTo: preparingTimeTextField.trailingAnchor, constant: -5),
                
                // Ingredients Label
                ingredientsLabel.topAnchor.constraint(equalTo: preparingTimeTextField.bottomAnchor, constant: 20),
                ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                // Ingredients Text View
                ingredientsTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
                ingredientsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                ingredientsTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                ingredientsTextView.heightAnchor.constraint(equalToConstant: 100)
        
            ])
    }
  
}

