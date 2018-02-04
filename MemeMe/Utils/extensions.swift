//
//  extensions.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension UIViewController{
    static var memesArray = [Meme]()
    
    func showCreateMemeViewController() {
        let createMemeViewController = self.storyboard?.instantiateViewController(withIdentifier: Strings.CreateMemeViewControlerStoryboardID) as! CreateMemeViewController
        self.present(createMemeViewController, animated: true, completion: nil)
    }
    
    func showImagePresentationViewController(_ viewController: UIViewController, sender: Any?) {
        guard let itemIndex = sender as? Int else {return}
        let memeImagePresentationView = viewController as! MemeImagePresentationViewController
        memeImagePresentationView.meme = UIViewController.memesArray[itemIndex]
    }
}

extension UITextField{
    
    func setUpMemeTextAttributes(delegate: UITextFieldDelegate){
        self.delegate = delegate
        
        let atrbuttedString: [String: Any] = [NSAttributedStringKey.strokeColor.rawValue: UIColor.black, NSAttributedStringKey.foregroundColor.rawValue: UIColor.white, NSAttributedStringKey.font.rawValue: UIFont(name: Strings.memeTextFontName, size: 40)!, NSAttributedStringKey.strokeWidth.rawValue: -4.5]
        
        self.defaultTextAttributes = atrbuttedString
        self.textAlignment = .center
    }
}

extension UILabel{
    
    func setUpMemeLabelTextAttributes(){
        guard let text = text else {return}
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedStringKey(rawValue: NSAttributedStringKey.strokeColor.rawValue): UIColor.black, NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: Strings.memeTextFontName, size: 14)!, NSAttributedStringKey(rawValue: NSAttributedStringKey.strokeWidth.rawValue): -4.5])
        
        self.attributedText = attributedString
    }
}
