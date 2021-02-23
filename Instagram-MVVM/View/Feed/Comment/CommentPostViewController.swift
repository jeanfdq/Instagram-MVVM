//
//  CommentPostViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 23/02/21.
//

import UIKit

class CommentPostViewController: UICollectionViewController {

    // MARK: - Properties
    
    var post:Post
    
    // MARK: - LifeCycle
    
    init(collectionViewLayout layout: UICollectionViewLayout, _ post:Post) {
        self.post = post
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .darkGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

}
