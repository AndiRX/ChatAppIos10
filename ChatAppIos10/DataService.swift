//
//  DataService.swift
//  ChatAppIos10
//
//  Created by Petr on 07.11.17.
//  Copyright © 2017 Andi. All rights reserved.
//

import Foundation
import Firebase

protocol DataServiceDelegate: class {
    func dataLoaded()
}

class DataService {
    static let instance = DataService()

    let ref = Database.database().reference()
    var messages: [Message] = []
    
    weak var delegate: DataServiceDelegate?
    
    func loadMessages(_ completion: @escaping (_ Success: Bool) -> Void) {
        ref.observe(.value) { (data: DataSnapshot) in
            if data.value != nil {
                let unsortedMessages = Message.messageArrayFromFBData(data.value! as AnyObject)
                self.messages = unsortedMessages.sorted(by: {$0.messageId < $1.messageId})
                self.delegate?.dataLoaded()
                if self.messages.count > 0 {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
    }
    
}

    func saveMessage(_ user: String, message: String) {
        let key = ref.childByAutoId().key
        let message = ["user": user, "message": message]
        let messageUpdates = ["/\(key)": message]
        ref.updateChildValues(messageUpdates)
    }
}
