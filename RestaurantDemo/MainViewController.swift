//
//  ViewController.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/17.
//

import UIKit

class MainViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainCell")
        return tableView
    }()
    
    var categories = [String]();

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        addSubview();
        addConstrains();
        
        Task.init {
            do {
                categories = try await ManagerController.shared.getCategories();
                tableView.reloadData();
            } catch {
                throw AppError.DecodeError.decodeCategoriesError;
            }
        }
        // Do any additional setup after loading the view.
    }


}

extension MainViewController {
    private func addSubview() {
        self.navigationItem.title = "Restaurant";
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        self.view.addSubview(tableView);
    }
    private func addConstrains() {
        self.view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc func selectorName() {
        print("maybe")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath);
        var content = cell.defaultContentConfiguration();
        content.text = categories[indexPath.row].capitalized;
        cell.contentConfiguration = content;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextController = MenuController() as? UIViewController {
            
            self.navigationController?.pushViewController(nextController, animated: false);
        }
        
    }
}