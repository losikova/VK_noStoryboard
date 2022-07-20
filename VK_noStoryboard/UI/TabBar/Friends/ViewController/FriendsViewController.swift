//
//  FriendsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit
import RealmSwift

final class FriendsViewController: UIViewController {
    
    // MARK: Private properties
    /// Главное view страницы друзей
    private let friendsTableView: UITableView = {
        let view = UITableView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Массив первых букв для разделения на секции по алфавиту
    private var sectionLetters = [String]()
    
    /// Данные, полученные с сервера
    private var myFriends: Results<Friend>? {
        realm.readData(object: Friend.self)
    }
    /// Токен для realm
    private var token: NotificationToken?
    /// Массив данных друузей с сервера
    private var friendsRealm = [Friend]()
    
    /// View загрзки, если данные долго грузятся
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    /// Сервис для получения данных
    private let webService = vkService(token: Session.instance.token)
    private let realm = RealmService()
    
    // MARK: Init
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        self.title = "Friends"
        fillFriendsArray()
        createNotificationToken()
    }

}

//MARK: - Data Source
extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionLetters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsBySection(letter: sectionLetters[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.avatarImageView.layer.cornerRadius = 25
        
        let loading = DispatchWorkItem { [weak self] in
            self?.loadingView.animateLoading(.start)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: loading)
        
        DispatchQueue.main.async {[weak self] in
            cell.configure(friend: (self?.friendsBySection(letter: (self?.sectionLetters[indexPath.section])!)[indexPath.row])!)
            cell.rowNumber = indexPath
            
            cell.delegate = self
            loading.cancel()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = friendsBySection(letter: sectionLetters[indexPath.section])
        let friend = section[indexPath.row]
        let galleryController = GalleryViewController()
        
        galleryController.userId = friend.id
        
        navigationController?.pushViewController(galleryController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionLetters[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionLetters
    }
    
}

//MARK: - Delegate
extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Tap protocol
extension FriendsViewController: CustomTableViewCellProtocol {
    
    func performAfterTap(row: IndexPath) {
        tableView(friendsTableView, didSelectRowAt: row)
    }
}

// MARK: - Private SetupUI
private extension FriendsViewController {
    
    func setupUI() {
        view.addSubview(friendsTableView)
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            friendsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            friendsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            friendsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
}

// MARK: - Private Data Fill
private extension FriendsViewController {
    
    /// Заполнение массива друзей данными с сервера
    func fillFriendsArray() {
        webService.getFriends()
        realm.readData(object: Friend.self).forEach{ friendsRealm.append($0) }
        friendsRealm.sort(by: {$0.firstName < $1.firstName})
        fillSectionLetters()
        friendsTableView.reloadData()
    }
    
    /// Заполнение массива букв секций
    func fillSectionLetters() {
        for friend in friendsRealm {
            let letter = String(friend.firstName.prefix(1)).uppercased()
            if !sectionLetters.contains(letter) {
                sectionLetters.append(letter)
            }
        }
    }
    
    /// Фильтрация имён друзей по алфавиту
    func friendsBySection(letter: String) -> [Friend] {
        var resultArray = [Friend]()
        for friend in friendsRealm {
            if friend.firstName.prefix(1).uppercased() == letter.uppercased() {
                resultArray.append(friend)
            }
        }
        return resultArray
    }
}

// MARK: - Notifications
private extension FriendsViewController {
    
    func createNotificationToken() {
        token = myFriends?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let friendsData):
                print("\(friendsData.count) friends")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):

                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.friendsTableView.beginUpdates()

                    self.friendsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.friendsTableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.friendsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.friendsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
    
}

