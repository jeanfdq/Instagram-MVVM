//
//  ProfileViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    fileprivate var user:User
    
    open var isDisplayMode:Bool = false
    
    private let reusableProfileHeaderId = "reusableHeaderId"
    private let reusableProfileCellId = "reusableCellId"
    
    lazy var userNameLabel:UILabel = {
        let userName = UILabel()
        userName.font = .systemFont(ofSize: 14, weight: .semibold)
        userName.isUserInteractionEnabled = true
        userName.addTapGesture {[unowned self] in
            if self.isDisplayMode {
                self.navigationController?.popViewController(animated: true)
            }
        }
        return userName
    }()
    
    lazy var logoutLabel:UILabel = {
        let logout = UILabel()
        logout.text = "logout"
        logout.font = .systemFont(ofSize: 13, weight: .semibold)
        logout.isHidden = isDisplayMode
        logout.isUserInteractionEnabled = true
        logout.addTapGesture {
            self.logout()
        }
        return logout
    }()
    
    // MARK: - LifeCycle
    
    init(_ user:User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserStas()
        checkIfUserIsFollwed()
        
    }
    
    // MARK: - functions
    
    fileprivate func setupView() {
        userNameLabel.text = isDisplayMode ? "voltar" : user.userName
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userNameLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutLabel)
    }
    
    fileprivate func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reusableProfileHeaderId)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: reusableProfileCellId)
    }
    
    fileprivate func getUserStas() {
        UserService.fetchUserStats(user.id) { [weak self] stats in
            self?.user.stats = stats
            self?.collectionView.reloadData()
        }
    }
    
    fileprivate func checkIfUserIsFollwed() {
        UserService.checkIfUserIsFollowed(user.id) { [weak self] isFollowed in
            self?.user.followed = isFollowed
            self?.collectionView.reloadData()
        }
    }
    
    fileprivate func actionEditProfile() {
      
    }
    
    fileprivate func actionFollowProfile() {
        let progress = Progress.show(view)
        UserService.follow(user.id) { [weak self] result in
            switch result {
            case .failure(let err): self?.showLoafError(message: err.localizedDescription)
            case .success(): self?.checkIfUserIsFollwed()
            }
            progress.dismiss()
        }
        
    }
    
    fileprivate func actionUnfollowProfile() {
        let progress = Progress.show(view)
        UserService.unfollow(user.id) { [weak self] result in
            switch result {
            case .failure(let err): self?.showLoafError(message: err.localizedDescription)
            case .success(): self?.checkIfUserIsFollwed()
                
            }
            progress.dismiss()
        }
    }
    
    @objc fileprivate func logout(){
        let alertLogout = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "logout", style: .default) { _ in
            AuthService.shared.logout()
            NotificationCenter.default.post(name: .NCD_UserLogout, object: nil)
        }
        logoutAction.setTitleColor(color: .red)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        cancelAction.setTitleColor(color: .blue)
        
        alertLogout.addAction(logoutAction)
        alertLogout.addAction(cancelAction)
        
        present(alertLogout, animated: true)

    }
    
    //MARK: - CollectionView Functions
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableProfileHeaderId, for: indexPath) as! ProfileHeaderView
        header.viewModel                = ProfileHeaderViewModel(user)
        header.actionEditProfile        = self.actionEditProfile
        header.actionFollowProfile      = self.actionFollowProfile
        header.actionUnfollowProfile    = self.actionUnfollowProfile
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height * 0.22)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableProfileCellId, for: indexPath) as! ProfileCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (view.frame.width - 2) / 3
        return .init(width: widthCell, height: widthCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
