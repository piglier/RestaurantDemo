//
//  OrderController.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/18.
//

import Foundation
import UIKit

class OrderController: UIViewController {
    let orderTableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "orderCell");
        return tableView;
    }();
    
    var imageTask: [IndexPath: Task<Void, Never>] = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        orderTableView.dataSource = self;
        orderTableView.delegate = self;
        addSubview();
        addConstrains();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        self.orderTableView.reloadData();
    }
}

extension OrderController {
    private func addSubview() {
        self.navigationItem.title = "Order";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "submit", style: .plain, target: self, action: #selector(submit))
        self.view.addSubview(orderTableView);
    }
    private func addConstrains() {
        self.view.addConstraints([
            orderTableView.topAnchor.constraint(equalTo: view.topAnchor),
            orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            orderTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc func submit() {
        print("submit")
    }
}

extension OrderController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagerController.shared.order.menuItems.count;
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath);
        configure(cell, indexPath);
        return cell;
    }
    
    func configure(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        let menuItem = ManagerController.shared.order.menuItems[indexPath.row];
        if let cell = cell as? MenuTableViewCell {
            cell.labelMenu.text = menuItem.name;
            cell.labelPrice.text = menuItem.price.formatted(.currency(code: "usd"));
            cell.imageViewMenu.image = nil;
            imageTask[indexPath] = Task.init {
                if let image = try? await ManagerController.shared.fetchImage(from: menuItem.imageUrl) {
                    if let isIndexValid = orderTableView.indexPath(for: cell), indexPath == isIndexValid {
                        cell.imageViewMenu.image = image
                    }
                }
                imageTask[indexPath] = nil;
            }
        }
    }
}
