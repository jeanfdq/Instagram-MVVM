//
//  SearchViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    private let reuseIdentifierSearchCell = "cellId"
    
    private var listOfUsers:[User] = [] {
        didSet {
            if listOfUsers.count > 0 {
                filteredListUsers = listOfUsers
                collectionView.reloadData()
            }
        }
    }
    private var filteredListUsers = [User]()
    
    private var userSelected:User? {
        didSet {
            guard let userSelected = userSelected else {return}
            let profileVC = ProfileViewController(userSelected)
            profileVC.isDisplayMode = true
            //profileVC.setUserToFollowed = self.setUserToFollowed
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    lazy var searchController:UISearchController = {
        let searchControl  = UISearchController()
        searchControl.searchBar.sizeToFit()
        searchControl.hidesNavigationBarDuringPresentation          = false
        searchControl.obscuresBackgroundDuringPresentation          = false
        searchControl.searchBar.backgroundColor                     = .clear
        searchControl.searchBar.searchBarStyle                      = .minimal
        searchControl.searchBar.placeholder                         = "search..."
        searchControl.searchBar.searchTextField.textColor           = .darkGray
        searchControl.searchBar.searchTextField.backgroundColor     = .clear
        searchControl.searchBar.delegate = self
        definesPresentationContext = false
        return searchControl
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchListUsers()
    }
    
    // MARK: - functions
    
    fileprivate func setupView() {
        navigationItem.titleView = searchController.searchBar
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchUserCell.self, forCellWithReuseIdentifier: reuseIdentifierSearchCell)
    }
    
    fileprivate func fetchListUsers() {
        
        let progress = Progress.show(view)
        
        UserService.fetchAllUsers { result in
            
            switch result {
            case .failure(let err): self.showLoafError(message: err.localizedDescription)
            case .success(let users): self.listOfUsers = users
            }
            
            progress.dismiss()
        }
    }
    
//    fileprivate func setUserToFollowed(_ userId:String){
//        for index in (0 ..< filteredListUsers.count) where filteredListUsers[index].id == userId {
//            filteredListUsers[index].followed = true
//        }
//    }
    
    // MARK: - CollectionView Events
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredListUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierSearchCell, for: indexPath) as! SearchUserCell
        cell.viewModel = SearchUserViewModel(filteredListUsers[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = (view.frame.width - 2) / 3
        return .init(width: sizeCell, height: sizeCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelected = filteredListUsers[indexPath.item]
    }
    
}

//MARK: - SearchBar Events
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else {return}
        filteredListUsers = listOfUsers.filter { $0.userSearch.lowercased().replace(string: "-", replacement: " ").contains(searchText) }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredListUsers = listOfUsers
        collectionView.reloadData()
    }
}
