//
//  MenuTableViewCell.swift
//  RestaurantDemo
//
//  Created by PIG on 2022/2/2.
//

import Foundation
import UIKit


class MenuTableViewCell: UITableViewCell {
    let imageViewMenu = UIImageView();
    let labelMenu = UILabel();
    let labelPrice = UILabel();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        imageViewMenu.backgroundColor = .blue;
        
        imageViewMenu.translatesAutoresizingMaskIntoConstraints = false;
        labelMenu.translatesAutoresizingMaskIntoConstraints = false;
        labelPrice.translatesAutoresizingMaskIntoConstraints = false;
        
        
        addSubview(imageViewMenu);
        addSubview(labelMenu);
        addSubview(labelPrice);
        
        imageViewMenu.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 34, height: 0, enableInsets: false);
        labelMenu.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 60, paddingBottom: 5, paddingRight: 0, width: 300, height: 0, enableInsets: false);
        labelPrice.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 60, height: 0, enableInsets: false);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        print("awakeFromNib")
    }
}
