//
//  FoodDetailViewController.swift
//  Foody
//
//  Created by Kinga Szabo on 18/02/2024.
//

import UIKit

class FoodDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var foodItem: FoodItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = foodItem.title
        detailLabel.text = foodItem.details
        imageView.image = UIImage(named: foodItem.imageName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
