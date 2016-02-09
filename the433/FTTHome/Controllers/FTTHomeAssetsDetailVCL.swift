//
//  FTTHomeAssetsDetailVCL.swift
//  the433
//
//  Created by 黄元庆 on 15/12/18.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeAssetsDetailVCL: FTTBaseCTL {
    
    @IBOutlet weak var latestEarnLabel: UILabel!
    
    @IBOutlet weak var allEarnLabel: UILabel!
    
    @IBOutlet weak var latestPriceAddDayLabel: UILabel!
    
    @IBOutlet weak var latestPriceLabel: UILabel!
    
    @IBOutlet weak var allAssetsLabel: UILabel!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    var item : FTTHomeResultFundItem?
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
        if let aItem = params.objectForKey("item"){
            self.item = aItem as? FTTHomeResultFundItem
        }
    }
    
    func setStyle(){
        if let aItem = item{
            /*
            if let earn = aItem.latestEarn{
                let earnFloat : Float = earn.floatValue
                if earnFloat < 0{
                    self.latestEarnLabel.textColor = FTTColorGreenColor()
                }else{
                    self.latestEarnLabel.textColor = FTTColorRedColor()
                }
            }
            */
            if let allEarn = aItem.allEarn{
                let earnFloat : Float = allEarn.floatValue
                if earnFloat < 0{
                    self.allEarnLabel.textColor = FTTColorGreenColor()
                }else{
                    self.allEarnLabel.textColor = FTTColorRedColor()
                }
            }
        }
    }
    
    func setLabelValue(){
        if let aItem = item{
            self.latestEarnLabel.text = aItem.latestEarn as? String
            self.allEarnLabel.text = aItem.allEarn as? String
            self.latestPriceLabel.text = aItem.latestPrice as? String
            self.allAssetsLabel.text = aItem.allAssets as? String
            self.allCountLabel.text = aItem.allCount as? String
            if let today = aItem.latestDate{
                self.latestPriceAddDayLabel.text = String.init(format: "最近净值(%@)", today)
            }else{
                self.latestPriceAddDayLabel.text = "最近净值"
            }
            
            var title : String = "资产详情"
            if let name = aItem.name{
                if let code = aItem.code{
                    title = String.init(format: "%@(%@)", name,code)
                }
            }
            self.navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabelValue()
        self.setStyle()
        self.model = FTTHomeAssetsDetailModel()
        // 删除基金
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteAction")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func deleteAction(){
       //弹窗提醒 确认再删 取消则不处理
        SweetAlert().showAlert("提示", subTitle: "你确认要删除这只基金吗?", style:AlertStyle.Warning,buttonTitle: " 取消 ",buttonColor: UIColor.lightGrayColor(),otherButtonTitle:
            " 确认 ", action:{
                [weak self]
                (isOtherButton : Bool)in

                if isOtherButton == false{
                    if let instance = self{
                        instance.deleteOneFund()
                    }
                }else{
                    
                }
        })
    }
    
    func deleteOneFund(){
        self.startLoading()
        let model : FTTHomeAssetsDetailModel = self.model as! FTTHomeAssetsDetailModel
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        if let aCode = self.item?.code{
            params.setObject(aCode, forKey: "fundCode")
        }
        
        model.sendChangeDeleteFundRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.deleteFinished(retDict)
            }
            }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                if let instance = self{
                    instance.deleteFailed(faileDict)
                }
                //FTTAlertManager.sharedInstance.showError("获取低风险信息失败")
                
            })
    }
    
    //MARK: 删除基金回调
    func deleteFinished(retDict : NSDictionary){
        self.stopLoading()
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code") as? NSNumber
            if code?.integerValue == 200{
                //删除成功后操作
                SweetAlert().showAlert("删除成功", subTitle: "返回首页刷新最新数据把！", style: AlertStyle.Success, buttonTitle: "确认", action: {
                    [weak self]
                    (isOtherButton : Bool)in
                    if isOtherButton == true{
                        if let instance = self{
                            NSNotificationCenter.defaultCenter().postNotificationName("FTTFUNDDELETEFINISHED", object: instance, userInfo: ["item" : instance.item!])
                            instance.navigationController?.popToRootViewControllerAnimated(true)
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
    func deleteFailed(faileDict : NSDictionary){
        //
        self.stopLoading()
        FTTAlertManager.sharedInstance.showError("网络错误，请稍后重试")
    }
    
    @IBAction func changeCountAction(sender: AnyObject) {
        //修改份额页面
        if let aItem = item{
            self.openChangeFundCountPage(aItem)
        }
    }
    
    //MARK:打开修改基金份额页面
    func openChangeFundCountPage(item : FTTHomeResultFundItem?){
        if let aItem = item{
            let param : NSMutableDictionary = NSMutableDictionary()
            param.setObject(aItem, forKey: "item")
            FTTForwardManager.sharedInstance.openFundCountChangePage(self, params: param)
        }
    }

}
