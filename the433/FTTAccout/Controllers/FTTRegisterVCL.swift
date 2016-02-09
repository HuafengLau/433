//
//  FTTRegisterVCL.swift
//  the433
//
//  Created by tuan800 on 15/11/24.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTRegisterVCL: FTTAccountBaseVCL,UITextFieldDelegate {
    var phone : NSString?
    var password : NSString?
    var nickname : NSString?
    

    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var inputBackView: UIView!
    
    @IBOutlet weak var accountTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var nicknameTextfield: UITextField!
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
    }
    
    override func setStyle() {
        self.inputBackView.layer.cornerRadius = 5
        self.inputBackView.layer.masksToBounds = true
        self.inputBackView.layer.borderColor = UIColor.grayColor().CGColor
        self.inputBackView.layer.borderWidth = 0.5
        
        self.registerButton.layer.cornerRadius = 5
        self.registerButton.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = FTTRegisterModel()
        accountTextfield.inputAccessoryView = self.toolBar()
        accountTextfield.delegate = self
        passwordTextfield.inputAccessoryView = self.toolBar()
        // Do any additional setup after loading the view.
    }
    deinit{
        print("register page deinit")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func register() -> Void{
        phone = accountTextfield.text
        password = passwordTextfield.text
        nickname = nicknameTextfield.text
        self.startLoading()
        var alertMessage : NSString = "";
        if phone?.length < 1 {
            alertMessage = "请输入手机号"
        }else if phone?.length != 11 {
            alertMessage = "手机号只能为11位数字"
        }else if phone?.substringToIndex(1) != "1"{
            alertMessage = "手机号是无效的"
        }else if password?.length < 6 {
            alertMessage = "密码最短6个字符"
        }else if password?.length > 24 {
            alertMessage = "密码最长24个字符"
        }else if (password?.containsString(" ")  == true){
            alertMessage = "密码不能含空格"
        }else if !self.isAllNumberInString(password!) {
            alertMessage = "密码不能纯数字"
        }else if nickname?.length < 4{
            alertMessage = "昵称最短4个字符"
        }else if nickname?.length > 24{
            alertMessage = "昵称最长24个字符"
        }else if (nickname?.containsString(" ")  == true){
            alertMessage = "昵称不能含空格"
        }
        
        if alertMessage.length > 0 {
            //show alerMessage and return
            self.stopLoading()
            self.hideKeyBoard()
            FTTAlertManager.sharedInstance.showError(alertMessage as String)
            return
        }else{
            let params : NSMutableDictionary = NSMutableDictionary()
            if let aPhone = phone{
                params.setObject(aPhone, forKey: "phone")
            }
            if let aPassword = password{
                params.setObject(aPassword, forKey: "pwd")
            }
            if let aNickname = nickname{
                params.setObject(aNickname, forKey: "nicName")
            }
            let model : FTTRegisterModel = self.model as! FTTRegisterModel
            model.sendRegisterRequest(params: params, completion: {
                [weak self]
                (retDict : NSDictionary)in
                    if let instance = self{
                        instance.registerFinished(retDict)
                    }
                
                }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                    if let instance = self{
                        instance.registerFailed(faileDict)
                    }
            })
        }
    }
    
    //MARK:判断字符串是否是存数字
    func isAllNumberInString(str : NSString) -> Bool{
        var allNumber : Bool = false
        let tempStr : NSString = str.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet())
        if tempStr.length > 0{
            allNumber = true
        }
        return allNumber
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        self.hideKeyBoard()
        self.register()
    }
    
    //MARK:注册成功回调
    func registerFinished(retDict : NSDictionary){
        //需要状态判断 成功则存储用户信息 失败则弹出提示
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code") as? NSNumber
            if code?.integerValue == 200{
                let userVo : FTTUserVo = FTTUserVo()
                userVo.account = phone
                userVo.password = password?.MD5
                userVo.nickName = nickname
                userVo.isNew = "true"
                FTTDataManager().saveUserVo(userVo)
                NSNotificationCenter.defaultCenter().postNotificationName("FTTUSERLOGINFINISHED", object: self, userInfo: nil)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else{
                let msg = aMeta.objectForKey("msg") as? String
                if msg?.characters.count > 0{
                    FTTAlertManager.sharedInstance.showError(msg!)
                }else{
                    FTTAlertManager.sharedInstance.showError("注册失败")
                }
                
            }
        }else{
            FTTAlertManager.sharedInstance.showError("注册失败")
        }
    }
    
    //MARK:注册失败回调
    func registerFailed(dict : NSDictionary){
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络错误，请稍后重试")
    }
    override func hideKeyBoard() -> Void{
        accountTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
    
    //MARK: UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.characters.count >= 11{
            let tempStr = textField.text! as NSString
            let be11 = tempStr.substringToIndex(10)
            
            textField.text = be11 as String
        }
        return true
    }
}
