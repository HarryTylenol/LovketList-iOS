//
// Created by 박현기 on 2017. 11. 23..
// Copyright (c) 2017 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Then

class UserRepository {

    var userRef: CollectionReference
    var USER = "user"
    static var user: User? = nil

    init(firestore: Firestore) {
        self.userRef = firestore.collection(USER)
    }

    func queryUser(onUserDataCallback: @escaping OnUserDataCallback) {
        let currentUserUID = AuthManager.uid
        if currentUserUID != nil {
            let userDocument = userRef.document(currentUserUID!) as DocumentReference
            userDocument.getDocument { (documentSnapshot: DocumentSnapshot?, error: Error?) in
                if documentSnapshot == nil {
                    onUserDataCallback(nil)
                }
                if documentSnapshot!.exists {
                    let data = documentSnapshot!.data()
                    UserRepository.user = User(data)
                    onUserDataCallback(UserRepository.user)
                } else {
                    onUserDataCallback(nil)
                }
            }
        } else {
            onUserDataCallback(nil)
        }
    }

    func addNewUser(groupKey: String, onSuccessCallback: @escaping OnSuccessCallback, onErrorCallback: @escaping OnErrorCallback) {
        let currentUserUID = AuthManager.uid
        if currentUserUID != nil {
            let userDocument = userRef.document(currentUserUID!) as DocumentReference
            userDocument.setData(["groupKey": groupKey]) { (error) in
                if error != nil {
                    onErrorCallback(error!)
                } else {
                    onSuccessCallback()
                }
            }
        } else {
            onErrorCallback(nil)
        }
    }

}
