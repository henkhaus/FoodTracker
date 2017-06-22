//
//  Meal.swift
//  FoodTracker
//
//  Created by roberth on 5/14/17.
//  Copyright © 2017 roberth. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    
    // MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder){
        // name is required. if we cant decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("unable to decode name for Meal object", log: OSLog.default, type: .debug)
            return nil
        }
        // photo is an optional property of Meal, use a conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
        
    }
}


















