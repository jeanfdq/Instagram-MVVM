//
//  PickerView.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

protocol getPhotoFromPickerViewProtocol {
    func getPhoto(_ imagePickerView:UIImage)
}

class PickerView: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pickerViewDelegate:getPhotoFromPickerViewProtocol?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        pickerViewDelegate?.getPhoto(image)
        
        picker.dismiss(animated: true, completion: nil)
    }

}
