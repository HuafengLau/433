//
//  FTTHomeFundCountChangeCVL.swift
//  the433
//
//  Created by 黄元庆 on 15/12/20.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeFundCountChangeCVL: FTTBaseCTL {
    
    @IBOutlet weak var fundNameLabel: UILabel!
    
    @IBOutlet weak var currentCountLabel: UILabel!
    
    @IBOutlet weak var currentAssetsLabel: UILabel!
    

    @IBOutlet weak var changeCountTextField: UITextField!
    
    @IBOutlet weak var feeTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    var item : FTTHomeResultFundItem?
    var count : String?
    var fee : String?
    
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
        item = params.objectForKey("item") as? FTTHomeResultFundItem
    }
    
    func setStyle() -> Void{
        self.saveButton.layer.cornerRadius = 5.0
        self.changeCountTextField.inputAccessoryView = self.toolBar()
        self.feeTextField.inputAccessoryView = self.toolBar()
        
        if let aItem = item{
            self.currentCountLabel.text = aItem.allCount as? String
            self.currentAssetsLabel.text = aItem.allAssets as? String
            
            if let name = aItem.name{
                if let code = aItem.code{
                    self.fundNameLabel.text = String(format: "%@(%@)", name,code)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStyle()
        
        self.model = FTTHomeFundCountChangeModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:保存份额修改
    func changeCount(){
        count = self.changeCountTextField.text
        fee = self.feeTextField.text
        self.startLoading()
        var alertMessage : String = "";
        if count?.characters.count < 1{
            alertMessage = "修改后份额不能为空"
        }
        if alertMessage.characters.count > 1{
            self.stopLoading()
            FTTAlertManager.sharedInstance.showError(alertMessage)
            return
        }
        
        let params : NSMutableDictionary = NSMutableDictionary()
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        if let aCount = count{
            params.setObject(aCount, forKey: "share")
        }
        if let aItem = item{
            if let code = aItem.code{
                params.setObject(code, forKey: "fundCode")
            }
        }
        if let aFee = fee{
            params.setObject(aFee, forKey: "fee")
        }
        
        let model : FTTHomeFundCountChangeModel = self.model as! FTTHomeFundCountChangeModel
        model.sendChangeFundCountRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
                if let instance = self{
                    instance.changeCountFinished(retDict)
                }
            
            }, failed: {
            [weak self]
            (faileDict : NSDictionary)in
                if let instance = self{
                    instance.changeCountFailed(faileDict)
                }
            })
    }

    
    //MARK:修改份额后的回调
    func changeCountFinished(retDict : NSDictionary){
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code")
            if code?.integerValue == 200{
                SweetAlert().showAlert("修改成功", subTitle: "返回首页刷新最新数据把！", style: AlertStyle.Success, buttonTitle: "确认", action: {
                    [weak self]
                    (isOtherButton : Bool)in
                    if isOtherButton == false{
                        if let instance = self{
                            NSNotificationCenter.defaultCenter().postNotificationName("FTTFUNDCHANGEFINISHED", object: instance, userInfo: ["item" : instance.item!])
                            instance.navigationController?.popToRootViewControllerAnimated(true)
                        }
                    }
                })
            }else{
                FTTAlertManager.sharedInstance.showError("修改失败")
            }
        }
    }
    
    func changeCountFailed(faileDict : NSDictionary){
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络连接出错")
    }

    @IBAction func saveAction(sender: AnyObject) {
        self.hideKeyBoard()
        self.changeCount()
    }
    
    func hideKeyBoard() -> Void{
        changeCountTextField.resignFirstResponder()
        feeTextField.resignFirstResponder()
    }

}
