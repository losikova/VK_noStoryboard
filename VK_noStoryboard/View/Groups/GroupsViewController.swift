//
//  GroupsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class GroupsViewController: UIViewController {

    let userGroupsTableView = UITableView()
    let webService = vkService(token: Session.instance.token)
    let loadingView = LoadingView()
    
    private var myGroups: Results<Group>? {
        realm.readData(object: Group.self)
    }
    var groupRealm = [Group]()
    let realm = RealmService()
    var token: NotificationToken? = nil
    let firebaneService = [FirebaseGroups]()
    let ref = Database.database().reference(withPath: "Group")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userGroupsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        userGroupsTableView.rowHeight = 70
        userGroupsTableView.delegate = self
        userGroupsTableView.dataSource = self
        
        setupUI()
        fillGroupsArray()
        createNotificationToken()
        
        ref.observe(.value) { snapshot in
            var groups: [FirebaseGroups] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let group = FirebaseGroups(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            groups.forEach { print($0.name) }
        }
    }
    
    func isItemAlreadyInArraay(group: Group) -> Bool {
        return groupRealm.contains{sourceGroup in
            sourceGroup.name == group.name
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = myGroups?[indexPath.row] else { return }
        let fireCom = FirebaseGroups(name: group.name, id: group.id)
        let groupRef = self.ref.child(group.name.lowercased())
        groupRef.setValue(fireCom.toAnyObject())
    }
    
    private func setupUI() {
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
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        loadingView.clipsToBounds = true
        
        let searchGroupsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchGroups))
        searchGroupsButton.tintColor = .systemBlue
        navigationItem.setRightBarButton(searchGroupsButton, animated: true)
    }
    
    private func fillGroupsArray() {
        webService.getGroups()
        realm.readData(object: Group.self).forEach{ groupRealm.append($0) }
        userGroupsTableView.reloadData()
    }
    
    @objc private func searchGroups() {
        let allGroupsController = AllGroupsViewController()
        allGroupsController.delegate = self
        
        navigationController?.pushViewController(allGroupsController, animated: true)
    }
    
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
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

extension GroupsViewController: DidSelectGroupProtocol {
    func selectGroup(_ selectedGroup: Group?) {
        guard let selectedGroup = selectedGroup else {return}
        if isItemAlreadyInArraay(group: selectedGroup) {return}
        self.groupRealm.append(selectedGroup)
        userGroupsTableView.reloadData()
    }
    
}

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
