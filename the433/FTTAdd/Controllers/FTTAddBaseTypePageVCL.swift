//
//  FTTAddBaseTypePageVCL.swift
//  the433
//
//  Created by 黄元庆 on 15/12/15.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
let fundViewDefualtHight : CGFloat = 76.0
let historyViewDefualtHight : CGFloat = 100.0
class FTTAddBaseTypePageVCL: FTTBaseCTL {
    @IBOutlet weak var fundCodeView: UIView!
    @IBOutlet weak var fundTitleLabel: UILabel!
    @IBOutlet weak var fundCodeTextField: UITextField!
    
    
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countTitleLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    
    
    @IBOutlet weak var countTipsLabel: UILabel!
    
    @IBOutlet weak var historyEarnView: UIView!
    @IBOutlet weak var historyTitleLabel: UILabel!
    
    @IBOutlet weak var historyEarnTextField: UITextField!
    
    var item : FTTAddBaseItem?
    var code : NSString?
    var count : NSString?
    var earn : NSString?
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
        if let aItem = params.objectForKey("item"){
            self.item = aItem as? FTTAddBaseItem
        }
    }
    
    func setStyle()->Void{
        fundCodeTextField.inputAccessoryView = self.toolBar()
        countTextField.inputAccessoryView = self.toolBar()
        historyEarnTextField.inputAccessoryView = self.toolBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item?.name as? String
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveFundAction")
        
        self.model = FTTAddBaseTypePageModel()
        
        self.setStyle()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addFund() -> Void{
        var alertMessage : String?
        code = self.fundCodeTextField.text
        count = self.countTextField.text
        earn = self.historyEarnTextField.text
        
        if code?.length < 1{
            alertMessage = "基金代码为空"
        }else if count?.length < 1{
            alertMessage = "份额不能为空"
        }else if earn?.length < 1{
            alertMessage = " 历史收益不能为空"
        }
        
        if let message = alertMessage{
            self.stopLoading()
            self.hideKeyBoard()
            FTTAlertManager.sharedInstance.showError(message as String)
            return
        }
        
        let params : NSMutableDictionary = NSMutableDictionary()
        if let vo : FTTUserVo = FTTDataManager().getUserVo(){
            if let phone = vo.account{
                params.setObject(phone, forKey: "phone")
            }
            if let pwd = vo.password{
                params.setObject(pwd, forKey: "pwd")
            }
        }
        if let aCode = code{
            params.setObject(aCode, forKey: "fundCode")
        }
        if let aCount = count{
            params.setObject(aCount, forKey: "share")
        }
        if let aEarn = earn{
            params.setObject(aEarn, forKey: "profitBefore")
        }
        //风险等级参数 待商榷
        if let type = item?.type{
            switch(type){
                case The433RiskLevel.HIGHT :
                     params.setObject("highRisk", forKey: "types")
                    break
                case The433RiskLevel.MID :
                     params.setObject("middleRisk", forKey: "types")
                    break
                case The433RiskLevel.LOW :
                     params.setObject("lowRisk", forKey: "types")
                    break
            }
        }
        
        let model : FTTAddBaseTypePageModel = self.model as! FTTAddBaseTypePageModel
        model.sendFundAddRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.fundAddFinished(retDict)
            }
            
        }, failed: {
            [weak self]
            (faileDict : NSDictionary)in
            if let instance = self{
                instance.fundAddFailed(faileDict)
            }
        })
        
    }

    
    func saveFundAction()->Void{
        self.startLoading()
        self.addFund()
    }
    
    
    func fundAddFinished(retDict : NSDictionary){
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code")
            if code?.integerValue == 200{
            NSNotificationCenter.defaultCenter().postNotificationName("FTTFUNDADDFINISHED", object: self, userInfo: ["item" : self.item!])
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else{
                let msg = aMeta.objectForKey("msg") as? String
                if msg?.characters.count > 0{
                    FTTAlertManager.sharedInstance.showError(msg!)
                }else{
                    FTTAlertManager.sharedInstance.showError("收录失败")
                }
                
            }
        }
    }
    func fundAddFailed(faileDict : NSDictionary){
        //
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络错误，请稍后重试")
    }
    
    
    func hideKeyBoard() -> Void{
        fundCodeTextField.resignFirstResponder()
        countTextField.resignFirstResponder()
        historyEarnTextField.resignFirstResponder()
    }

}
