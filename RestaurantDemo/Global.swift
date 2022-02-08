//
//  Global.swift
//  RestaurantDemo
//
//  Created by PIG on 2022/2/2.
//

import Foundation
import UIKit


class Global {
    static func showAlert(title: String, error: Error, viewController: UIViewController) {
        guard let _ = viewController.viewIfLoaded?.window else { return }
        let alertController = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "I Kown", style: .cancel, handler: nil));
        viewController.present(alertController, animated: true, completion: nil);
    }
}
