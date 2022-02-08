//
//  ManagerController.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/17.
//

import Foundation
import UIKit

class ManagerController {
    static let shared = ManagerController();
    
    let base_url = URL(string: "http://localhost:8080/")!;
    
    func getCategories() async throws -> [String] {
        let categoriesUrl = base_url.appendingPathComponent("categories");
        let (data, response) = try await URLSession.shared.data(from: categoriesUrl);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.ServerError.GetCategoriesError }
        return try JSONDecoder().decode(CategoriesModel.self, from: data).categories;
    }
    
    func getMenu(categoryName: String) async throws -> [MenuModel] {
        let menuUrl = base_url.appendingPathComponent("menu");
        var component = URLComponents(url: menuUrl, resolvingAgainstBaseURL: true)!;
        component.queryItems = [URLQueryItem(name: "category", value: categoryName)];
        let categoryUrl = component.url!;
        let (data, response) = try await URLSession.shared.data(from: categoryUrl);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.ServerError.GetCategoriesError }
        return try JSONDecoder().decode(ItemModel.self, from: data).items;
    }
    
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, reponse) = try await URLSession.shared.data(from: url);
        
        guard let httpReponse = reponse as? HTTPURLResponse, httpReponse.statusCode == 200 else {
            throw AppError.ServerError.FetchImageDataMissingError
        }
        guard let image = UIImage(data: data) else {
            throw AppError.ServerError.FetchImageDataMissingError
        }
        return image;
    }
}
