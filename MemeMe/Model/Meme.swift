//
//  Meme.swift
//  MemeMe
//
//  Created by Luiz Hammerli on 02/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage                
    }
}
