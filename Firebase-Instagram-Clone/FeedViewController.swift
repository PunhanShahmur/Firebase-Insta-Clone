//
//  FeedViewController.swift
//  Firebase-Instagram-Clone
//
//  Created by Punhan Shahmurov on 01.04.25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
         
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = Auth.auth().currentUser?.email
        cell.userImageView.image = UIImage(named: "upload.png")
        cell.commentLabel.text = "\(indexPath.row)"
        cell.likeCount.text = "0"
        
        return cell
        
        
    }
    
    func getDataFromFirestore(){
        
        let firestoreDB = Firestore.firestore()
        
        
    }

}
