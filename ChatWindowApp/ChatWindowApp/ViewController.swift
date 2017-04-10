//
//  ViewController.swift
//  ChatWindowApp
//
//  Created by Sana Ullah on 06/04/17.
//  Copyright © 2017 Mohd Imran. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var scrlView:UIScrollView!
    @IBOutlet weak var btnChat:UIButton!
    @IBOutlet weak var txtChat:UITextField!
    
    var isMyChat:Bool = true
    
    var selectedImage : UIImage?
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 40.0
    var lastMessageType: Bool?
    @IBOutlet weak var bottomLayout:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let emojiSadUnicode = "1F61E"
        let emojiSadStr = String(Character(UnicodeScalar(Int(emojiSadUnicode, radix: 16)!)))
        
        let emojiHappyUnicode = "1F60A"
        let emojiHappyStr = String(Character(UnicodeScalar(Int(emojiHappyUnicode, radix: 16)!)))
        
        
        let objChat1 = ChatData(text: String(format:"%@","Hi Nora, is there still an available space") , chatType: true,status:"Seen")
        self.addChatBubble(objChat1)
        
        let objChat2 = ChatData(text: String(format:"%@ %@","Hey sure! Would you like me to save you a spot ", emojiSadStr), chatType: false,status:nil)
        self.addChatBubble(objChat2)
        
        let objChat3 = ChatData(text: String(format:"%@ %@","Yes! Thank you so much!",emojiHappyStr) , chatType: true,status:"Seen")
        self.addChatBubble(objChat3)*/
        
        self.addKeyboardNotifications()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- SEND Button IBAction
    
    @IBAction func enterChat() -> Void{
        
        self.txtChat.resignFirstResponder()
        self.btnChat.enabled = false
        
        
        let objChat = ChatData(text: String(format:"%@",self.txtChat.text!) , chatType: self.isMyChat,status:"Seen")
        self.addChatBubble(objChat)
    }
    
    func addKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // MARK:- Notification
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.bottomLayout.constant = keyboardFrame.size.height
            
        }) { (completed: Bool) -> Void in
            //self.moveToLatestMessage()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.bottomLayout.constant = 0.0
        }) { (completed: Bool) -> Void in
            //self.moveToLatestMessage()
        }
    }
    
    
    
    //MARK:- UITextField Notification
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        
        let objChat = ChatData(text: String(format:"%@",self.txtChat.text!) , chatType: self.isMyChat,status:"Seen")
        self.addChatBubble(objChat)
        
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var text: String
        
        if string.characters.count > 0 {
            text = String(format:"%@%@",textField.text!, string);
        } else {
            let string = textField.text! as NSString
            text = string.substringToIndex(string.length - 1) as String
        }
        if text.characters.count > 0 {
            self.btnChat.enabled = true
        } else {
            self.btnChat.enabled = false
        }
        return true
    }
    
    
    
    
    //MARK:- ChatBubble Method
    
    func moveToLatestMessage() {
        
        if self.scrlView.contentSize.height > CGRectGetHeight(self.scrlView.frame) {
            let contentOffSet = CGPointMake(0.0, self.scrlView.contentSize.height - CGRectGetHeight(self.scrlView.frame))
            self.scrlView.setContentOffset(contentOffSet, animated: true)
        }
    }
    
    
    func addChatBubble(objChatData:ChatData) -> Void {
        
        let padding:CGFloat = 80
        
        let chatBubble = ChatBubbleView(objChat: objChatData, yPosition: lastChatBubbleY+padding)
        
        UIView.animateWithDuration(0.7, animations: {
            
            self.scrlView.addSubview(chatBubble)
            var frame = chatBubble.frame
            frame.size.width = 0
            chatBubble.frame = frame
            chatBubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
            
            }, completion: {(complete:Bool) in
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(5.3)
                UIView.commitAnimations()
                
        })
        
        
        
        
        lastChatBubbleY = CGRectGetMaxY(chatBubble.frame)
        
        self.scrlView.contentSize = CGSizeMake(CGRectGetWidth(scrlView.frame), lastChatBubbleY + internalPadding)
        
        self.moveToLatestMessage()
        
        self.txtChat.text = ""
        
        self.isMyChat = !self.isMyChat
    }
    
    
}

