//
//  UILabelExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UILabel {
    
    func setTitleAttributeswith(firstTitle:String, firstColor:UIColor, sizeFirstFont:CGFloat, isfirsBold:Bool, secondTitle:String, secondColor:UIColor, sizeSecondFont:CGFloat, isSecondBold:Bool){
        
        numberOfLines = 2
        
        let attributeText = NSMutableAttributedString(string: firstTitle, attributes: [NSAttributedString.Key.foregroundColor : firstColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: sizeFirstFont, weight: isfirsBold ? .semibold : .regular)])
        attributeText.append(NSAttributedString(string: secondTitle, attributes: [NSAttributedString.Key.foregroundColor : secondColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: sizeSecondFont, weight: isSecondBold ? .semibold : .regular)]))
        attributedText = attributeText
        
    }
    
}
