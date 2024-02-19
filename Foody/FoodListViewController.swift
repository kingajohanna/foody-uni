//
//  FoodListViewController.swift
//  Foody
//
//  Created by Kinga Szabo on 18/02/2024.
//

import UIKit

private let reuseIdentifier = "FoodListCell"

class FoodListViewController: UICollectionViewController {
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FoodManager.shared.foods.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodListCell
        let foodItem = FoodManager.shared.foods[indexPath.row]
        
        cell.titleLabel.text = foodItem.title
        cell.imageView.image = UIImage(named: foodItem.imageName)
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "FoodDetailSegue",
            let detailVC = segue.destination as? FoodDetailViewController,
            let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView?.indexPath(for: cell) else {
                return
        }
        
        detailVC.foodItem = FoodManager.shared.foods[indexPath.row]
    }
}

extension FoodListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: max(view.safeAreaInsets.left, 8), bottom: 0, right: max(view.safeAreaInsets.right, 8))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 24) / 2
        return CGSize(width: size, height: size)
    }
}
