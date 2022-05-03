//
//  UIViewController.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentErrorToUser(message: String) {
        
        let alertController = UIAlertController(title: "Something went wrong!", message: message, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}


