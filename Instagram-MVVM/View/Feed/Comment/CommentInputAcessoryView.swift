//
//  CommentInputAcessoryView.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 26/02/21.
//

import UIKit

class CommentInputAcessoryView: UIView {

    let commentTextView:InputTextView = {
        let comment = InputTextView()
        comment.placeHolderText = "Enter comment..."
        comment.font = .systemFont(ofSize: 16, weight: .semibold)
        comment.isScrollEnabled = false
        return comment
    }()
    
    lazy var postButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Post", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.addTapGesture { [weak self] in
            guard let comment = self?.commentTextView.text, !comment.isEmpty else { return}
            self?.addComment?(comment)
        }
        return btn
    }()
    
    let line:UIView = {
        let line = UIView()
        line.backgroundColor = .init(white: 0.6, alpha: 0.4)
        return line
    }()
    
    var addComment: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubViews(line, commentTextView, postButton)
        line.applyViewConstraints(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0.5), value: .zero)
        commentTextView.applyViewConstraints(leading: leadingAnchor, top: line.bottomAnchor, trailing: postButton.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,  size: .zero, value: .init(top: 8, left: 8, bottom: 8, right: 2))
        postButton.applyViewConstraints( top: line.bottomAnchor, trailing: trailingAnchor, size: .init(width: 50, height: 50), value: .init(top: 0, left: 0, bottom: 0, right: 8))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
}
