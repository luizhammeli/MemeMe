//
//  MemeImagePresentationViewController.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class MemeImagePresentationViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpImage(){
        guard let meme = meme else{return}
        memeImageView.image = meme.memedImage
    }
}
