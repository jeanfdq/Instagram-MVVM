//
//  FeedCell.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    let profilePhotoPost:UIImageView = {
        let photo = UIImageView(image: UIImage(named: "venom-7"))
        photo.backgroundColor = .gray
        photo.setCorner(radius: 15)
        photo.applyJustSize(size: .init(width: 30, height: 30))
        return photo
    }()
    
    let profileNamePost:UILabel = {
        let profileName = UILabel()
        profileName.text = "Teste de Nome"
        profileName.textAlignment = .left
        profileName.textColor = .black
        profileName.font = .systemFont(ofSize: 12, weight: .bold)
        return profileName
    }()
    
    let actionMorePost:UILabel = {
        let actionMore = UILabel(frame: .init(x: 0, y: 0, width: 60, height: 60))
        actionMore.text = "..."
        actionMore.textAlignment = .right
        actionMore.textColor = .black
        actionMore.font = .systemFont(ofSize: 20, weight: .bold)
        actionMore.applyJustSize(size: .init(width: 40, height: 40))
        return actionMore
    }()
    
    lazy var postHeader:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profilePhotoPost, profileNamePost, actionMorePost])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let photoPost:UIImageView = {
        let photo = UIImageView(image: UIImage(named: "venom-7"))
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    fileprivate let sizeIconsPost:CGFloat = 25
    
    lazy var likePost:UIImageView = {
        let like = UIImageView(image: UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return like
    }()
    
    lazy var commentPost:UIImageView = {
        let comment = UIImageView(image: UIImage(systemName: "bubble.left", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return comment
    }()
    
    lazy var sendPost:UIImageView = {
        let send = UIImageView(image: UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return send
    }()
    
    lazy var savePost:UIImageView = {
        let save = UIImageView(image: UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return save
    }()
    
    lazy var postBottom:UIView = {
       let container = UIView()
        container.addSubViews(likePost, commentPost, sendPost, savePost)
        
        likePost.applyViewConstraints(leading: container.leadingAnchor, centerY: container.centerYAnchor, size: .init(width: sizeIconsPost, height: sizeIconsPost), value: .init(top: 0, left: 8, bottom: 0, right: 0))
        commentPost.applyViewConstraints(leading: likePost.trailingAnchor, centerY: container.centerYAnchor, size: .init(width: sizeIconsPost, height: sizeIconsPost), value: .init(top: 0, left: 8, bottom: 0, right: 0))
        sendPost.applyViewConstraints(leading: commentPost.trailingAnchor, centerY: container.centerYAnchor, size: .init(width: sizeIconsPost, height: sizeIconsPost), value: .init(top: 0, left: 8, bottom: 0, right: 0))
        savePost.applyViewConstraints(trailing: container.trailingAnchor, centerY: container.centerYAnchor, size: .init(width: sizeIconsPost, height: sizeIconsPost), value: .init(top: 0, left: 0, bottom: 0, right: 8))
        
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubViews(postHeader, photoPost, postBottom)
        postHeader.applyViewConstraints(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, size: .zero, value: .init(top: 5, left: 10, bottom: 0, right: 10))
        photoPost.applyViewConstraints(leading: leadingAnchor, top: postHeader.bottomAnchor, trailing: trailingAnchor, bottom: postBottom.topAnchor, value: .init(top: 10, left: 0, bottom: 0, right: 0))
        postBottom.applyViewConstraints(leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, size: .init(width: 0, height: 32), value: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
