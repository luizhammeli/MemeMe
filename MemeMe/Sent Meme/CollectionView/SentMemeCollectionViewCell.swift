//
//  SentMemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topImageLabel: UILabel!
    @IBOutlet weak var bottomImageLabel: UILabel!
    
    var meme: Meme?{
        didSet{
            guard let meme = meme else{return}
            memeImageView.image = meme.originalImage
            topImageLabel.text = meme.topText
            bottomImageLabel.text = meme.bottomText            
            topImageLabel.setUpMemeLabelTextAttributes()
            bottomImageLabel.setUpMemeLabelTextAttributes()
        }
    }
}
