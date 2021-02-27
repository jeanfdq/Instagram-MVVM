//
//  NotificationsCell.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import SDWebImage

class NotificationsCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel:PostNotificationViewModel? {
        didSet{ configure() }
    }
    
    lazy var userProfileImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setCorner(radius: 20)
        image.isUserInteractionEnabled = true
        image.addTapGesture { [weak self] in
            self?.tappedUser?()
        }
        return image
    }()
    
    let typeLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let notificationTime:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 9, weight: .regular)
        return label
    }()
    
    let postImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setCorner(radius: 5)
        return image
    }()
    
    var tappedUser:(()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews(userProfileImage, typeLabel, notificationTime, postImage)
        
        userProfileImage.applyViewConstraints(leading: leadingAnchor, centerY: centerYAnchor, size: .init(width: 40, height: 40), value: .init(top: 0, left: 8, bottom: 0, right: 0))
        typeLabel.applyViewConstraints(leading: userProfileImage.trailingAnchor, centerY: centerYAnchor, size: .zero, value: .init(top: 0, left: 8, bottom: 0, right: 0))
        notificationTime.applyViewConstraints(leading: typeLabel.trailingAnchor, centerY: centerYAnchor, size: .zero, value: .init(top: 0, left: 8, bottom: 0, right: 0))
        postImage.applyViewConstraints( trailing: trailingAnchor, centerY: centerYAnchor, size: .init(width: 44, height: 44), value: .init(top: 0, left: 0, bottom: 0, right: 8))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure(){
        guard let viewModel = viewModel else {return}
        userProfileImage.sd_setImage(with: viewModel.userProfileUrl)
        typeLabel.setTitleAttributeswith(firstTitle: viewModel.userName, firstColor: .black, sizeFirstFont: 13, isfirsBold: true, secondTitle: viewModel.typeNotification, secondColor: .gray, sizeSecondFont: 13, isSecondBold: false)
        notificationTime.text = viewModel.notificationDateDescription.trim()
        postImage.sd_setImage(with: viewModel.postImageUrl)
    }
    
}
