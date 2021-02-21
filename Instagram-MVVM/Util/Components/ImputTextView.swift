//
//  ImputTextView.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 21/02/21.
//

import UIKit

class ImputTextView: UITextView {
    
    // MARK: - Properties
    
    var placeHolderText:String = "" {
        didSet { placeHolder.text = placeHolderText }
    }
    
    fileprivate let placeHolder:UILabel = {
        let placeholder = UILabel()
        placeholder.textColor = .lightGray
        return placeholder
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        addSubview(placeHolder)
        placeHolder.applyViewConstraints(leading: leadingAnchor, centerY: centerYAnchor, size: .zero, value: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc fileprivate func handleTextDidChange() {
        placeHolder.isHidden = !text.isEmpty
    }

}
