//
//  JailbreakViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import UIKit

class JailbreakViewController: UIViewController {

    let exclamationIcon:UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "exclamationmark.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.white))
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        view.addSubview(exclamationIcon)
        let size:CGFloat = view.frame.width * 0.6
        exclamationIcon.applyCenterIntoSuperView(size: .init(width: size, height: size))
    }

}
