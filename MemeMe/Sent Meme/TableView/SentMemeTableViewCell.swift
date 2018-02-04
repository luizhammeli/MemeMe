//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    var meme: Meme? {
        didSet{
            guard let meme = meme else {return}
            
            memeImageView.image = meme.originalImage
            memeText.text = "\(meme.topText) \(meme.bottomText)"
            topImageLabel.text = meme.topText
            bottomImageLabel.text = meme.bottomText
            
            bottomImageLabel.setUpMemeLabelTextAttributes()
            topImageLabel.setUpMemeLabelTextAttributes()
        }
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    @IBOutlet weak var topImageLabel: UILabel!
    @IBOutlet weak var bottomImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
}
