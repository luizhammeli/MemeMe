//
//  creatememeviewcontroller-imagepicker.swift
//  MemeMe
//
//  Created by Luiz Hammerli on 02/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension CreateMemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController(_ sourceType: UIImagePickerControllerSourceType){
        let pickerView = UIImagePickerController()
        pickerView.delegate = self
        pickerView.sourceType = sourceType
        self.present(pickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            mainImageVIew.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
        enabledButtons(true)
    }
}
