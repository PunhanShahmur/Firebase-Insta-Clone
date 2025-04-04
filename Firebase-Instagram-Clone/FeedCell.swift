//
//  FeedCell.swift
//  Firebase-Instagram-Clone
//
//  Created by Punhan Shahmurov on 05.04.25.
//

import UIKit
import FirebaseFirestore

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        
        let firestoreDB = Firestore.firestore()
        
        if let likeCount = Int(self.likeCount.text!) {
            
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            
            firestoreDB.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
            
        }
        
            
        
    }
    
}
