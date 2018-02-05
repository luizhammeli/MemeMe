//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedNotification()
        self.navigationItem.title = "Sent Memes"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIViewController.memesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = self.collectionView?.dequeueReusableCell(withReuseIdentifier: Strings.sentMemeCollectionViewID, for: indexPath) as! SentMemeCollectionViewCell
        cell.meme = UIViewController.memesArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight){
            let landscapeOrientationSize = (self.view.frame.width/5)-4
            return CGSize(width: landscapeOrientationSize, height: landscapeOrientationSize)
        }
        
        let portraitOrientationSize = (self.view.frame.width/3)-2
        return CGSize(width: portraitOrientationSize, height: portraitOrientationSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Strings.showImagePresentationControllerSegue, sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if(segue.identifier == Strings.showImagePresentationControllerSegue){
            showImagePresentationViewController(segue.destination, sender: sender)
        }
    }
    
    @IBAction func addNewMeme(_ sender: Any) {
        showCreateMemeViewController()
    }
    
    func addFeedNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: CreateMemeViewController.updateCollectionViewNotificationName, object: nil)
    }
    
    @objc func updateCollectionView(){
        self.collectionView?.reloadData()
    }
}
