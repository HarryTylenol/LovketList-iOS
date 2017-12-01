//
//  GroupRepository.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 23..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class GroupRepository {

    var firestore: Firestore

    static var GROUP = "group"

    static var myGroup: Group? = nil

    init(firestore: Firestore) {
        self.firestore = firestore
    }

    class func getPartenerUID() -> String {
        if GroupRepository.myGroup == nil {
            return ""
        }

        return GroupRepository.myGroup!.tokens.filter { (key, value) -> Bool in
            key != AuthManager.uid
        }.first!.key
    }

    func addNewGroup(uid: String, singleQueryCallback: @escaping SingleQueryCallback<String>,
                     onErrorCallback: @escaping OnErrorCallback
    ) {
        self.firestore.collection(GroupRepository.GROUP)
                .addDocument(data: Group([
                    "tokens": [uid: AppDelegate.FCMToken]
                ]).toMap())
                .addSnapshotListener { (documentSnapshot, error) in
                    if documentSnapshot == nil || error != nil {
                        onErrorCallback(error)
                        return
                    }
                    singleQueryCallback(documentSnapshot!.documentID)
                }
    }

    func queryGroup(key: String,
                    singleQueryCallback: @escaping SingleQueryCallback<Group>,
                    onErrorCallback: @escaping OnErrorCallback) {
        if UserRepository.user == nil {
            onErrorCallback(nil)
            return
        }
        self.firestore.collection(GroupRepository.GROUP)
                .document(UserRepository.user!.groupKey)
                .addSnapshotListener { (documentSnapshot, error) in

                    if documentSnapshot == nil || error != nil {
                        onErrorCallback(error)
                        return
                    }

                    let data = documentSnapshot!.data()
                    GroupRepository.myGroup = Group(data)
                    singleQueryCallback(GroupRepository.myGroup)

                }
    }

}
