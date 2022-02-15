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
    
    var menuItems = [MenuItem]();
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationItem.title = navigationTitle ?? "Menu";
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never;
    }
    
    private func updateUI(with menuItems: [MenuItem]) {
        self.menuItems = menuItems;
        //        self.menuTableView.estimatedRowHeight = UITableView.automaticDimension;
        self.menuTableView.reloadData();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true);
        self.imageLoadTask.forEach { _, value in value.cancel() };
    }
}

extension MenuController {
    
    func addSubView() {
        self.view.addSubview(menuTableView);
        
    }
    func constrains() {
        self.view.addConstraints([self.menuTableView.topAnchor.constraint(equalTo: view.topAnchor),
                                  self.menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                  self.menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                  self.menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                 ]);
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //            return UITableView.automaticDimension;
        return 44;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell;
        let menuItem = self.menuItems[indexPath.row];
        
        cell.labelMenu.text = menuItem.name;
        cell.labelPrice.text = menuItem.price.formatted(.currency(code: "usd"));
        cell.imageViewMenu.image = nil;
        imageLoadTask[indexPath] = Task.init {
            if let image = try? await ManagerController.shared.fetchImage(from: menuItem.imageUrl) {
                if let isIndexValid = menuTableView.indexPath(for: cell), isIndexValid == indexPath {
                    cell.imageViewMenu.image = image;
                }
            }
            imageLoadTask[indexPath] = nil;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailController();
        detail.menuItem = menuItems[indexPath.row];
        self.navigationController?.pushViewController(detail, animated: true);
    }
}
