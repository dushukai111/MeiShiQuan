//
//  HttpRequest.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/14.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class HttpRequest: NSObject {

    static func postRequest(url:String,params:Any?,successBlock:@escaping ((_ responseData:Any?)->Void),faildBlock:@escaping ((_ errorMsg:String)->Void)){
        let manager=AFHTTPSessionManager(sessionConfiguration: .default)
        manager.requestSerializer=AFJSONRequestSerializer()
        manager.post(url, parameters: params, progress: nil, success: {(dataTask:URLSessionDataTask, responseData:Any?) in
            if(responseData==nil){
                faildBlock("请求异常")
            }else{
                let responseDic=responseData as! [String:Any]
                let code:String!=responseDic["code"] as? String
                let msg:String!=responseDic["msg"] as? String
                if let _=code{
                    if code != "0000"{
                        faildBlock(msg)
                    }else{
                        successBlock(responseDic["data"])
                    }
                }else{
                    faildBlock("返回值异常")
                }
                
            }
        }, failure: {(dataTask:URLSessionDataTask?, error:Error) in
            faildBlock("请求异常")
        })
    }
    static func getRequest(url:String,params:Any?,successBlock:@escaping ((_ responseData:Any?)->Void),faildBlock:@escaping ((_ errorMsg:String)->Void)){
        let manager=AFHTTPSessionManager(sessionConfiguration: .default)
        manager.requestSerializer=AFJSONRequestSerializer()
        manager.get(url, parameters: params, progress: nil, success: {(dataTask:URLSessionDataTask, responseData:Any?) in
            if(responseData==nil){
                faildBlock("请求异常")
            }else{
                let responseDic=responseData as! [String:Any]
                let code:String!=responseDic["code"] as? String
                let msg:String!=responseDic["msg"] as? String
                if let _=code{
                    if code != "0000"{
                        faildBlock(msg)
                    }else{
                        successBlock(responseDic["data"])
                    }
                }else{
                    faildBlock("返回值异常")
                }
                
            }
        }, failure: {(dataTask:URLSessionDataTask?, error:Error) in
            faildBlock("请求异常")
        })
    }
}
