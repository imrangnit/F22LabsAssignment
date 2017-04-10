import UIKit

class ChatBubbleView: UIView {
    
    
    var lblChat:UILabel!
    var imgChatBubble:UIImageView!
    
    var viewChat:UIView!
    var lblStatus:UILabel!
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    init(objChat:ChatData, yPosition:CGFloat) {
        
        self.viewChat = UIView()
        
        let paddingFactor: CGFloat = 0.02
        let sidePadding = ScreenSize.SCREEN_WIDTH * paddingFactor
        let maxWidth = ScreenSize.SCREEN_WIDTH * 0.65 // We are cosidering 65% of the screen width as the Maximum with of a single bubble
        let startX: CGFloat = true == objChat.isMyChat ? ScreenSize.SCREEN_WIDTH * (CGFloat(1.0) - paddingFactor) - maxWidth : sidePadding
        
        super.init(frame: CGRectMake(startX, yPosition, maxWidth, 5))
        
        self.backgroundColor = UIColor.clearColor()
        
        let padding: CGFloat = 10.0
        
        let startXChat = padding
        let startY:CGFloat = 5.0
        
        self.lblChat = UILabel(frame: CGRectMake(startXChat, startY, CGRectGetWidth(self.frame) - 2 * startXChat , 5))
        self.lblChat.textAlignment = objChat.isMyChat == true ? .Right : .Left
        self.lblChat.font = UIFont.systemFontOfSize(14)
        self.lblChat.numberOfLines = 0
        self.lblChat.text = objChat.chatText
        self.lblChat.sizeToFit()
        
        var viewHeight: CGFloat = 0.0
        var viewWidth: CGFloat = 0.0
        viewHeight = CGRectGetMaxY(self.lblChat.frame) + padding/2
        viewWidth = CGRectGetWidth(self.lblChat.frame) + CGRectGetMinX(self.lblChat.frame) + padding
        
        self.viewChat.frame = CGRectMake(CGRectGetMinX(self.viewChat.frame), CGRectGetMinY(self.viewChat.frame), viewWidth, viewHeight)
        
        self.viewChat.addSubview(self.lblChat)
        
        let bubbleImageFileName = objChat.isMyChat == true ? "bubbleUser" : "bubbleUserFriend"
        self.imgChatBubble = UIImageView(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(self.viewChat.frame), CGRectGetHeight(self.viewChat.frame)))
        if objChat.isMyChat == true {
            
            self.imgChatBubble.image = UIImage(named: bubbleImageFileName)?.resizableImageWithCapInsets(UIEdgeInsetsMake(14, 14, 17, 28))
            self.lblChat.textColor = UIColor.blackColor()
            
        } else {
            
            self.imgChatBubble.image = UIImage(named: bubbleImageFileName)?.resizableImageWithCapInsets(UIEdgeInsetsMake(14, 22, 17, 20))
            self.lblChat.textColor = UIColor.blackColor()
        }
        
        self.viewChat.addSubview(self.imgChatBubble)
        self.viewChat.sendSubviewToBack(self.imgChatBubble)
        
        let repsotionXFactor:CGFloat = objChat.isMyChat == true ? 0.0 : -8.0
        let bgImageNewX = CGRectGetMinX(self.imgChatBubble.frame) + repsotionXFactor
        let bgImageNewWidth =  CGRectGetWidth(self.imgChatBubble.frame) + CGFloat(12.0)
        let bgImageNewHeight =  CGRectGetHeight(self.imgChatBubble.frame) + CGFloat(6.0)
        self.imgChatBubble.frame = CGRectMake(bgImageNewX, 0.0, bgImageNewWidth, bgImageNewHeight)
        
        
        var newStartX:CGFloat = 0.0
        if objChat.isMyChat == true {
            let extraWidthToConsider = CGRectGetWidth(self.imgChatBubble.frame)
            newStartX = ScreenSize.SCREEN_WIDTH - extraWidthToConsider
        } else {
            newStartX = -CGRectGetMinX(self.imgChatBubble.frame) + 3.0
        }
        
        self.addSubview(self.viewChat)
        
        if objChat.isMyChat == true{
            
            let lblStatus = UILabel(frame: CGRectMake(startXChat, self.viewChat.frame.origin.y+self.viewChat.frame.size.height+5, self.lblChat.frame.size.width, 10))
            lblStatus.textAlignment =  .Right
            lblStatus.textColor = UIColor.darkGrayColor()
            lblStatus.font = UIFont.systemFontOfSize(10)
            lblStatus.text = objChat.chatStatus!
            //lblStatus.backgroundColor = UIColor.darkGrayColor()
            self.addSubview(lblStatus)
        }
        
        
        self.frame = CGRectMake(newStartX, CGRectGetMinY(self.frame), CGRectGetWidth(frame), bgImageNewHeight)
        
        print("BackGround Height: ",bgImageNewHeight,frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
