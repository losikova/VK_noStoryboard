//
//  AllGroupsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

protocol DidSelectGroupProtocol: AnyObject {
    func selectGroup(_ selectedGroup: Group?)
}

class AllGroupsViewController: UIViewController {
    
    let allGroupsTableView = UITableView()
    let searchBar = UISearchBar()
    
    var groupArray = [Group]()
    var delegate: DidSelectGroupProtocol?
//    var selectedGroup: Group?
    var savedGroupArray = [Group]()
    
    let groupsNames = [
        "Doggy",
        "пакетик брать будете?",
        "quite mooo"
    ]
    
    func fillGroupArray() {
        for name in groupsNames {
            let group = Group(name: name, icon: UIImage(named: name)!)
            groupArray.append(group)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillGroupArray()
        savedGroupArray = groupArray
        allGroupsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        allGroupsTableView.rowHeight = 70
        allGroupsTableView.delegate = self
        allGroupsTableView.dataSource = self
        searchBar.delegate = self
        
        setup()
    }
    
    private func setup() {
        self.title = "All Groups"
        
        view.addSubview(allGroupsTableView)
        
        allGroupsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            allGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            allGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            allGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        allGroupsTableView.clipsToBounds = true
    }
    
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allGroupsTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        cell.avatarImageView.layer.cornerRadius = 25
        cell.configure(group: groupArray[indexPath.row])
        
        cell.rowNumber = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectGroup(groupArray[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar
    }
    
}

extension AllGroupsViewController: UISearchBarDelegate, CustomTableViewCellProtocol {
    func performAfterTap(row: IndexPath) {
        tableView(allGroupsTableView, didSelectRowAt: row)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.groupArray = self.savedGroupArray
        } else {
            self.groupArray = groupArray.filter({$0.name.lowercased().contains(searchText.lowercased())})
        }
        self.allGroupsTableView.reloadData()
    }
}

