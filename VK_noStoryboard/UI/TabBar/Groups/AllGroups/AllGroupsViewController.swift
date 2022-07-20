//
//  AllGroupsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

/// Передача группы с общего экрана групп в "мои" группы
protocol DidSelectGroupProtocol: AnyObject {
    ///Выбрана группа
    ///- Parameters:
    ///    - selectedGroup: Выбранная группа
    func selectGroup(_ selectedGroup: Group?)
}

final class AllGroupsViewController: UIViewController {
    
    // MARK: Public Properties
    /// Делегат с данного экрана на экран "моих" групп
    var delegate: DidSelectGroupProtocol?
    
    // MARK: Private Properties
    private let allGroupsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private let searchBar = UISearchBar()
    
    private var groupArray = [Group]()
//    var selectedGroup: Group?
    /// Массив сохраненных групп
    private var savedGroupArray = [Group]()
    
    /// Массив названий групп
    private let groupsNames = [
        "Doggy",
        "пакетик брать будете?",
        "quite mooo"
    ]
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        fillGroupArray()
        savedGroupArray = groupArray
        allGroupsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        allGroupsTableView.rowHeight = 70
        allGroupsTableView.dataSource = self
        searchBar.delegate = self
        
        setup()
    }
}

// MARK: = Private SetupUI
private extension AllGroupsViewController {
    
    func setup() {
        self.title = "All Groups"
        
        view.addSubview(allGroupsTableView)
        
        NSLayoutConstraint.activate([
            allGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            allGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            allGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            allGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Data Source
extension AllGroupsViewController: UITableViewDataSource {
    
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
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar
    }
    
}

// MARK: - Search delegate
extension AllGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.groupArray = self.savedGroupArray
        } else {
            self.groupArray = groupArray.filter({$0.name.lowercased().contains(searchText.lowercased())})
        }
        self.allGroupsTableView.reloadData()
    }
}

// MARK: - Tap Delegate
extension AllGroupsViewController: CustomTableViewCellProtocol {
    
    func performAfterTap(row: IndexPath) {
        tableView(allGroupsTableView, didSelectRowAt: row)
    }
}

// MARK: - Private Actions
private extension AllGroupsViewController {
    
    func fillGroupArray() {
//        for name in groupsNames {
//            let group = Group(name: name, icon: UIImage(named: name)!)
//            groupArray.append(group)
//        }
    }
}
