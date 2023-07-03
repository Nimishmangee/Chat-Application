//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Nimish Mangee on 17/06/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
    static let appName="⚡️FlashChat"
    static let cellIdentifier = "ReusableHaiCell"
    static let cellNibName = "MessageKaCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let userCollectionName="users"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let nameField = "name";
        static let URL = "URL";
    }
}
