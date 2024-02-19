//
//  FoodItem.swift
//  Foody
//
//  Created by Kinga Szabo on 18/02/2024.
//

import UIKit

struct FoodItem: Codable {
    
    let title: String
    let imageName: String?
    let details: String
    let imageData: Data?
    
    var image: UIImage? {
        if let data = imageData {
            return UIImage(data: data)!
        }
        if let name = imageName {
            return UIImage(named: name)
        }
        return nil
    }
}
