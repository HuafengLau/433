//
//  FTTPersonalHomeVCL.swift
//  the433
//
//  Created by 黄元庆 on 16/1/16.
//  Copyright © 2016年 tuan800. All rights reserved.
//

import UIKit

class FTTPersonalHomeVCL: FTTBaseCTL,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var nickName : String = ""
    var changeNickAlertViewCTL : UIAlertController?
    override func viewDidLoad() {
      super.viewDidLoad()
        self.model = FTTPersonalHomeModel()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //加一个灰色的tableheaderview
        let headView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        headView.backgroundColor = UIColor.colorFromRGB(0xf2f2f2)
        self.tableView.tableHeaderView = headView
        //加一个退出登录的表尾
        let footview = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 80))
        footview.backgroundColor = UIColor.colorFromRGB(0xf2f2f2)
        self.tableView.tableFooterView = footview;
        
        let logoutButton = UIButton.init(type: .Custom)
        logoutButton.frame = CGRectMake(0, 0, 280, 44)
        logoutButton.center = footview.center
        var rect = logoutButton.frame;
        rect.origin.y = 18
        logoutButton.frame = rect
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        logoutButton.setTitle("退出登录", forState: .Normal)
        logoutButton.backgroundColor = FTTColorRedColor()
        
        logoutButton.addTarget(self, action: "logoutAction", forControlEvents: .TouchUpInside)
        footview.addSubview(logoutButton)
        
        
        
        self.loadItems()
    }
    
    func loadItems(){
        let model : FTTPersonalHomeModel = self.model as! FTTPersonalHomeModel
        model.loadItems()
        self.tableView.reloadData()
    }
    
    //MARK:退出登录操作
    func logoutAction(){
        SweetAlert().showAlert("提示", subTitle: "你确认退出登录吗?", style:AlertStyle.Warning,buttonTitle: " 取消 ",buttonColor: UIColor.lightGrayColor(),otherButtonTitle:
            " 确认 ", action:{
                [weak self]
                (isOtherButton : Bool)in
                
                if isOtherButton == false{
                    if let instance = self{
                        let defualtUser : FTTUserVo = FTTUserVo()
                        FTTDataManager().saveUserVo(defualtUser)
                        FTTForwardManager.sharedInstance.openLoginPage(instance, params: NSMutableDictionary())
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("FTTUSERLOGOUT", object: instance, userInfo: nil)
                    }
                }else{
                    
                }
            })
    }
    
    //MARK:UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.model?.items?.count{
            return count
        }
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("Identifier")
        if cell == nil{
            cell = UITableViewCell(style:.Value1, reuseIdentifier:"Identifier")
        }
        if let tempItem = self.model?.items![indexPath.row]{
            let item = tempItem as? FTTPersonalCommonItem
            cell!.textLabel?.text = item?.title
            cell!.detailTextLabel?.text = item?.detail
        }
        cell!.accessoryType = .DisclosureIndicator
        cell!.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let tempItem = self.model?.items![indexPath.row]{
            if let item = tempItem as? FTTPersonalCommonItem{
                if let itemTag = item.itemTag{
                    switch(itemTag){
                    case The433PersonalItemTag.NICKNAME :
                        self.changeNickAlertShow()
                        break
                    case The433PersonalItemTag.PHONE :
                        
                        break
                    }
                }
            }
        }
    }
    
    ///MARK: 修改昵称弹出提示输入框
    func changeNickAlertShow(){
        self.changeNickAlertViewCTL = UIAlertController.init(title: "修改昵称", message: "请输入新昵称4-24个字符", preferredStyle:UIAlertControllerStyle.Alert)
        
        self.changeNickAlertViewCTL?.addTextFieldWithConfigurationHandler({
            (textField: UITextField!) -> Void in
            textField.borderStyle = .RoundedRect
            textField.placeholder = "输入昵称"
        })
        
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let changeAction = UIAlertAction.init(title: "确认", style: UIAlertActionStyle.Default, handler: {
            [weak self]
            action in
            if let instacne = self{
                if let newNickName = instacne.changeNickAlertViewCTL?.textFields!.first!.text{
                    instacne.changeNickName(newNickName)
                }
            }
        })
        
        self.changeNickAlertViewCTL?.addAction(cancelAction)
        self.changeNickAlertViewCTL?.addAction(changeAction)
        
        self.presentViewController(self.changeNickAlertViewCTL!, animated: true, completion: nil)
        
    }
    //MARK:修改昵称操作
    func changeNickName(newNick : String){
        var alertMessage : String = ""
        if newNick.characters.count < 4{
            alertMessage = "昵称最短4个字符"
        }else if newNick.characters.count > 24{
            alertMessage = "昵称最长24个字符"
        }else if (newNick.containsString(" ")  == true){
            alertMessage = "昵称不能含空格"
        }
        if alertMessage.characters.count > 0{
            FTTAlertManager.sharedInstance.showError(alertMessage)
            return
        }
        self.nickName = newNick
        self.startLoading()
        let model : FTTPersonalHomeModel = self.model as! FTTPersonalHomeModel
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        params.setObject(newNick, forKey: "nicName")
        
        model.sendChangeNickNameRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.changeNickFinished(retDict)
            }
            }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                if let instance = self{
                    instance.changeNickFailed(faileDict)
                }
                //FTTAlertManager.sharedInstance.showError("获取低风险信息失败")
                
            })
        
    }
    
    
    ///MARK:修改昵称回调
    func changeNickFinished(retDict : NSDictionary){
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code") as? NSNumber
            if code?.integerValue == 200{
                //删除成功后操作
                SweetAlert().showAlert("修改成功", subTitle: "回去看看你的新昵称吧", style: AlertStyle.Success, buttonTitle: "确认", action: {
                    [weak self]
                    (isOtherButton : Bool)in
                    if isOtherButton == true{
                        if let instance = self{
                            //此处将新用户信息存到本地后 列表刷新数据
                            let userVo = FTTDataManager().getUserVo()
                            userVo.nickName = instance.nickName
                            FTTDataManager().saveUserVo(userVo)
                            instance.loadItems()
                            //instance.presentViewController(instance.changeNickAlertViewCTL!, animated: true, completion: nil)
                        }
                    }
                })
            }else{
                let msg = aMeta.objectForKey("msg") as? String
                if msg?.characters.count > 0{
                    FTTAlertManager.sharedInstance.showError(msg!)
                }else{
                    FTTAlertManager.sharedInstance.showError("修改失败")
                }
                
            }
        }
        
        
    }
    func changeNickFailed(faileDict : NSDictionary){
        //
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络错误，请稍后重试")
    }

    
}
