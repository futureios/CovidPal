//
//  ProfileVC.swift
//  CovidPal
//
//  Created by Mac OS on 8/23/20.
//  Copyright © 2020 Mac OS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseDatabase
import FirebaseAuth

class ProfileVC: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    
    let userImageView = SVUploader(useBlur: true, useShadow: false, useSmoothAnimation: true)
    let fakeImageView = UIImageView()
    let addImageButton = UIButton()

    let nameLabel = UILabel()
    let emailLabel = UILabel()

    
    let switchButton = UISwitch()

    let loginOutButton = UIButton()
    
    
    
    let backBoxesColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .dark: return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        default: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    let boxesShadowColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case .dark: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        default: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    let textOneColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        default: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    let imageOneColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .dark: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    let textTwoColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case .dark: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        default: return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        storageRef = Storage.storage().reference()

        self.view.backgroundColor = UIColor.systemGray6
        
        topBoxViewInit()
        
        middleBoxViewInit()
        
        bottomBoxViewInit()
        
        userLoginDetect()
    }
    
    func topBoxViewInit() {
        let topBoxView = UIView()
        topBoxView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height*0.31)
        topBoxView.backgroundColor = backBoxesColor
        topBoxView.layer.cornerRadius = 15
        topBoxView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topBoxView.layer.shadowColor = boxesShadowColor.cgColor
        topBoxView.layer.shadowOffset = CGSize(width: 0, height: 1.8)
        topBoxView.layer.shadowOpacity = 1
        topBoxView.layer.shadowRadius = 0
        
        userImageView.frame = CGRect(x: ((screenSize.width/2)-((screenSize.height*0.15)/2)), y: statusBarHeight+12, width: screenSize.height*0.15, height: screenSize.height*0.15)
        userImageView.image = #imageLiteral(resourceName: "user-filled")
        userImageView.lineWidth = 4
        userImageView.layer.cornerRadius = (screenSize.height*0.15)/2
        userImageView.layer.masksToBounds = true
        
        nameLabel.frame = CGRect(x: 0, y: ((screenSize.height*0.15)+20+statusBarHeight), width: screenSize.width, height: 30)
        nameLabel.text = "FullName"
        nameLabel.textColor = textOneColor
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        emailLabel.frame = CGRect(x: 0, y: ((screenSize.height*0.15)+52+statusBarHeight), width: screenSize.width, height: 20)
        emailLabel.text = "Email"
        emailLabel.textColor = textTwoColor
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 15)
        
        addImageButton.frame = CGRect(x: ((screenSize.width/2)+((screenSize.height*0.15)/6)), y: statusBarHeight+12+((screenSize.height*0.15)/1.5), width: 32, height: 32)
        addImageButton.layer.cornerRadius = 16
        addImageButton.backgroundColor = #colorLiteral(red: 0.9524168372, green: 0.3666017056, blue: 0.03203120828, alpha: 0.9993896484)
        addImageButton.setImage(#imageLiteral(resourceName: "add-camera").withRenderingMode(.alwaysTemplate), for: .normal)
        addImageButton.tintColor = imageOneColor
        addImageButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        self.view.addSubview(topBoxView)
        topBoxView.addSubview(userImageView)
        topBoxView.addSubview(addImageButton)
        topBoxView.addSubview(nameLabel)
        topBoxView.addSubview(emailLabel)
    }

    
    func middleBoxViewInit() {
        let middleBoxView = UIView()
        middleBoxView.frame = CGRect(x: (screenSize.width-(screenSize.width*0.8))/2, y: screenSize.height*0.4, width: screenSize.width*0.8, height: 60)
        middleBoxView.backgroundColor = backBoxesColor
        middleBoxView.layer.cornerRadius = 15
        middleBoxView.layer.shadowColor = boxesShadowColor.cgColor
        middleBoxView.layer.shadowOffset = CGSize(width: 0, height: 1.8)
        middleBoxView.layer.shadowOpacity = 1
        middleBoxView.layer.shadowRadius = 0
        
        let darkModeLabel = UILabel()
        darkModeLabel.frame = CGRect(x: 20, y: 10, width: screenSize.width*0.4, height: 40)
        darkModeLabel.text = "Dark Mode"
        darkModeLabel.textColor = textOneColor
        darkModeLabel.textAlignment = .left
        darkModeLabel.font = UIFont.systemFont(ofSize: 14)
        
        switchButton.frame = CGRect(x: screenSize.width*0.62, y: 15, width: 0, height: 0)
        switchButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchButton.addTarget(self, action: #selector(buttonClicked), for: .valueChanged)
        
        self.view.addSubview(middleBoxView)
        middleBoxView.addSubview(darkModeLabel)
        middleBoxView.addSubview(switchButton)
    }
    
    func bottomBoxViewInit() {
        loginOutButton.frame = CGRect(x: (screenSize.width-(screenSize.width*0.4))/2, y: screenSize.height*0.70, width: screenSize.width*0.4, height: 45)
        loginOutButton.backgroundColor = backBoxesColor
        loginOutButton.layer.cornerRadius = 15
        loginOutButton.layer.shadowColor = boxesShadowColor.cgColor
        loginOutButton.layer.shadowOffset = CGSize(width: 0, height: 1.8)
        loginOutButton.layer.shadowOpacity = 1
        loginOutButton.layer.shadowRadius = 0
        loginOutButton.setTitle("Login", for: .normal)
        loginOutButton.setTitleColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), for: .normal)
        loginOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginOutButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        self.view.addSubview(loginOutButton)
    }
    
    func userLoginDetect() {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            //let userID = Auth.auth().currentUser?.uid
            loginOutButton.setTitle("Sign Out", for: .normal)
            loginOutButton.setTitleColor(#colorLiteral(red: 0.7814617753, green: 0.1612306237, blue: 0.08109200746, alpha: 0.8), for: .normal)
//            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
//                guard let dict = snapshot.value as? [String:Any] else {
//                    print("Error")
//                    return
//                }
//                let username = dict["username"] as? String
//                self.nameLabel.text = username
//                self.emailLabel.text = user?.email
//            })
            self.nameLabel.text = user?.displayName
            self.emailLabel.text = user?.email
            addImageButton.isHidden = false
            if user?.photoURL == nil {
                userImageView.image = #imageLiteral(resourceName: "user-filled")
            } else {
                if isImageStored(forKey: "covidPalProfileImage")! {
                    if let img = retrieveImage(forKey: "covidPalProfileImage") {
                        DispatchQueue.main.async {
                            self.userImageView.image = img
                        }
                    }
                } else {
                    newDownloadImage()
                }
            }
        } else {
            loginOutButton.setTitle("Login", for: .normal)
            loginOutButton.setTitleColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), for: .normal)
            addImageButton.isHidden = true
            nameLabel.text = "FullName"
            emailLabel.text = "Email"
            userImageView.image = #imageLiteral(resourceName: "user-filled")
        }
    }
    
    
    @objc func buttonClicked(_ sender: AnyObject?) {
      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

      if sender === switchButton {
        if switchButton.isOn == true {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        
      } else if sender === loginOutButton {
        
        if loginOutButton.titleLabel?.text == "Login" {
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated:false, completion:nil)
        } else {
            //let userID = Auth.auth().currentUser?.uid
            do {
              try Auth.auth().signOut()
              UserDefaults.standard.set("", forKey: "covidPalProfileImage")
              //self.ref.child("users").child(userID!).removeValue()
              userLoginDetect()
            } catch (let error) {
              print("Auth sign out failed: \(error)")
            }
            
        }
        
      } else if sender === addImageButton {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            pickerController.delegate = self
            self.present(pickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            let cameraPickerController = UIImagePickerController()
            cameraPickerController.sourceType = .camera
            cameraPickerController.allowsEditing = true
            cameraPickerController.delegate = self
            self.present(cameraPickerController, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
      }

    }
    
    private func store(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do  {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        }
    }
    
    private func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            return image
        }
        return nil
    }
    
    private func isImageStored(forKey key: String) -> Bool? {
        let filePath = self.filePath(forKey: key)
        if FileManager.default.fileExists(atPath: filePath!.path) {
            return true
        }
        return false
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let path = (info[UIImagePickerController.InfoKey.imageURL] as? NSURL)!
        uploadImage(localImageURL: path, image: image!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(localImageURL: NSURL, image: UIImage){
        self.userImageView.image = image
        self.userImageView.startUpload()
        self.userImageView.progress = 0.02
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        let userID = Auth.auth().currentUser?.uid
        let localFile = localImageURL as URL
        let imageRef = storageRef.child("Photos/IMG_\(userID!).jpg")
        self.userImageView.progress = 0.08
        _ = imageRef.putFile(from: localFile, metadata: nil) { metadata, error in
            self.userImageView.progress = 0.45
            imageRef.downloadURL { (url, error) in
                self.userImageView.progress = 0.75
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                changeRequest?.photoURL = downloadURL
                let uid = Auth.auth().currentUser?.uid
                self.ref.child("Users").child(uid!).child("ProfilePicUrl").setValue(downloadURL.absoluteString)
                changeRequest?.commitChanges() { (error) in
                    self.downloadImage(img: image)
                }
            }
        }
    }
    
    func downloadImage(img: UIImage) {
        DispatchQueue.global(qos: .background).async {
            self.store(image: img, forKey: "covidPalProfileImage")
        }
        self.userImageView.progress = 0.85
        let photoUrl = Auth.auth().currentUser?.photoURL
        //let imageRef = storageRef.child("Photos/IMG_\(userID!).jpg")
        self.fakeImageView.sd_setImage(with: photoUrl, placeholderImage: #imageLiteral(resourceName: "user-filled"), options: [],completed: { (image, error,cacheType, url) in
            self.userImageView.image = image
            self.userImageView.progress = 1
            self.userImageView.endUpload(success: true)
        })
    }
    
    func newDownloadImage() {
        self.userImageView.startUpload()
        self.userImageView.progress = 0.2
        let photoUrl = Auth.auth().currentUser?.photoURL
        //let imageRef = storageRef.child("Photos/IMG_\(userID!).jpg")
        self.userImageView.progress = 0.4
        self.fakeImageView.sd_setImage(with: photoUrl, placeholderImage: #imageLiteral(resourceName: "user-filled"), options: [],completed: { (image, error,cacheType, url) in
            DispatchQueue.global(qos: .background).async {
                self.store(image: image!, forKey: "covidPalProfileImage")
            }
            self.userImageView.image = image
            self.userImageView.progress = 1
            self.userImageView.endUpload(success: true)
        })
    }
    
}
