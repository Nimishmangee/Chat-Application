import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


class RegisterViewController: UIViewController {
    var image: UIImage?
    var imagePicker: UIImagePickerController!
    let db=Firestore.firestore();
    let storage=Storage.storage();

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBAction func uploadButtonPressesd(_ sender: UIButton) {
        print("Yes")
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        print("Yes")
        if let email=emailTextfield.text, let password=passwordTextfield.text, let name=nameTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e=error{
                    print(e);
                    let alertController = UIAlertController(title: "Registration Failed", message:e.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    
                    //***********image storage ka kaam
                    let storageRef = Storage.storage().reference()
                    let imageRef = storageRef.child("images/\(name)/image.jpg")
                    
                    if let imageData = self.image?.jpegData(compressionQuality: 0.5) {
                        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                            if let error = error {
                                print("Error uploading image: \(error.localizedDescription)")
                            } else {
                                print("Image uploaded successfully.")
                                // Perform any additional tasks after successful upload
                                
                            }
                        }
                    }
                    
                    else{
                        print("Image not inserted")
                    }
                    //************yaha pe khatam
                    
                    self.db.collection(K.FStore.userCollectionName).addDocument(data: [
                        K.FStore.senderField:email,
                        K.FStore.nameField: name,
                        
                    ]) { error in
                        if let e=error{
                            print("There was an issue, \(e)")
                        }else{
                            
                            print("User created and saved");
                        }
                    }
                    
                    //Navigate to Chat
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
}
