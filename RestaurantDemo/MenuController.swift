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
        mTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "menuCell");
        return mTableView;
    }()
    var navigationTitle: String?
    
    var menu = [MenuModel]();
    
    var imageLoadTask: [IndexPath: Task<Void, Never>] = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .white;
        menuTableView.delegate = self;
        menuTableView.dataSource = self;
        addSubView();
        constrains();
        guard let title = navigationTitle else { return }
        Task.init {
            do {
                let menuItems = try await ManagerController.shared.getMenu(categoryName: title);
                updateUI(with: menuItems)
            } catch {
                Global.showAlert(title: "Failed to fetch menu", error: error, viewController: self);
            }
        }
    }
    
    private func updateUI(with menuItems: [MenuModel]) {
        self.menu = menuItems;
        self.menuTableView.reloadData();
    }
}
    
    extension MenuController {
        
        func addSubView() {
            self.navigationItem.title = navigationTitle ?? "Menu";
            self.navigationController?.navigationBar.prefersLargeTitles = false;
            self.menuTableView.estimatedRowHeight = 44;
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
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1;
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menu.count;
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            44;
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell;
            let menuItem = self.menu[indexPath.row];
            
            cell.labelMenu.text = menuItem.name;
            cell.labelPrice.text = menuItem.price.formatted(.currency(code: "usd"));
            cell.imageViewMenu.image = nil;
            imageLoadTask[indexPath] = Task.init {
                if let image = try? await ManagerController.shared.fetchImage(from: menuItem.imageUrl) {
                    if let isIndexValid = menuTableView.indexPath(for: cell), isIndexValid == indexPath {
                        cell.imageViewMenu.image = image;
                    }
                    imageLoadTask[indexPath] = nil;
                }
            }
            return cell;
        }
        
    }
