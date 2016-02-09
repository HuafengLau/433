//
//  FTTHomeResultPageVCL.swift
//  the433
//
//  Created by 黄元庆 on 15/12/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
let defualtHeaderHeight : CGFloat = 245.0
class FTTHomeResultPageVCL: FTTBaseCTL ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var headerView : FTTHomeResultPageTableHeaderView?
    var refreshControl : UIRefreshControl? = UIRefreshControl()
    
    var highPrecent : NSString?
    var midPrecent : NSString?
    var lowPrecent : NSString?
    
    var isShowError: Bool?
    var highLoadFinished : Bool?
    var midLoadFinished : Bool?
    var lowLoadFinished : Bool?
    
    func setStyle(){
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init mdoel
        //self.setStyle()
        self.model = FTTHomeResultPageModel()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.isShowError = false
        
        //判断启动跳转页面 是alltype 还是登录 或者保持本页面
        
        //增加刷新
        refreshControl?.addTarget(self, action: "reloadAllItems", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        tableView.addSubview(refreshControl!)
        
        //不要分割线
        self.tableView.separatorStyle = .None
        //设置默认的head视图
        let item : FTTHomeResultHeaderItem = FTTHomeResultHeaderItem()
        item.allAssets = "0"
        item.allEarn = "0"
        item.refreshDay = "0"
        item.yesterdayEarn = "0"
        self.refreshHeaderView(item)
        self.reloadAllItems()
        //登录成功通知 刷新列表
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("freshAndReloadAllItems"), name: "FTTUSERLOGINFINISHED", object: nil)
        //添加一只新的基金刷新列表
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("addThenReloadOneRiskItems:"), name: "FTTFUNDADDFINISHED", object: nil)
        //修改基金成功后通知 刷新列表
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("freshAndReloadOneRiskItems:"), name: "FTTFUNDCHANGEFINISHED", object: nil)
        //删除基金成功后通知 刷新列表
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("deleteAndReloadOneRiskItems:"), name: "FTTFUNDDELETEFINISHED", object: nil)
        //退出登录通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userLogoutAction"), name: "FTTUSERLOGOUT", object: nil)
        
        //打开资产添加home页面
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "openAddFundPage")
        
        //打开登录页面
        //打开个人中心
        let personalButton = UIButton.init(type: .Custom)
        personalButton.setTitle("我", forState: UIControlState.Normal)
        personalButton.adjustsImageWhenHighlighted = false
        personalButton.frame = CGRectMake(0, 0, 44, 44)
        personalButton.addTarget(self, action: "openPersonalHomePage", forControlEvents: .TouchUpInside)
        let leftItem : UIBarButtonItem = UIBarButtonItem.init(customView: personalButton)
        self.navigationItem.leftBarButtonItem = leftItem

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:刷新首页所有数据
    func reloadAllItems() -> Void{
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        for item in model.service!.requestArray {
            item.cancel()
        }
        
        self.highLoadFinished = false
        self.midLoadFinished = false
        self.lowLoadFinished = false
        
        self.startLoading()
        self.refreshAnimation()
        self.loadAllAssetsInfo()
        self.loadHightRiskFundInfo()
        self.loadMidRiskFundInfo()
        self.loadLowRiskFundInfo()
    }
    
    //调用刷新动画
    func refreshAnimation(){
        if self.refreshControl?.refreshing == false{
            
        }
    }
    
    //注册登录后清一遍数据再重新请求
    func freshAndReloadAllItems() -> Void{
        if refreshControl?.refreshing == true{
            return;
        }
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        model.hightArray?.removeAllObjects()
        model.midArray?.removeAllObjects()
        model.lowArray?.removeAllObjects()
        
        self.reloadAllItems()
    }
    
    //修改某只基金后专门刷新该风险类的数据
    func freshAndReloadOneRiskItems(not : NSNotification){
        let item = not.userInfo!["item"] as? FTTHomeResultFundItem
        
        if let type = item?.type{
            switch(type){
            case The433RiskLevel.HIGHT :
                self.loadHightRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            case The433RiskLevel.MID :
                self.loadMidRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            case The433RiskLevel.LOW :
                self.loadLowRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            }
        }
    }
    
    //修改某只基金后专门刷新该风险类的数据
    func deleteAndReloadOneRiskItems(not : NSNotification){
        let item = not.userInfo!["item"] as? FTTHomeResultFundItem
        self.loacalDataRefreshAfterDelete(item!)
        if let type = item?.type{
            switch(type){
            case The433RiskLevel.HIGHT :
                self.loadHightRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            case The433RiskLevel.MID :
                self.loadMidRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            case The433RiskLevel.LOW :
                self.loadLowRiskFundInfo()
                self.loadAllAssetsInfo()
                break
            }
        }
    }
    
    func loacalDataRefreshAfterDelete(item : FTTHomeResultFundItem){
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        let code = item.code
        if let type = item.type{
            switch(type){
            case .HIGHT:
                for aItem in model.hightArray!{
                    if aItem is FTTHomeResultFundItem{
                        if code === aItem.code{
                            model.hightArray?.removeObject(aItem)
                            //model.items?.replaceObjectAtIndex(0, withObject: model.hightArray!)
                        }
                    }
                }
                break
            case .MID :
                for aItem in model.midArray!{
                    if aItem is FTTHomeResultFundItem{
                        if code === aItem.code{
                            model.midArray?.removeObject(aItem)
                            //model.items?.replaceObjectAtIndex(1, withObject: model.midArray!)
                        }
                    }
                }
                break
            case .LOW :
                for aItem in model.lowArray!{
                    if aItem is FTTHomeResultFundItem{
                        if code === aItem.code{
                            model.lowArray?.removeObject(aItem)
                             //model.items?.replaceObjectAtIndex(2, withObject: model.lowArray!)
                        }
                    }
                }
                break
            }
        }
        
        self.reloadTableData()
    }
    
    //添加一只基金刷新
    func addThenReloadOneRiskItems(not : NSNotification){
        let item = not.userInfo!["item"] as? FTTAddBaseItem
        
        if let type = item?.type{
            switch(type){
            case The433RiskLevel.HIGHT :
                self.loadAllAssetsInfo()
                self.loadHightRiskFundInfo()
                break
            case The433RiskLevel.MID :
                self.loadAllAssetsInfo()
                self.loadMidRiskFundInfo()
                break
            case The433RiskLevel.LOW :
                self.loadAllAssetsInfo()
                self.loadLowRiskFundInfo()
                break
            }
        }
    }
    
    func userLogoutAction(){
        let defualtItem : FTTHomeResultHeaderItem = FTTHomeResultHeaderItem()
        defualtItem.allAssets = "0.00"
        defualtItem.allEarn = "0.00"
        defualtItem.yesterdayEarn = "0.00"
        defualtItem.hightPrecent = "0.30"
        defualtItem.midPrecent = "0.30"
        defualtItem.lowPrecent = "0.40"
        self.refreshHeaderView(defualtItem)
    }
    
    
    //MARK:加载首页headview部分数据
    func loadAllAssetsInfo() -> Void{
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        
        model.sendAllAssetsRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.stopLoading()
                instance.refreshControl?.endRefreshing()
                let item = retDict.objectForKey("item") as! FTTHomeResultHeaderItem
                instance.highPrecent = item.hightPrecent
                instance.midPrecent = item.midPrecent
                instance.lowPrecent = item.lowPrecent
                instance.refreshHeaderView(item)
                }
            }, failed: {
            [weak self]
            (faileDict : NSDictionary)in
            if let instance = self{
                instance.refreshControl?.endRefreshing()
                if instance.isShowError == false{
                    instance.dealError()
                }
            }
            //FTTAlertManager.sharedInstance.showError("获取主资产信息失败")
        })
    }
    
    //更新tableview的headerview
    func refreshHeaderView(item : FTTHomeResultHeaderItem){
        if headerView == nil{
            let viewArray = NSBundle.mainBundle().loadNibNamed("FTTHomeResultPageTableHeaderView", owner: self, options: nil)
            headerView = viewArray[0] as? FTTHomeResultPageTableHeaderView
        }
        headerView?.frame = CGRectMake(0, 0, self.view.frame.size.width, defualtHeaderHeight)
        headerView?.item = item
        headerView?.setHeaderView()
        headerView?.backgroundColor = FTTColorBlueColor()
        self.tableView.tableHeaderView = headerView
    }
    
    //MARK: 加载高风险资产信息
    func loadHightRiskFundInfo() -> Void{
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        
        model.sendHightAssetsRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.highLoadFinished = true
                instance.dealFinished()
            }
            }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                if let instance = self{
                    instance.refreshControl?.endRefreshing()
                    if instance.isShowError == false{
                        instance.dealError()
                    }
                }
                //FTTAlertManager.sharedInstance.showError("获取高风险信息失败")
        })
    }
    
    //MARK: 加载中风险资产信息
    func loadMidRiskFundInfo() -> Void{
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        
        model.sendMidAssetsRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.midLoadFinished = true
                instance.dealFinished()
            }
            }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                if let instance = self{
                    instance.refreshControl?.endRefreshing()
                    if instance.isShowError == false{
                        instance.dealError()
                    }
                }
                //FTTAlertManager.sharedInstance.showError("获取中风险信息失败")
        })
    }
    
    //MARK: 加载低风险资产信息
    func loadLowRiskFundInfo() -> Void{
        let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
        
        let params : NSMutableDictionary = NSMutableDictionary()
        
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if let phone = userVo?.account{
            params.setObject(phone, forKey: "phone")
        }
        
        model.sendLowAssetsRequest(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.lowLoadFinished = true
                instance.dealFinished()
            }
            }, failed: {
                [weak self]
                (faileDict : NSDictionary)in
                if let instance = self{
                    instance.refreshControl?.endRefreshing()
                    if instance.isShowError == false{
                        instance.dealError()
                    }
                }
                //FTTAlertManager.sharedInstance.showError("获取低风险信息失败")
                
        })
    }
    
    func dealFinished(){
        self.stopLoading()
        self.refreshControl?.endRefreshing()
        self.reloadTableData()
    }
    
    func reloadTableData(){
        self.startHomePageForward()
        self.tableView.reloadData()
    }
    
    //处理错误提示，多接口返回错误时不会多个蒙层提示
    func dealError(){
        self.stopLoading()
        self.isShowError = true
        SweetAlert().showAlert("网络错误，数据获取失败", subTitle: nil, style: AlertStyle.Error, buttonTitle: "确认", action: {
            (isOtherButton : Bool)in
            if isOtherButton == false{
                self.isShowError = false
            }
        })
    }
    
    

    //MARK:UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            let tempArray = self.model?.items![section]
            return (tempArray?.count)!
        }else if section == 1{
            let tempArray = self.model?.items![section]
            return (tempArray?.count)!
        }else if section == 2{
            let tempArray = self.model?.items![section]
            return (tempArray?.count)!
        }
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return (self.model?.items?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        let tempArray = self.model?.items![section]
        if section == 0{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    return 44
                }else if item is FTTHomeResultFundItem{
                    return 61
                }
            }
        }else if section == 1{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                   return 44
                }else if item is FTTHomeResultFundItem{
                   return 61
                }
            }
        }else if section == 2{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    return 44
                }else if item is FTTHomeResultFundItem{
                    return 61
                }
            }
        }
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let viewArray = NSBundle.mainBundle().loadNibNamed("FTTHomeResultAddTipsCell", owner: self, options: nil)
        
        let fundCellViewArray = NSBundle.mainBundle().loadNibNamed("FTTHomeResultFundCell", owner: self, options: nil)
        
        let section = indexPath.section
        let tempArray = self.model?.items![section]
        if section == 0{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    var tipsCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultAddTipsCell")
                    if tipsCell == nil{
                        tipsCell = viewArray[0] as! FTTHomeResultAddTipsCell
                    }
                    tipsCell!.selectionStyle = .None
                    return tipsCell!
                }else if item is FTTHomeResultFundItem{
                    var fundCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultFundCell") as? FTTHomeResultFundCell
                    if fundCell == nil{
                        fundCell = fundCellViewArray[0] as? FTTHomeResultFundCell
                    }
                    fundCell?.selectionStyle = .None
                    fundCell?.item = item as? FTTHomeResultFundItem
                    fundCell?.setCellWithItem()
                    return fundCell!
                }
            }
        }else if section == 1{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    var tipsCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultAddTipsCell")
                    if tipsCell == nil{
                        tipsCell = viewArray[0] as? FTTHomeResultAddTipsCell
                    }
                    tipsCell?.selectionStyle = .None
                    return tipsCell!
                }else if item is FTTHomeResultFundItem{
                    var fundCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultFundCell") as? FTTHomeResultFundCell
                    if fundCell == nil{
                        fundCell = fundCellViewArray[0] as? FTTHomeResultFundCell
                    }
                    fundCell?.selectionStyle = .None
                    fundCell?.item = item as? FTTHomeResultFundItem
                    fundCell?.setCellWithItem()
                    return fundCell!
                }
            }
        }else if section == 2{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    var tipsCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultAddTipsCell")
                    if tipsCell == nil{
                        tipsCell = viewArray[0] as? FTTHomeResultAddTipsCell
                    }
                    tipsCell?.selectionStyle = .None
                    return tipsCell!
                }else if item is FTTHomeResultFundItem{
                    var fundCell = tableView.dequeueReusableCellWithIdentifier("FTTHomeResultFundCell") as? FTTHomeResultFundCell
                    if fundCell == nil{
                        fundCell = fundCellViewArray[0] as? FTTHomeResultFundCell
                    }
                    fundCell?.selectionStyle = .None
                    fundCell?.item = item as? FTTHomeResultFundItem
                    fundCell?.setCellWithItem()
                    return fundCell!
                }
            }
        }
        
        let cell = UITableViewCell(style:.Default, reuseIdentifier:"Identifier")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let tempArray = self.model?.items![section]
        if section == 0{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    return
                }else if item is FTTHomeResultFundItem{
                    self.openFundDetailPage(item as? FTTHomeResultFundItem)
                }
            }
        }else if section == 1{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    return
                }else if item is FTTHomeResultFundItem{
                    self.openFundDetailPage(item as? FTTHomeResultFundItem)
                }
            }
        }else if section == 2{
            if tempArray?.count > 0{
                let item = tempArray![indexPath.row]
                if item is FTTHomeResultAddTipsItem{
                    return
                }else if item is FTTHomeResultFundItem{
                    self.openFundDetailPage(item as? FTTHomeResultFundItem)
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let viewArray = NSBundle.mainBundle().loadNibNamed("FTTHomeResultPageSectionView", owner: self, options: nil)
        let sectionView : FTTHomeResultPageSectionView = viewArray[0] as! FTTHomeResultPageSectionView
        let item : FTTHomeResultTableSectionItem = FTTHomeResultTableSectionItem()
        if section == 0{
            item.type = The433RiskLevel.HIGHT
            item.percent = self.highPrecent
            sectionView.item = item
            sectionView.setSectionView()
            return sectionView
        }else if section == 1{
            item.type = The433RiskLevel.MID
            item.percent = self.midPrecent
            sectionView.item = item
            sectionView.setSectionView()
            return sectionView
        }else if section == 2{
            item.type = The433RiskLevel.LOW
            item.percent = self.lowPrecent
            sectionView.item = item
            sectionView.setSectionView()
            return sectionView
        }
        return UIView.init(frame: CGRectMake(0, 0, 0, 0))
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    //MARK:打开基金详情页面
    func openFundDetailPage(item : FTTHomeResultFundItem?){
        if let aItem = item{
            let param : NSMutableDictionary = NSMutableDictionary()
            param.setObject(aItem, forKey: "item")
            FTTForwardManager.sharedInstance.openFundDetailPage(self, params: param)
        }
    }
    
    //MARK:打开资产添加home页面
    func openAddFundPage() ->Void{
        FTTForwardManager.sharedInstance.openAddFundHomePage(self, params: NSMutableDictionary())
    }
    
    //MARK:打开登录页面
    func openLoginPage() -> Void{
        FTTForwardManager.sharedInstance.openLoginPage(self, params: NSMutableDictionary())
    }
    
    //MARK:打开个人中心
    func openPersonalHomePage(){
        FTTForwardManager.sharedInstance.openPersonalHomePage(self, params: NSMutableDictionary())
    }
    
    //MARK:启动时判断用户的状态来判断是否打开登录页面或者打开泡泡页面
    func startHomePageForward() -> Void{
        let userVo : FTTUserVo? = FTTDataManager().getUserVo()
        if (self.highLoadFinished == true && self.midLoadFinished == true && self.lowLoadFinished == true){
            let model : FTTHomeResultPageModel = self.model as! FTTHomeResultPageModel
            var number = 0
            for array in model.items!{
                let tempArray = array as! NSArray
                for item in tempArray{
                    if item is FTTHomeResultAddTipsItem{
                        number++
                    }
                }
            }
            
            if number != 3{
                userVo?.isNew = "false"
            }else{
                userVo?.isNew = "true"
            }
        }
        if userVo?.account?.length > 0{
            if let isNew = userVo?.isNew{
                if isNew == "true"{
                    FTTForwardManager.sharedInstance.openHomeAllTypePage(self, params: NSMutableDictionary())
                }
            }
        }else{
            FTTForwardManager.sharedInstance.openLoginPage(self, params: NSMutableDictionary())
        }
    }
}
