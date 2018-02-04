//
//  CreateMemeViewController.swift
//  MemeMe
//
//  Created by Luiz Hammerli on 01/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController{

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var mainImageVIew: UIImageView!
    
    let createMemeTextFieldDelegate = CreateMemeTextFieldDelegate()
    var memedImage: UIImage?
    
    static let updateTableViewNotificationName =  NSNotification.Name(rawValue: "updateTableView")
    static let updateCollectionViewNotificationName =  NSNotification.Name(rawValue: "updateCollectionView")
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func handleActionButton(_ sender: Any) {
        memedImage = generateMemedImage()
        let actViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        actViewController.popoverPresentationController?.sourceView = self.view
        actViewController.completionWithItemsHandler = {(activity, success, items, error) in
            if(success){
                if let meme = self.saveMeme(){
                    UIViewController.memesArray.append(meme)
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: CreateMemeViewController.updateTableViewNotificationName, object: nil)
                    NotificationCenter.default.post(name: CreateMemeViewController.updateCollectionViewNotificationName, object: nil)
                }
            }
        }
        
        self.present(actViewController, animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        showImagePickerController(.camera)
    }
    
    @IBAction func handleAlbumButton(_ sender: Any) {
        showImagePickerController(.photoLibrary)
    }
    
    func setUpViews(){
        topTextField.setUpMemeTextAttributes(delegate: createMemeTextFieldDelegate)
        bottomTextField.setUpMemeTextAttributes(delegate: createMemeTextFieldDelegate)
        enabledButtons(false)
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if(bottomTextField.isFirstResponder){
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func generateMemedImage() -> UIImage {
        showToolBars(true)
        self.view.backgroundColor = .white
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor.darkGray
        showToolBars(false)
        
        return memedImage
    }
    
    func showToolBars(_ willHide: Bool){
        bottomToolbar.isHidden = willHide
        topToolBar.isHidden = willHide
    }
    
    func enabledButtons(_ willHide: Bool){
        cancelButton.isEnabled = true        
        actionButton.isEnabled = willHide
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func saveMeme() -> Meme?{
        guard let memedImage = memedImage, let topText =  topTextField.text, let bottomText = bottomTextField.text, let originalImage = mainImageVIew.image else{return nil}
        return Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
    }
    
    func setTextFieldToDefaultState(){
        topTextField.text = Strings.topTextFieldDefaultText
        bottomTextField.text = Strings.bottomTextFieldDefaultText
    }
}
