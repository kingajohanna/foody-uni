//
//  FoodManager.swift
//  Foody
//
//  Created by Kinga Szabo on 18/02/2024.
//

import Foundation

final class FoodManager {
    
    static let shared = FoodManager()
    var foods = [FoodItem]()
    
    private init() {
        let filePath = Bundle.main.path(forResource: "foodlist", ofType: "json")
        let jsonData = NSData(contentsOfFile: filePath!)!
        
        do {
            foods = try JSONDecoder().decode([FoodItem].self, from: jsonData as Data)
        } catch {
            foods = [FoodItem]()
        }
    }
}
