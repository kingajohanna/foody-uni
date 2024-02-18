//
//  LoginViewController.swift
//  Foody
//
//  Created by Kinga Szabo on 18/02/2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func editingDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if
            let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                if passwordTextField.frame.maxY > view.frame.height - keyboardSize.height {
                    UIView.animate(withDuration: duration, animations: {
                        self.imageViewTopConstraint.constant -= keyboardSize.height
                        self.view.layoutIfNeeded()
                    })
                }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        if
            let userInfo = notification.userInfo,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                UIView.animate(withDuration: duration) {
                    self.imageViewTopConstraint.constant = UIDevice.current.orientation == .portrait ? 160 : 40
                    self.view.layoutIfNeeded()
                }
        }
    }

}

