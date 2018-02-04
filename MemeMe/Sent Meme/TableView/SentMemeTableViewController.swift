//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Mac on 03/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedNotification()
        self.tableView.tableFooterView = UIView()
        self.navigationItem.title = "Sent Memes"        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIViewController.memesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Strings.sentMemeTableViewCellID, for: indexPath) as! SentMemeTableViewCell
        cell.meme = UIViewController.memesArray[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Strings.showImagePresentationControllerSegue, sender: indexPath.item)
    }
    
    @IBAction func addNewMeme() {
        showCreateMemeViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Strings.showImagePresentationControllerSegue){
            showImagePresentationViewController(segue.destination, sender: sender)
        }
    }
    
    func addFeedNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: CreateMemeViewController.updateTableViewNotificationName, object: nil)
    }
    
    @objc func updateTableView(){
        self.tableView.reloadData()
    }
}
