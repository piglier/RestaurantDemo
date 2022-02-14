//
//  File.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/19.
//

import Foundation
import UIKit

class DetailController: UIViewController {
    private let imageViewDetail = UIImageView();
    private let labelMenu = UILabel();
    private let labelPrice = UILabel();
    private let labelDetail = UILabel();
    private let buttonAddOrder = UIButton();
    var menuItem: MenuItem?;
    
    override func viewDidLoad() {
        addSubView();
        constrains();
        updateUI();
        buttonAddOrder.addTarget(self, action: #selector(addOrder), for: .touchUpInside);
    }
    
    @objc
    func addOrder() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.buttonAddOrder.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.buttonAddOrder.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        if let menuItem = menuItem {
            ManagerController.shared.order.menuItems.append(menuItem);
        }
    }
}

extension DetailController {
    private func addSubView() {
        self.view.addSubview(imageViewDetail);
        self.view.addSubview(labelMenu);
        self.view.addSubview(labelPrice);
        self.view.addSubview(labelDetail);
        self.view.addSubview(buttonAddOrder);
    }
    private func constrains() {
        imageViewDetail.translatesAutoresizingMaskIntoConstraints = false;
        labelMenu.translatesAutoresizingMaskIntoConstraints = false;
        labelPrice.translatesAutoresizingMaskIntoConstraints = false;
        labelDetail.translatesAutoresizingMaskIntoConstraints = false;
        buttonAddOrder.translatesAutoresizingMaskIntoConstraints = false;
        
        let viewWidth = UIScreen.main.bounds.width;
        var minHeight = CGFloat(66)
        let newTopAnchor = view.safeAreaLayoutGuide.topAnchor;
        let bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor;
        
        if let menuItem = menuItem {
            minHeight = menuItem.description.textAutoHeight(width: viewWidth, font: UIFont.systemFont(ofSize: 16));
        }
        
        imageViewDetail.anchor(top: newTopAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 100, enableInsets: false);
        labelMenu.anchor(top: imageViewDetail.bottomAnchor, left: view.leftAnchor, bottom: nil, right: labelPrice.leftAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 60, width: 0, height: 33, enableInsets: false);
        labelPrice.anchor(top: imageViewDetail.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 60, height: 33, enableInsets: false);
        labelDetail.anchor(top: labelMenu.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: minHeight, enableInsets: false);
        
        buttonAddOrder.anchor(top: nil, left: view.leftAnchor, bottom: bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 44, enableInsets: false);
    }
    private func updateUI() {
        self.view.backgroundColor = .white;
        self.navigationItem.title = "Detail";
        self.navigationController?.navigationBar.prefersLargeTitles = false;
        buttonAddOrder.setTitle("Add", for: .normal);
        buttonAddOrder.backgroundColor = .systemBlue;
        buttonAddOrder.layer.cornerRadius = 10;
        
        if let menu = menuItem {
            labelMenu.text = menu.name;
            labelPrice.text = menu.price.formatted(.currency(code: "usd"));
            labelDetail.text = menu.description
            labelDetail.font = UIFont.systemFont(ofSize: 16)
            labelMenu.numberOfLines = 0;
            labelDetail.numberOfLines = 0;
            labelDetail.textColor = .systemGray;
            imageViewDetail.image = nil;
            Task.init {
                if let image = try? await ManagerController.shared.fetchImage(from: menu.imageUrl) {
                    imageViewDetail.image = image;
                };
            }
        }
    }
}
