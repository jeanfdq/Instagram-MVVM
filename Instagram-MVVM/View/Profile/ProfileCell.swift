//
//  ProfileCell.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import SDWebImage

class ProfileCell: UICollectionViewCell {
    
    var postViewModel:PostViewModel? {
        didSet { configure() }
    }
    
   fileprivate let postImage:UIImageView = {
        let post = UIImageView()
        post.contentMode = .scaleAspectFill
        post.clipsToBounds = true
        return post
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(postImage)
        postImage.applyViewIntoSuperView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure() {
        guard let postViewModel = postViewModel else {return}
        postImage.sd_setImage(with: postViewModel.imageUrl)
    }
    
}
