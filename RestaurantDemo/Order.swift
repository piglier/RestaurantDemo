//
//  Order.swift
//  RestaurantDemo
//
//  Created by PIG on 2022/2/14.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems;
    }
}
