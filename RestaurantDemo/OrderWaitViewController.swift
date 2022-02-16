//
//  OrderWaitViewController.swift
//  RestaurantDemo
//
//  Created by PIG on 2022/2/16.
//

import Foundation
import UIKit

class OrderWaitViewController: UIViewController {
    var waitTime: Int = 0
    let resultLabel = UILabel();
    let confirmButton = UIButton();
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        addSubView();
        constrains();
        resultLabel.text = "Thank you for your order! Your wait time is approximately \(waitTime) minutes."
        resultLabel.numberOfLines = 0;
        confirmButton.backgroundColor = .systemBlue;
        confirmButton.setTitle("Confirm", for: .normal);
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside);
    }
    
    @objc func confirm() {
        ManagerController.shared.order.menuItems.removeAll();
        dismiss(animated: true, completion: nil);
    }
}
extension OrderWaitViewController {
    func addSubView() {
        self.view.addSubview(resultLabel);
        self.view.addSubview(confirmButton);
    }
    func constrains() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false;
        confirmButton.translatesAutoresizingMaskIntoConstraints = false;
        
        resultLabel.anchor(top: view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 70, enableInsets: false);
        confirmButton.anchor(top: resultLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 100, paddingBottom: 0, paddingRight: 100, width: 0, height: 50, enableInsets: false);
    }
}

