//
//  CommentPostViewCell.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 26/02/21.
//

import SDWebImage

class CommentPostViewCell: UICollectionViewCell {
    
    var viewModel:PostCommentViewModel? {
        didSet{ configure()}
    }
    
    fileprivate let profileImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.setCorner(radius: 20)
        image.clipsToBounds = true
        return image
    }()
    
    fileprivate let postUser:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    fileprivate let postComment:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubViews(profileImage, postUser, postComment)
        profileImage.applyViewConstraints(leading: leadingAnchor, centerY: centerYAnchor, size: .init(width: 40, height: 40), value: .init(top: 0, left: 10, bottom: 0, right: 0))
        postUser.applyViewConstraints(leading: profileImage.trailingAnchor, centerY: profileImage.centerYAnchor, size: .zero, value: .init(top: 0, left: 8, bottom: 0, right: 0))
        postComment.applyViewConstraints(leading: postUser.trailingAnchor, centerY: profileImage.centerYAnchor, size: .zero, value: .init(top: 0, left: 5, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    
    fileprivate func configure() {
        guard let viewModel = viewModel else {return}
        
        profileImage.sd_setImage(with: viewModel.userProfileUrl)
        postUser.text = viewModel.userName
        postComment.text = viewModel.userComment
    }
    
}
