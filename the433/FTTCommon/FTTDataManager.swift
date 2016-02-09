//
//  FTTDataManager.swift
//  the433
//
//  Created by tuan800 on 15/11/23.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTDataManager: NSObject {
    override init() {
        super.init()
        print("沙盒路径:\(documentsDirectory())")
        print("文件路径:\(dataFilePath())")
    }
    
    ///存储最新的uservo
    func saveUserVo(oneVo : FTTUserVo) -> Void{
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //将lists以对应Checklist关键字进行编码
        if let userVo : FTTUserVo = oneVo{
            archiver.encodeObject(userVo, forKey: FTTUSERVO)
            //编码结束
            archiver.finishEncoding()
            //数据写入
            data.writeToFile(dataFilePath(), atomically: true)
        }
        
    }
    
    ///获取uservo
    func getUserVo() -> FTTUserVo{
        var userVo : FTTUserVo = FTTUserVo()
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = NSFileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExistsAtPath(path) {
            //读取文件数据
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            //通过归档时设置的关键字Checklist还原lists
            userVo = unarchiver.decodeObjectForKey(FTTUSERVO) as! FTTUserVo
            //结束解码
            unarchiver.finishDecoding()
        }
        return userVo
    }
    
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        let documentsDirectory:String = paths[0] as String
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().stringByAppendingString("userVo.plist")
    }
    
    func saveObject(object : AnyObject ,withKey:String) -> Bool{
        NSUserDefaults.standardUserDefaults().setObject(object, forKey: withKey)
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getObject(withKey : String) -> AnyObject?{
        return NSUserDefaults.standardUserDefaults().objectForKey(withKey)
    }
    
    //存储当日日期
    func saveToday(today : String){
        self.saveObject(today, withKey: FTTTODAY)
    }
    //获取日期
    func getToday() -> String{
        let object = self.getObject(FTTTODAY)
        if let todayObject = object{
            return todayObject as! String
        }
        return ""
    }
    
    //存储最新账号
    func saveLastAccount(today : String){
        self.saveObject(today, withKey: FTTLASTACCOUNT)
    }
    //获取最新账号
    func getLastAccount() -> String{
        let object = self.getObject(FTTLASTACCOUNT)
        if let todayObject = object{
            return todayObject as! String
        }
        return ""
    }
}
