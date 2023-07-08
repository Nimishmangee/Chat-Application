
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email=emailTextfield.text, let password=passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e=error{
                    print(e)
                    let alertController = UIAlertController(title: "Authentication Failed", message:e.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
