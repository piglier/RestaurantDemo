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
    
    
    var menuItem: MenuModel?;
    
    override func viewDidLoad() {
        addSubView();
        constrains();
        updateUI();
    }
}

extension DetailController {
    func addSubView() {
        
        self.view.addSubview(imageViewDetail);
        self.view.addSubview(labelMenu);
        self.view.addSubview(labelPrice);
        self.view.addSubview(labelDetail);
        self.view.addSubview(buttonAddOrder);
    }
    func constrains() {
        imageViewDetail.translatesAutoresizingMaskIntoConstraints = false;
        labelMenu.translatesAutoresizingMaskIntoConstraints = false;
        labelPrice.translatesAutoresizingMaskIntoConstraints = false;
        labelDetail.translatesAutoresizingMaskIntoConstraints = false;
        buttonAddOrder.translatesAutoresizingMaskIntoConstraints = false;
        
        imageViewDetail.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 100, enableInsets: false);
        labelMenu.anchor(top: imageViewDetail.bottomAnchor, left: view.leftAnchor, bottom: nil, right: labelPrice.leftAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 60, width: 0, height: 44, enableInsets: false);
        labelPrice.anchor(top: imageViewDetail.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 60, height: 44, enableInsets: false);
        labelDetail.anchor(top: labelMenu.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 150, enableInsets: false);
        
        buttonAddOrder.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 60, enableInsets: false);
    }
    private func updateUI() {
        self.view.backgroundColor = .white;
        self.navigationItem.title = "Detail";
        self.navigationController?.navigationBar.prefersLargeTitles = false;
        
        labelMenu.numberOfLines = 0;
        labelDetail.numberOfLines = 0;
        
        buttonAddOrder.titleLabel?.text = "Add";
        buttonAddOrder.backgroundColor = .blue;
        
        if let menu = menuItem {
            labelMenu.text = menu.name;
            labelPrice.text = menu.price.formatted(.currency(code: "usd"));
            labelDetail.text = menu.description
            imageViewDetail.image = nil;
            Task.init {
                if let image = try? await ManagerController.shared.fetchImage(from: menu.imageUrl) {
                    imageViewDetail.image = image;
                };
            }
        }
    }
}
