//
//  MealViewController.swift
//  FoodTracker
//
//  Created by roberth on 5/14/17.
//  Copyright © 2017 roberth. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    // this value is either passed by MealTableViewController in prepare(for:sender:) or constructed when adding a new meal 
    var meal: Meal?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        // view controller will set itself as the delegate to nameTextField
        nameTextField.delegate = self
    }
    
    
    
    //MARK: UITextFieldDelegate
    //reassigns first responder to view controller after user hits 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // called right after textFieldShouldReturn - a chance to capture the user input
        //mealNameLabel.text = textField.text
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
        
}

