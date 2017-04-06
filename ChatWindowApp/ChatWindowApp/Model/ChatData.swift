//
//  ChatData.swift
//  ChatWindow-App
//
//  Created by Sana Ullah on 05/04/17.
//  Copyright © 2017 Mohd Imran. All rights reserved.
//

import UIKit

class ChatData: NSObject {
    
    var chatText:String!
    var isMyChat:Bool!
    var chatStatus:String?
    
    convenience init(text:String, chatType:Bool, status:String?){
        
        self.init()
        
        self.chatText = text
        self.isMyChat = chatType
        self.chatStatus = status
    }

}
