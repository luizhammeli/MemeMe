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
                self.saveMeme()
            }
        }
        
        self.present(actViewController, animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        mainImageVIew.image = nil
        enabledButtons(false)
        setTextFieldToDefaultState()
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        showImagePickerController(.camera)
    }
    
    @IBAction func handleAlbumButton(_ sender: Any) {
        showImagePickerController(.photoLibrary)
    }
    
    func setUpViews(){
        configureTextField(topTextField)
        configureTextField(bottomTextField)
        enabledButtons(false)
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if(bottomTextField.isFirstResponder){
            self.view.frame = CGRect(x: 0, y: -getKeyboardHeight(notification), width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(){
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func generateMemedImage() -> UIImage {
        showToolBars(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showToolBars(false)
        
        return memedImage
    }
    
    func showToolBars(_ willHide: Bool){
        bottomToolbar.isHidden = willHide
        topToolBar.isHidden = willHide
    }
    
    func enabledButtons(_ willHide: Bool){
        cancelButton.isEnabled = willHide
        actionButton.isEnabled = willHide
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func saveMeme() {
        guard let memedImage = memedImage, let topText =  topTextField.text, let bottomText = bottomTextField.text, let originalImage = mainImageVIew.image else{return}
        
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
    }
    
    func setTextFieldToDefaultState(){
        topTextField.text = Strings.topTextFieldDefaultText
        bottomTextField.text = Strings.bottomTextFieldDefaultText
    }
    
    func configureTextField(_ textField: UITextField) {
        textField.delegate = createMemeTextFieldDelegate
        
        let atrbuttedString: [String: Any] = [NSAttributedStringKey.strokeColor.rawValue: UIColor.black, NSAttributedStringKey.foregroundColor.rawValue: UIColor.white, NSAttributedStringKey.font.rawValue: UIFont(name: Strings.memeTextFontName, size: 40)!, NSAttributedStringKey.strokeWidth.rawValue: -4.5]
        
        textField.defaultTextAttributes = atrbuttedString
        textField.textAlignment = .center
    }
}
