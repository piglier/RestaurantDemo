//
//  File.swift
//  TableviewDemo
//
//  Created by 朱彥睿 on 2022/1/20.
//

import Foundation
import UIKit

class MenuController: UIViewController {
    let menuTableView: UITableView = {
        let mTableView = UITableView();
        mTableView.translatesAutoresizingMaskIntoConstraints = false;
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell");
        return mTableView;
    }()
    var navigationTitle: String?
    
    var menu = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        menuTableView.delegate = self;
        menuTableView.dataSource = self;
        addSubView();
        constrains();
        
        Task.init {
            if let title = navigationTitle {
                print("menuTask: \(title)")
                menu = try await ManagerController.shared.getMenu(categoryName: title);
                print("menu: \(menu.description)")
            }
            
        }
    }
}

extension MenuController {
    func addSubView() {
        self.navigationItem.title = navigationTitle ?? "Menu";
        self.navigationController?.navigationBar.prefersLargeTitles = false;
        self.view.addSubview(menuTableView);
        
    }
    func constrains() {
        self.view.addConstraints([self.menuTableView.topAnchor.constraint(equalTo: view.topAnchor),
                                  self.menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                  self.menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                  self.menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                 ]);
    }
    func callApi() {
        
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath);
        
        return cell;
    }
}
