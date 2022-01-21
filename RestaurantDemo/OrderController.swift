//
//  OrderController.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/18.
//

import Foundation
import UIKit

class OrderController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "orderCell");
        return tableView;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        addSubview();
        addConstrains();
    }
}

extension OrderController {
    private func addSubview() {
        self.navigationItem.title = "Order";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "submit", style: .plain, target: self, action: #selector(submit))
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
    
    @objc func submit() {
        print("submit")
    }
}

extension OrderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath);
    }
    
    
}
