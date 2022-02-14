//
//  ServerModel.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/17.
//

import Foundation

struct CategoriesModel: Codable {
    let categories: [String];
}

struct ItemModel: Codable {
    let items: [MenuItem];
}

struct MenuItem: Codable {
    let category: String;
    let id: Int;
    let imageUrl: URL;
    let name: String;
    let description: String;
    let price: Double;
    
    enum CodingKeys: String, CodingKey {
        case category
        case id
        case imageUrl = "image_url"
        case name
        case description
        case price
    }
}
