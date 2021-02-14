//
//  SearchUserCell.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 13/02/21.
//

import SDWebImage

class SearchUserCell: UICollectionViewCell {
    
    var viewModel:SearchUserViewModel? {
        didSet { configureCell() }
    }
    
    let userPhoto:UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.setCorner(radius: 50)
        return photo
    }()
    
    let userName:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubViews(userPhoto, userName)
        userPhoto.applyViewConstraints(top: topAnchor, centerX: centerXAnchor, size: .init(width: 100, height: 100), value: .init(top: 5, left: 0, bottom: 0, right: 0))
        userName.applyViewConstraints(leading: leadingAnchor, top: userPhoto.bottomAnchor, trailing: trailingAnchor, value: .init(top: 6, left: 2, bottom: 0, right: 2))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureCell(){
        guard let viewModel = viewModel else {return}
        
        userPhoto.sd_setImage(with: URL(string: viewModel.photoUrl), completed: nil)
        userName.text = viewModel.userName
    }
    
}
