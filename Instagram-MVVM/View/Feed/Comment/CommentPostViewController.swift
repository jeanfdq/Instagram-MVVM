//
//  CommentPostViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 23/02/21.
//

import UIKit

class CommentPostViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let reuseIdentifierCell = "cellComment"
    
    var listComments = [PostComment]()
    
    var post:Post
    
    fileprivate lazy var commentInputView:CommentInputAcessoryView = {
        let inputView = CommentInputAcessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        inputView.addComment = self.addComment
        return inputView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchComments()
    }
    
    init(collectionViewLayout layout: UICollectionViewLayout, _ post:Post) {
        self.post = post
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputAccessoryView: UIView? {
        return commentInputView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - functions
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(CommentPostViewCell.self, forCellWithReuseIdentifier: reuseIdentifierCell)
    }
    
    fileprivate func fetchComments() {
        listComments.removeAll()
        PostService.fetchComments(post.uuid) { list in
            self.listComments = list
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func addComment(_ comment:String) {
        let progress = self.showLoading()
        
        guard let tab = self.tabBarController as? MainViewController else {return}
        guard let user = tab.user else {return}
        
        PostService.addComment(post, user, comment) { isSuccess in
            if isSuccess {
                self.fetchComments()
            } else {
                self.showLoafError(message: "Algo deu errado!")
            }
            progress.dismiss()
        }
        
    }
    
    // MARK: - CollectionView Event
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listComments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as! CommentPostViewCell
            
        cell.viewModel = PostCommentViewModel(listComments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uuid = listComments[indexPath.item].userId
        UserService.fetchUser(uuid) { result in
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
