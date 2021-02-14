//
//  ProfileHeaderView.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import SDWebImage
import Loaf

class ProfileHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel:ProfileHeaderViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            configureProfile(viewModel)
        }
    }
    
    let profileImage:UIImageView = {
        let profile = UIImageView()
        profile.contentMode = .scaleAspectFill
        profile.setCorner(radius: 40)
        return profile
    }()
    
    let fullNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let quantityPosts:UILabel = {
        let posts = UILabel()
        posts.textAlignment = .center
        posts.setTitleAttributeswith(firstTitle: "0\n", firstColor: .black, sizeFirstFont: 14, isfirsBold: true, secondTitle: "Posts", secondColor: .darkGray, sizeSecondFont: 14, isSecondBold: false)
        return posts
    }()
    
    let quantityFollowers:UILabel = {
        let followers = UILabel()
        followers.textAlignment = .center
        return followers
    }()
    
    lazy var quantityFollowing:UILabel = {
        let following = UILabel()
        following.textAlignment = .center
        return following
    }()
    
    lazy var containerQuantities:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [quantityPosts, quantityFollowers, quantityFollowing])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    lazy var editPofileBtn:UIButton = {
        let btn = UIButton()
        btn.setBorder(.darkGray, 0.4)
        btn.setCorner(radius: 5)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        return btn
    }()
    
    let separatorLine:UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    
    var actionEditProfile:(()->Void)?
    var actionFollowProfile:(()->Void)?
    var actionUnfollowProfile:(()->Void)?
    
    // MARK: - LifeCycle
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getQuantitiesHeader), name: .NCD_UserQtdHeaderProfile, object: nil)
        
        addSubViews(profileImage, fullNameLabel, containerQuantities, editPofileBtn, separatorLine)
        profileImage.applyViewConstraints(leading: leadingAnchor, top: topAnchor, size: .init(width: 80, height: 80), value: .init(top: 10, left: 10, bottom: 0, right: 0))
        fullNameLabel.applyViewConstraints(leading: profileImage.leadingAnchor, top: profileImage.bottomAnchor, trailing: trailingAnchor, value: .init(top: 10, left: 0, bottom: 0, right: 5))
        containerQuantities.applyViewConstraints(leading: profileImage.trailingAnchor, trailing: trailingAnchor, centerY: profileImage.centerYAnchor, size: .zero, value: .init(top: 0, left: 15, bottom: 0, right: 30))
        editPofileBtn.applyViewConstraints( top: fullNameLabel.bottomAnchor, centerX: centerXAnchor, size: .init(width: frame.width * 0.9, height: 30), value: .init(top: 12, left: 0, bottom: 0, right: 0))
        separatorLine.applyViewConstraints( top: editPofileBtn.bottomAnchor, centerX: centerXAnchor, size: .init(width: frame.width * 0.95, height: 0.3), value: .init(top: 15, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    
    fileprivate func configureProfile(_ viewModel: ProfileHeaderViewModel) {
        editPofileBtn.setTitle(viewModel.profileBtnTitle, for: .normal)
        editPofileBtn.setTitleColor(viewModel.profileBtnTextColor, for: .normal)
        editPofileBtn.backgroundColor = viewModel.profileBtnBackground
        editPofileBtn.addTapGesture { [unowned self] in
            if viewModel.isCurrentUser {
                self.actionEditProfile?()
            } else if viewModel.isFollowed {
                self.actionUnfollowProfile?()
            } else {
                self.actionFollowProfile?()
            }
            
        }
        
        profileImage.sd_setImage(with: URL(string: viewModel.profileImage))
        fullNameLabel.text = viewModel.fullName
        
    }
    
    @objc fileprivate func getQuantitiesHeader(){
        
        if let userId = viewModel?.userId {
            
            viewModel?.fetchFollowing(userId, completion: { listOfFollowing in
                self.setQuantitiesFollowingLabel(listOfFollowing.count)
            })
            
            viewModel?.fetchFollowers(userId, completion: { listOfFollowers in
                self.setQuantitiesFollowersLabel(listOfFollowers.count)
            })
            
        }
    
    }
    
    fileprivate func setQuantitiesFollowingLabel(_ qtd:Int){
        quantityFollowing.setTitleAttributeswith(firstTitle: "\(qtd)\n", firstColor: .black, sizeFirstFont: 14, isfirsBold: true, secondTitle: "Following", secondColor: .darkGray, sizeSecondFont: 14, isSecondBold: false)
    }
    
    fileprivate func setQuantitiesFollowersLabel(_ qtd:Int){
        quantityFollowers.setTitleAttributeswith(firstTitle: "\(qtd)\n", firstColor: .black, sizeFirstFont: 14, isfirsBold: true, secondTitle: "Followers", secondColor: .darkGray, sizeSecondFont: 14, isSecondBold: false)
    }
    
}
