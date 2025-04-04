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
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray: [String] = []
    var postImageArray: [String] = []
    var commentArray: [String] = []
    var likeArray: [Int] = []
    var documentIdArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
         
        
        getDataFromFirestore()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userEmailArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeCount.text = "\(likeArray[indexPath.row])"
        cell.userImageView.sd_setImage(with: URL(string: postImageArray[indexPath.row]))
        
        return cell
        
        
    }
    
    func getDataFromFirestore(){
        
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil{
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.postImageArray.removeAll(keepingCapacity: false)
                    
                    
                    
                    for document in snapshot!.documents {
                        
                        
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String {
                            self.commentArray.append(postComment)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        
                        if let postImageURLString = document.get("imageURL") as? String {
                            self.postImageArray.append(postImageURLString)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
        
    }

}
