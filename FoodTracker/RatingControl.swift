//
//  RatingControl.swift
//  FoodTracker
//
//  Created by roberth on 5/14/17.
//  Copyright © 2017 roberth. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        // didSet is a property observer
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var startCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        //print("Button Pressed!")
        guard let index = ratingButtons.index(of:button) else {
            fatalError("the button,\(button), is not int the rating buttons list: \(ratingButtons)")
        }
        
        // calc the rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if selected star is currecnt rating, reset rating to 0
            rating = 0
        } else {
            // otherwise set new rating
            rating = selectedRating
        }
    }
    
    
    //MARK: Private Methods
    private func setupButtons() {
        // clear existing buttons. not perfomant but is ok
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        for index in 0..<startCount {
            //create button
            let button = UIButton()
            
            //button.backgroundColor = UIColor.red
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // adding contraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // accessibility
            button.accessibilityLabel = "Set \(index+1) star rating"
            
            //setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add button to stack
            addArrangedSubview(button)
            
            //add button to rating button list
            ratingButtons.append(button)
            
        }
        
        updateButtonSelectionStates()
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated(){
            // if index of button is less than rating, that button should be selected
            button.isSelected = index < rating
            
            // set hint string for current star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset rating to zero"
            } else {
                hintString = nil
            }
            
            // calc the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            // assign hint and value strings
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
        
    }
    
    
}























