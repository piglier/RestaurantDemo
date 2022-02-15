//
//  OrderWaitViewController.swift
//  RestaurantDemo
//
//  Created by PIG on 2022/2/16.
//

import Foundation
import UIKit

class OrderWaitViewController: UIViewController {
    let resultLabel = UILabel();
    let confirmButton = UIButton();
    override func viewDidLoad() {
        super.viewDidLoad();
        addSubView();
        constrains();
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
        
        resultLabel.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 150, height: 60, enableInsets: false);
        confirmButton.anchor(top: self.resultLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50, enableInsets: false);
    }
}

