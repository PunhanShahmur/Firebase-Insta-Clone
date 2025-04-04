//
//  UploadViewController.swift
//  Firebase-Instagram-Clone
//
//  Created by Punhan Shahmurov on 01.04.25.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UITextField!
    @IBOutlet weak var uploadLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    
    @IBAction func uploadData(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.1) {
            
            let uuidString = UUID().uuidString
            
            let fileReference = mediaFolder.child("image-\(uuidString).jpg")
            
            fileReference.putData(data, metadata: nil) { (metadata, error) in
                
               if error != nil {
                   
                   let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                   let okButton = UIAlertAction(title: "OK", style: .default)
                   alertController.addAction(okButton)
                   self.present(alertController, animated: true)
                   print(error?.localizedDescription ?? "Error")
                   
               } else {
                   
                   fileReference.downloadURL { (url, error) in
                       
                       if error == nil {
                       
                           let imageURLString = url?.absoluteString
                           
                           let firestoreDatabase = Firestore.firestore()
                           let firestorePost = ["imageURL": imageURLString!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.contentLabel.text ?? "", "date": FieldValue.serverTimestamp(), "likes": 0] as [String : Any]
                           
                           firestoreDatabase.collection("Posts").addDocument(data: firestorePost) { (error) in
                               
                               if error != nil {
                                   
                                   print(error?.localizedDescription ?? "Error")
                                    
                               } else {
                                   
                                   self.imageView.image = UIImage(named: "upload.png")
                                   self.contentLabel.text = ""
                                   
                                   self.tabBarController?.selectedIndex = 0
                                   
                               }
                           }
                           
                           
                           
                           
                           
                           
                       } else {
                           
                           print(error?.localizedDescription ?? "Error")
                           
                       }
                       
                   }
                   
               }
            }
            
        }
        
        
        
    }
    

}
