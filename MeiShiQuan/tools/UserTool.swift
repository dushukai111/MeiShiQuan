//
//  UserTool.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/14.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class UserTool: NSObject {

    static let param_isLogin="isLogin"
    static let param_userId="userId"
    static let param_phoneNumber="phoneNumber"
    static let param_userName="userName"
    static let param_password="password"
    static let param_headUrl="headUrl"
    static let param_email="email"
    static let param_imageQuality="imageQuality"
    static func isLogin()->Bool{
        let userDefaults=UserDefaults.standard
        let isLogin=userDefaults.bool(forKey: param_isLogin)
        return isLogin
    }
    static func setLogin(){
        let userDefaults=UserDefaults.standard
        userDefaults.set(true, forKey: param_isLogin)
        userDefaults.synchronize()
    }
    static func logout(){
        let userDefaults=UserDefaults.standard
        userDefaults.removeObject(forKey: param_isLogin)
        userDefaults.removeObject(forKey: param_userId)
        userDefaults.removeObject(forKey: param_phoneNumber)
        userDefaults.removeObject(forKey: param_userName)
        userDefaults.removeObject(forKey: param_password)
        userDefaults.removeObject(forKey: param_email)
        userDefaults.synchronize()
    }
    static func setUserId(userId:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(userId, forKey: param_userId)
        userDefaults.synchronize()
    }
    static func getUserId()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_userId)
    }
    static func setUserName(userName:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(userName, forKey: param_userName)
        userDefaults.synchronize()
    }
    static func getUserName()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_userName)
    }
    static func setPhoneNumber(phoneNumber:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(phoneNumber, forKey: param_phoneNumber)
        userDefaults.synchronize()
    }
    static func getPhoneNumber()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_phoneNumber)
    }
    static func setPassword(password:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(password, forKey: param_password)
        userDefaults.synchronize()
    }
    static func getPassword()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_password)
    }
    static func setHeadUrl(headUrl:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(headUrl, forKey: param_headUrl)
        userDefaults.synchronize()
    }
    static func getHeadUrl()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_headUrl)
    }
    static func setEmail(email:Any?){
        let userDefaults=UserDefaults.standard
        userDefaults.set(email, forKey: param_email)
        userDefaults.synchronize()
    }
    static func getEmail()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_email)
    }
    static func setImageQuality(qualityDis:String){
        let userDefaults=UserDefaults.standard
        userDefaults.set(qualityDis, forKey: param_imageQuality)
        userDefaults.synchronize()
    }
    static func getImageQuality()->String?{
        let userDefaults=UserDefaults.standard
        return userDefaults.string(forKey: param_imageQuality)
    }
}
