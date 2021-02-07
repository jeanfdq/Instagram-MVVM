//
//  UIViewExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UIView {
    
    // Corner separados-----------------------------------------
    enum Corner:Int {
       case bottomRight = 0,
       topRight,
       bottomLeft,
       topLeft
    }
   
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var cornerMask = UIRectCorner()
        if(corners.contains(.topLeft)){
            cornerMask.insert(.topLeft)
        }
        if(corners.contains(.topRight)){
            cornerMask.insert(.topRight)
        }
        if(corners.contains(.bottomLeft)){
            cornerMask.insert(.bottomLeft)
        }
        if(corners.contains(.bottomRight)){
            cornerMask.insert(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    private func createMask(corners: [Corner]) -> UInt {
       return corners.reduce(0, { (a, b) -> UInt in
           return a + parseCorner(corner: b).rawValue
       })
    }
    private func parseCorner(corner: Corner) -> CACornerMask.Element {
       let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
       return corners[corner.rawValue]
    }
    //--------------------------------------------------------------
    
    func setCorner(radius:CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func setBorder(_ color:UIColor, _ width:CGFloat) {
        layer.borderColor   = color.cgColor
        layer.borderWidth   = width
    }
    
    func setShadow(color:UIColor = .black ,radius: CGFloat, opacity:Float, offSet: CGSize = .init(width: 1, height: 1)){
        layer.shadowColor   = color.cgColor
        layer.shadowRadius  = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset  = offSet
        layer.masksToBounds = false
    }

    func setBackgroudGradient(topColor: UIColor, bottomColor:UIColor){
        
        let gradient = CAGradientLayer()
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0,1]
        gradient.frame = frame
        layer.insertSublayer(gradient, at: 0)
        
    }

    func addSubViews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
    
    func dismissKeyboard(){
        endEditing(true)
    }
    
    func applyViewIntoSuperView(value:UIEdgeInsets = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? NSLayoutXAxisAnchor(), constant: value.left).isActive = true
        topAnchor.constraint(equalTo: superview?.topAnchor ?? NSLayoutYAxisAnchor(), constant: value.top).isActive = true
        trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? NSLayoutXAxisAnchor(), constant: value.right).isActive = true
        bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: value.bottom).isActive = true
        
    }
    
    func applyViewConstraints( leading: NSLayoutXAxisAnchor? = nil,  top:NSLayoutYAxisAnchor? = nil,  trailing:NSLayoutXAxisAnchor? = nil,  bottom:NSLayoutYAxisAnchor? = nil, centerX:NSLayoutXAxisAnchor? = nil, centerY:NSLayoutYAxisAnchor? = nil, size:CGSize = .zero, value:UIEdgeInsets = .zero ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: value.left).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: value.top).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: value.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: value.bottom).isActive = true
        }
        
        if let centerYSuperView = centerY {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
        
        if let centerXSuperView = centerX {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
        
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func applyCenterIntoSuperView(size:CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerYSuperView = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
        
        if let centerXSuperView = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func applyJustSize(size:CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func  addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}
