//
//  Meal.swift
//  FoodTracker
//
//  Created by roberth on 5/14/17.
//  Copyright © 2017 roberth. All rights reserved.
//

import UIKit


class Meal {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // check for invalid properties
        // empty name
        guard !name.isEmpty else {
            return nil
        }
        // only ratings 0-5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        
        // initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
    
}
