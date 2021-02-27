//
//  NotificationsViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class NotificationsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    let reuseIdentifierCell = "ReuseIdentifier"
    
    private var listOfNotifications = [PostNotification]() {
        didSet { self.collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchNotifications()
        
    }
    
    // MARK: - functions
    
    fileprivate func setupUI() {
        navigationItem.title = "Notifications"
        collectionView.backgroundColor = .white
        collectionView.register(NotificationsCell.self, forCellWithReuseIdentifier: reuseIdentifierCell)
    }
    
    fileprivate func fetchNotifications() {
        let progress = self.showLoading()
        NotificationsService.fetchNotifications { list in
            self.listOfNotifications = list
            progress.dismiss()
        }
    }
    
    // MARK: - CollectionView Events
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfNotifications.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as! NotificationsCell
        cell.viewModel = PostNotificationViewModel(listOfNotifications[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userID = listOfNotifications[indexPath.item].userId
        UserService.fetchUser(userID) { result in
            
            switch result {
            case .failure(let error): self.showLoafError(message: error.localizedDescription)
            case .success(let user):
                guard let user = user else {return}
                let profileVC = ProfileViewController(user)
                profileVC.isDisplayMode = true
                self.navigationController?.pushViewController(profileVC, animated: true)
            }
            
        }
        
    }
    

}
