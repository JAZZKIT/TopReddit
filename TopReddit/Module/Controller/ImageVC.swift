//
//  ImageVC.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import UIKit

//class ImageVC: UIViewController {
//
//    @IBOutlet weak var bigImageView: UIImageView!
//}

class ImageVC: UIViewController {
    
    var bigImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        style()
        layout()
    }
    
    
    private func configureController() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
    }
}

extension ImageVC {
    private func style() {
        bigImageView.translatesAutoresizingMaskIntoConstraints = false
        bigImageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        view.addSubview(bigImageView)
        
        NSLayoutConstraint.activate([
            bigImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bigImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

// MARK: - Actions
extension ImageVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


