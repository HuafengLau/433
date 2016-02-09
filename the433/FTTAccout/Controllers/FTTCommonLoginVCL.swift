//
//  FTTCommonLoginVCL.swift
//  the433
//
//  Created by tuan800 on 15/11/23.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTCommonLoginVCL: FTTAccountBaseVCL,UITextFieldDelegate {
    var phone : NSString?
    var password : NSString?
    
    @IBOutlet weak var backImageView: UIImageView!

    @IBOutlet weak var inputBackView: UIView!
    
    @IBOutlet weak var accountTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var changePWButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
    }
    
    override func setStyle() {
        self.inputBackView.layer.cornerRadius = 5
        self.inputBackView.layer.masksToBounds = true
        self.inputBackView.layer.borderColor = UIColor.grayColor().CGColor
        self.inputBackView.layer.borderWidth = 0.5

        self.loginButton.layer.cornerRadius = 5
        self.loginButton.layer.masksToBounds = true

        self.registerButton.layer.cornerRadius = 5
        self.registerButton.layer.masksToBounds = true
        
        self.changePWButton.hidden = true
        
        let lastAccount = FTTDataManager().getLastAccount()
        if lastAccount.characters.count > 0{
            accountTextfield.text = lastAccount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = FTTCommonLoginModel()
        accountTextfield.inputAccessoryView = self.toolBar()
        accountTextfield.delegate = self
        passwordTextfield.inputAccessoryView = self.toolBar()
        passwordTextfield.secureTextEntry = true
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    deinit{
        print("login page deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //login
    func login() -> Void{
        phone = accountTextfield.text
        password = passwordTextfield.text
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
            let model : FTTCommonLoginModel = self.model as! FTTCommonLoginModel
            model.sendLoginRequest(params: params, completion: {
                [weak self]
                (retDict : NSDictionary)in
                if let instance = self{
                    instance.loginFinished(retDict)
                }
                
                }, failed: {
                    [weak self]
                    (faileDict : NSDictionary)in
                    if let instance = self{
                        instance.loginFailed(faileDict)
                    }
                })
        }
    }
    
    func loginFinished(retDict : NSDictionary){
        //需要状态判断 成功则存储用户信息 失败则弹出提示
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code") as? NSNumber
            if code?.integerValue == 200{
                let userVo : FTTUserVo = FTTUserVo()
                userVo.account = phone
                userVo.password = password?.MD5
                let dict = retDict.objectForKey("data") as? NSDictionary
                if let aDict = dict{
                    if let nick = aDict.objectForKey("nicName"){
                        userVo.nickName = nick as? NSString
                    }
                }
                
                FTTDataManager().saveUserVo(userVo)
                FTTDataManager().saveLastAccount(phone as! String)
                self.navigationController?.popToRootViewControllerAnimated(true)
                NSNotificationCenter.defaultCenter().postNotificationName("FTTUSERLOGINFINISHED", object: self, userInfo: nil)
            }else{
                let msg = aMeta.objectForKey("msg") as? String
                if msg?.characters.count > 0{
                    FTTAlertManager.sharedInstance.showError(msg!)
                }else{
                    FTTAlertManager.sharedInstance.showError("登录失败")
                }
                
            }
        }else{
            FTTAlertManager.sharedInstance.showError("登录失败")
        }
        
    }
    
    func loginFailed(faileDict : NSDictionary){
        //
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络错误，请稍后重试")
    }
    
    //MARK:  点击事件
    @IBAction func changePWAction(sender: AnyObject) {
        //open changePWPage
    }
    

    @IBAction func loginAction(sender: AnyObject) {
        //request login
        self.hideKeyBoard()
        self.login()
    }
    
    
    @IBAction func registerAction(sender: AnyObject) {
        //open registerPage
        self.hideKeyBoard()
        FTTForwardManager.sharedInstance.openRegisterPage(self, params: NSMutableDictionary())
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
