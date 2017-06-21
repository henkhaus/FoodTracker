//
//  MealViewController.swift
//  FoodTracker
//
//  Created by roberth on 5/14/17.
//  Copyright © 2017 roberth. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // this value is either passed by MealTableViewController in prepare(for:sender:) or constructed when adding a new meal 
    var meal: Meal?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        // view controller will set itself as the delegate to nameTextField
        nameTextField.delegate = self
        
        // set up views if editing an existing meal
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // enable save button only if text field is not empty
        updateSaveButtonState()
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable save while editing
        saveButton.isEnabled = false
    }
    
    //reassigns first responder to view controller after user hits 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // called right after textFieldShouldReturn - a chance to capture the user input
        //mealNameLabel.text = textField.text
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss picker if canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // info dict may contain multiple reps of the image, we want the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected dict containing image but was provided the following: \(info)")
            }
        //set photoImageView to display image
        photoImageView.image = selectedImage
        // dismiss picker
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // depending on style presentation (modal or push), this view controller needs to be dismissed in two ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealViewController is not inside a navigation contoller.")
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // config the destination view sontroller only when the saveButton is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log:OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        
        // set mean to be passed to MealTableViewController after unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // ensures hide keyboard
        nameTextField.resignFirstResponder()
        //a view controller that lets user pick media froom photo library
        let imagePickerController = UIImagePickerController()
        // only pick pics not take pics
        imagePickerController.sourceType = .photoLibrary
        // make sure view controller is notified when pic is chosen
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    // MARK: Private Methods
    
    private func updateSaveButtonState(){
        // disable save button if field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }
    
    
        
}
















