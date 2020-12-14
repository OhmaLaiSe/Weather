//
//  UIViewControllerExtension.swift
//  Weather
//
//  Created by Liam on 10/7/19.
//  Copyright © 2019 Liam. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(error: String) {
        // showAlert() presents an Error alert to the user when there is a problem retrieveing data from Dark Sky API
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

