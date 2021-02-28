//
//  MaintenanceViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import UIKit

class MaintenanceViewController: UIViewController {

    private let maintenanceIcon:UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "waveform.path.ecg")?.withRenderingMode(.alwaysOriginal).withTintColor(.white))
        return icon
    }()
    
    let maintenanceMsg:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        view.addSubViews(maintenanceIcon, maintenanceMsg)
        let size:CGFloat = view.frame.width * 0.6
        maintenanceIcon.applyCenterIntoSuperView(size: .init(width: size, height: size))
        maintenanceMsg.applyViewConstraints( top: maintenanceIcon.bottomAnchor, centerX: view.centerXAnchor, size: .zero, value: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
