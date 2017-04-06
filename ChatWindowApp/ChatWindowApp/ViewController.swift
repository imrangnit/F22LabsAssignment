//
//  ViewController.swift
//  ChatWindowApp
//
//  Created by Sana Ullah on 06/04/17.
//  Copyright © 2017 Mohd Imran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrlView:UIScrollView!
    
    var selectedImage : UIImage?
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 8.0
    var lastMessageType: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emojiSadUnicode = "1F61E"
        let emojiSadStr = String(Character(UnicodeScalar(Int(emojiSadUnicode, radix: 16)!)))
        
        let emojiHappyUnicode = "1F60A"
        let emojiHappyStr = String(Character(UnicodeScalar(Int(emojiHappyUnicode, radix: 16)!)))
        
        
        let objChat1 = ChatData(text: String(format:"%@","Hi Nora, is there still an available space") , chatType: true,status:"Delivered")
        self.addChatBubble(objChat1)
        
        let objChat2 = ChatData(text: String(format:"%@ %@","Hey sure! Would you like me to save you a spot ", emojiSadStr), chatType: false,status:nil)
        self.addChatBubble(objChat2)
        
        let objChat3 = ChatData(text: String(format:"%@ %@","Yes! Thank you so much!",emojiHappyStr) , chatType: true,status:"Seen")
        self.addChatBubble(objChat3)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- ChatBubble Method
    
    
    func addChatBubble(objChatData:ChatData) -> Void {
        
        let padding:CGFloat = 80
        
        let chatBubble = ChatBubbleView(objChat: objChatData, yPosition: lastChatBubbleY+padding)
        self.scrlView.addSubview(chatBubble)
        
        lastChatBubbleY = CGRectGetMaxY(chatBubble.frame)
        
        self.scrlView.contentSize = CGSizeMake(CGRectGetWidth(scrlView.frame), lastChatBubbleY + internalPadding)
        
    }
    
    
}

