//
//  GroupsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class GroupsViewController: UIViewController {

    let userGroupsTableView = UITableView()
    
//    let reuseIdentifierGroups = "reuseIdentifierGroups"
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userGroupsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        userGroupsTableView.rowHeight = 70
        userGroupsTableView.delegate = self
        userGroupsTableView.dataSource = self
        
        setup()
    }
    
    func isItemAlreadyInArraay(group: Group) -> Bool {
        return groupArray.contains{sourceGroup in
            sourceGroup.name == group.name
        }
    }
    
    private func setup() {
        self.title = "My Groups"
        
        view.addSubview(userGroupsTableView)
        userGroupsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            userGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            userGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        userGroupsTableView.clipsToBounds = true
        
        let searchGroupsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchGroups))
        searchGroupsButton.tintColor = .black
        navigationItem.setRightBarButton(searchGroupsButton, animated: true)
    }
    
    @objc private func searchGroups() {
        let allGroupsController = AllGroupsViewController()
        navigationController?.pushViewController(allGroupsController, animated: true)
    }
    
//    @IBAction func unwindAddGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == "addGroup",
//           let allGroupsViewController = segue.source as? AllGroupsViewController,
//           let selectedGroup = allGroupsViewController.selectedGroup as? Group {
//            if isItemAlreadyInArraay(group: selectedGroup) {return}
//            self.groupArray.append(selectedGroup)
//            userGroupsTableView.reloadData()
//        }
//
//    }
    
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userGroupsTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        cell.avatarImageView.layer.cornerRadius = 25
        cell.configure(group: groupArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
