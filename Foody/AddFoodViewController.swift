//
//  AddFoodViewController.swift
//  Foody
//
//  Created by Kinga Szabo on 19/02/2024.
//

import UIKit

class AddFoodViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        descriptionTextView.delegate = self
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: UITextField) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -100)
        }, completion: nil)
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: 100)
        }, completion: nil)
    }
    
    @objc func handleImageViewTap(_ sender: UITapGestureRecognizer) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        show(pickerController, sender: nil)
    }
}

extension AddFoodViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -210)
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: 210)
        }, completion: nil)
    }
}

extension AddFoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
    
        dismiss(animated: true, completion: nil)
    }
}
