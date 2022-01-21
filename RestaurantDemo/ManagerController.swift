//
//  ManagerController.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/17.
//

import Foundation

class ManagerController {
    static let shared = ManagerController();
    
    let base_url = URL(string: "http://localhost:8080/")!;
    
    func getCategories() async throws -> [String] {
        let categoriesUrl = base_url.appendingPathComponent("categories");
        let (data, response) = try await URLSession.shared.data(from: categoriesUrl);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.ServerError.GetCategoriesError }
        return try JSONDecoder().decode(CategoriesModel.self, from: data).categories;
    }
    
    func getMenu(categoryName: String) async throws -> [String] {
        let menuUrl = base_url.appendingPathComponent("menu");
        var component = URLComponents(url: menuUrl, resolvingAgainstBaseURL: true)!;
        component.queryItems = [URLQueryItem(name: "categories", value: categoryName)];
        let categoryUrl = component.url!;
        let (data, response) = try await URLSession.shared.data(from: categoryUrl);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AppError.ServerError.GetCategoriesError }
        return try JSONDecoder().decode(CategoriesModel.self, from: data).categories;
    }
}
