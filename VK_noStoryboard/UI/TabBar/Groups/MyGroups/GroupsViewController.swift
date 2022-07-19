//
//  GroupsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit
import RealmSwift

final class GroupsViewController: UIViewController {

    // MARK: Private properties
    private var myGroups: Results<Group>? {
        realm.readData(object: Group.self)
    }
    private let userGroupsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private let webService = vkService(token: Session.instance.token)
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private var groupRealm = [Group]()
    private let realm = RealmService()
    private var token: NotificationToken? = nil
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        userGroupsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        userGroupsTableView.rowHeight = 70
        userGroupsTableView.dataSource = self
        
        setupUI()
        fillGroupsArray()
        createNotificationToken()
    }
}

// MARK: - Private SetupUI
private extension GroupsViewController {
    
    func setupUI() {
        self.title = "My Groups"
        view.addSubview(userGroupsTableView)
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            userGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            userGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            userGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        let searchGroupsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchGroups))
        searchGroupsButton.tintColor = .systemBlue
        navigationItem.setRightBarButton(searchGroupsButton, animated: true)
    }
}

// MARK: - Private Actions
private extension GroupsViewController {
    
    /// Проверка наличия группы в списке
    /// - Parameters:
    ///     - group: Группа для проверки
    func isItemAlreadyInArray(group: Group) -> Bool {
        return groupRealm.contains{sourceGroup in
            sourceGroup.name == group.name
        }
    }
    
    /// Заполнение массива групп
    func fillGroupsArray() {
        webService.getGroups()
        realm.readData(object: Group.self).forEach{ groupRealm.append($0) }
        userGroupsTableView.reloadData()
    }
    
    /// Поиск по всем группам
    @objc func searchGroups() {
        let allGroupsController = AllGroupsViewController()
        allGroupsController.delegate = self
        
        navigationController?.pushViewController(allGroupsController, animated: true)
    }
}

// MARK: - Data Source
extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userGroupsTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        cell.avatarImageView.layer.cornerRadius = 25
        
        loadingView.animateLoading(.start)
        DispatchQueue.main.async {[weak self] in
            cell.configure(group: (self?.groupRealm[indexPath.row])!)
            self?.loadingView.animateLoading(.stop)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupRealm.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Did select
extension GroupsViewController: DidSelectGroupProtocol {
    
    func selectGroup(_ selectedGroup: Group?) {
        guard let selectedGroup = selectedGroup else {return}
        if isItemAlreadyInArray(group: selectedGroup) {return}
        self.groupRealm.append(selectedGroup)
        userGroupsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = myGroups?[indexPath.row] else { return }
    }
}

// MARK: - Private norifications
private extension GroupsViewController {
    
    func createNotificationToken() {
        token = myGroups?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let groupsData):
                print("\(groupsData.count) groups")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):

                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.userGroupsTableView.beginUpdates()

                    self.userGroupsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.userGroupsTableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.userGroupsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.userGroupsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
