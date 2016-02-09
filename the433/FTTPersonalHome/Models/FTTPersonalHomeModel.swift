//
//  FTTPersonalHomeModel.swift
//  the433
//
//  Created by 黄元庆 on 16/1/16.
//  Copyright © 2016年 tuan800. All rights reserved.
//

import UIKit

class FTTPersonalHomeModel: FTTBaseModel {
    var service : FTTPersonalHomeService?
    override init() {
        super.init()
        self.service = FTTPersonalHomeService()
    }
    
    override func loadItems() {
        if let vo : FTTUserVo = FTTDataManager().getUserVo(){
            self.items?.removeAllObjects()
            if let nickName = vo.nickName{
                let nickNameItem : FTTPersonalCommonItem = FTTPersonalCommonItem()
                nickNameItem.title = "昵称"
                nickNameItem.detail = nickName as String
                nickNameItem.itemTag = .NICKNAME
                self.items?.addObject(nickNameItem)
            }else{
                let tempNickNameItem : FTTPersonalCommonItem = FTTPersonalCommonItem()
                tempNickNameItem.title = "昵称"
                tempNickNameItem.detail = "恭喜发财"
                tempNickNameItem.itemTag = .NICKNAME
                self.items?.addObject(tempNickNameItem)
            }
            if let phone = vo.account{
                let phoneItem : FTTPersonalCommonItem = FTTPersonalCommonItem()
                phoneItem.title = "手机号"
                phoneItem.detail = phone as String
                phoneItem.itemTag = .PHONE
                self.items?.addObject(phoneItem)
            }
        }
    }
    
    ///修改昵称
    func sendChangeNickNameRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.changeNickName(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                completion(retDict)
                }, failed: {
                    (faileDict : NSDictionary)in
                    failed(faileDict)
            })
    }
}
