//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db=Firestore.firestore();
    
    var messages:[Message]=[]
    
    var namesOFUsers:[String:String]=[:];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self;
        title=K.appName;
        navigationItem.hidesBackButton=true;
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages();
    }
    
    func loadMessages(){
        
        db.collection(K.FStore.userCollectionName)
            .addSnapshotListener { querySnapshot, error in
                
                self.namesOFUsers=[:]
            
            if let e=error{
                print("There was an issue  retrieving data, \(e)")
            }else{
                if let snapshotDocuments=querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data=doc.data()
                        if let messsageSender=data[K.FStore.senderField] as? String, let userName=data[K.FStore.nameField] as? String{
                            
                            self.namesOFUsers[messsageSender]=userName
                        }
                    }
                }
            }
        }
        
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages=[]
            
            if let e=error{
                print("There was an issue  retrieving data, \(e)")
            }else{
                if let snapshotDocuments=querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data=doc.data()
                        if let messsageSender=data[K.FStore.senderField] as? String, let messageBody=data[K.FStore.bodyField] as? String, let userName=data[K.FStore.nameField]as? String{
                            let newMessage=Message(sender: messsageSender, body: messageBody, name:userName)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData();
                                
                                let indexPath=IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody=messageTextfield.text, let messageSender=Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField:messageSender,
                K.FStore.bodyField:messageBody,
                K.FStore.dateField:Date().timeIntervalSince1970,
                K.FStore.nameField:namesOFUsers[messageSender]!
            ]) { error in
                if let e=error{
                    print("There was an issue, \(e)")
                }else{
                    print("Message printed");
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text="";
                    }
                }
            }
        }
    }
    
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        if let messageBody=messageTextfield.text, let messageSender=Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField:messageSender,
                K.FStore.bodyField:messageBody,
                K.FStore.dateField:Date().timeIntervalSince1970
            ]) { error in
                if let e=error{
                    print("There was an issue, \(e)")
                }else{
                    print("Message printed");
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text="";
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true);
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            
        }
    }
}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message=messages[indexPath.row]
        
        
        let cell=tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text=messages[indexPath.row].body;
        cell.leftLabel.text=message.name
        cell.rightLabel.text=message.name
        
        //This is a message from the current user
        if message.sender==Auth.auth().currentUser?.email {
            cell.leftView.isHidden=true;
            cell.rightView.isHidden=false;
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.5260234475, green: 0.9091125131, blue: 0.9875254035, alpha: 1)
            cell.label.textColor=UIColor.black
            cell.rightLabel.text="Me"
        }
        
        //This is a message from other sender
        else{
            cell.leftView.isHidden=false;
            cell.rightView.isHidden=true;
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.9271799922, green: 0.9821534753, blue: 0.994110167, alpha: 1)
            cell.label.textColor=UIColor.black
        }
        
        return cell;
    }
}

