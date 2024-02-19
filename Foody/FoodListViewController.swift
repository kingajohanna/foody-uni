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
    @IBAction func addFoodViewControllerDidSave(unwindSegue: UIStoryboardSegue) {
        guard let addFoodVC = unwindSegue.source as? AddFoodViewController,
                let image = addFoodVC.imageView.image,
                let imageData = image.jpegData(compressionQuality: 1),
                let title = addFoodVC.titleTextField.text,
                let details = addFoodVC.descriptionTextView.text else { return }
            
            let foodItem = FoodItem(title: title, imageName: nil, details: details, imageData: imageData)
            FoodManager.shared.foods.insert(foodItem, at: 0)
    }

    @IBAction func addFoodViewControllerDidCancel(unwindSegue: UIStoryboardSegue) {}

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FoodManager.shared.foods.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodListCell
        let foodItem = FoodManager.shared.foods[indexPath.row]

        cell.titleLabel.text = foodItem.title
        cell.imageView.image = foodItem.image

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView?.refreshControl = UIRefreshControl()
        collectionView?.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }

    @objc func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.collectionView?.reloadData()
            self.collectionView?.refreshControl?.endRefreshing()
        }
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
