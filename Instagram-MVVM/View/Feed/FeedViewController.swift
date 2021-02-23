//
//  FeedViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class FeedViewController: UICollectionViewController {

    // MARK: - Properties
    
    fileprivate let reusableCellId = "resuseableCellId"
    
    fileprivate var listOfPosts = [Post]()
    
    fileprivate let logoInstagram:UIImageView = {
        let logo = UIImageView(image: UIImage(named: "Instagram_logo_white")?.withTintColor(.black))
        return logo
    }()
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupCollectionView()
        
        fetchPosts()
    }
    
    fileprivate func setupUI() {
        navigationItem.title = "Feed"
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.fetchPosts), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reusableCellId)
    }
    
    @objc fileprivate func fetchPosts(){
        listOfPosts.removeAll()
        PostService.fetchPosts { [weak self] posts in
            self?.listOfPosts = posts
            self?.collectionView.refreshControl?.endRefreshing()
            self?.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(listOfPosts[indexPath.item])
        cell.actionPostLike = self.actionPostLike
        
        return cell
    }

}

// MARK: - Size of Cell
extension FeedViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height * 0.6 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

// MARK: - ActionPost
extension FeedViewController {
     
    fileprivate func actionPostLike(_ post:Post?) {
        guard let post = post else {return}
        PostService.createPostLike(PostViewModel(post)) { isSucess in
            if isSucess {
                self.collectionView.reloadData()
            }
        }
    }
    
}
