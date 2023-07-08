<p align="center">
  <img src="https://user-images.githubusercontent.com/82581324/180593755-83ce022c-a632-437b-928e-8caf68f143e3.png" alt="Icon"/>
</p>
<H1 align="center">GallanKariye-iOS</H1>


## Description

Group Chat is an internet based group messaging app somewhat similar to Telegram. 

Firebase Firestore will be used as backend service for authentication and storing and retrieving messages

The App is built on Model-View-Controller(MVC) Architecture

![RPReplay_Final1688832555](https://github.com/Nimishmangee/GallanKariye-iOS/assets/82581324/e24984c8-bd42-4cbe-b04d-438ba60003fe)
<br>
![IMG_C643F686B546-1-2](https://github.com/Nimishmangee/GallanKariye-iOS/assets/82581324/1fa0f7b3-ab8a-4fff-801d-3ebca87e328a)






## This App will

* Integrate third party libraries using Cocoapods and Swift Package Manager.
* Store data in the cloud using Firebase Firestore.
* Query and sort the Firebase database.
* Use Firebase for user authentication, registration and login.
* Work with UITableViews and how to set their data sources and delegates.
* How to create direct Segues for navigation.


## Constants
```
struct K {
    static let appName="⚡️GroupChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
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
    }
}

```
## To install 
1. Firebase needs to be installed and link to docs: https://firebase.google.com/docs/ios/setup
2. pod install command needs to be run
3. GoogleService-Info.plist needs to be replaced 
4. IQ Keyboard Manager should be installed using Swift Package Manager, the link for same: https://github.com/hackiftekhar/IQKeyboardManager 
