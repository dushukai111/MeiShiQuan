//
//  PhoneValidateViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/20.
//  Copyright © 2016年 dushukai. All rights reserved.
//  验证码页面，用于邮箱验证，手机号验证

import UIKit
//验证目的，修改邮箱，修改手机号，找回密码
enum ValidateIntent{
    case modifyEmail,modifyPhone,findPassword
}
class ValidateViewController: BasicViewController {

    public var intent:ValidateIntent = .findPassword  //目的
    private var phoneNumberView:UITextField!
    private var validateCodeView:UITextField!
    private var sendValidateCodeButton:UIButton!
    private let invalidateTime=60
    private var seconds=0
    private var titleStr:String!
    private var label:String!
    private var placeHolder:String!
    private var btnTitle:String!
    private var alertStr:String!
    private var textFieldStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.intent == .findPassword {
            textFieldStr=UserTool.getPhoneNumber()
            titleStr="找回密码"
            label="手机号"
            placeHolder="请输入手机号"
            btnTitle="下一步"
            alertStr="请输入手机号"
        }else if self.intent == .modifyEmail{
            textFieldStr=UserTool.getEmail()
            titleStr="修改邮箱"
            label="邮　箱"
            placeHolder="请输入邮箱"
            btnTitle="修改邮箱"
            alertStr="请输入邮箱"
        }else if self.intent == .modifyPhone{
            textFieldStr=UserTool.getPhoneNumber()
            titleStr="修改手机号"
            label="手机号"
            placeHolder="请输入手机号"
            btnTitle="修改手机号"
            alertStr="请输入手机号"
        }
        self.title=titleStr
        self.backTitle=""
        self.contentView.backgroundColor=pageBackgroundColor
        self.initViews()
    }
    func initViews(){
        let phoneNumberContentView=UIView()
        phoneNumberContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(phoneNumberContentView)
        phoneNumberContentView.autoPinEdge(toSuperviewEdge: .leading)
        phoneNumberContentView.autoPinEdge(toSuperviewEdge: .trailing)
        phoneNumberContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        phoneNumberContentView.autoSetDimension(.height, toSize: 45)
        
        let phoneNumberLabel=UILabel()
        phoneNumberLabel.font=UIFont.systemFont(ofSize: 16.0)
        phoneNumberLabel.text=label
        phoneNumberContentView.addSubview(phoneNumberLabel)
        phoneNumberLabel.autoPinEdge(.leading, to: .leading, of: phoneNumberContentView, withOffset: 15)
        phoneNumberLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        phoneNumberView=UITextField()
        phoneNumberView.placeholder=placeHolder
        phoneNumberView.contentVerticalAlignment = .center
        phoneNumberView.text=textFieldStr
        phoneNumberContentView.addSubview(phoneNumberView)
        phoneNumberView.autoPinEdge(.leading, to: .leading, of: phoneNumberContentView, withOffset: 75)
        phoneNumberView.autoPinEdge(.trailing, to: .trailing, of: phoneNumberContentView, withOffset: -15)
        phoneNumberView.autoPinEdge(toSuperviewEdge: .top)
        phoneNumberView.autoPinEdge(toSuperviewEdge: .bottom)
        
        let validateCodeContentView=UIView()
        validateCodeContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(validateCodeContentView)
        validateCodeContentView.autoPinEdge(toSuperviewEdge: .leading)
        validateCodeContentView.autoPinEdge(toSuperviewEdge: .trailing)
        validateCodeContentView.autoPinEdge(.top, to: .bottom, of: phoneNumberContentView, withOffset: 1)
        validateCodeContentView.autoSetDimension(.height, toSize: 50)
        
        let validateCodeLabel=UILabel()
        validateCodeLabel.font=UIFont.systemFont(ofSize: 16.0)
        validateCodeLabel.text="验证码"
        validateCodeContentView.addSubview(validateCodeLabel)
        validateCodeLabel.autoPinEdge(.leading, to: .leading, of: validateCodeContentView, withOffset: 15)
        validateCodeLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        validateCodeView=UITextField()
        validateCodeView.placeholder="请输入验证码"
        validateCodeView.contentVerticalAlignment = .center
        validateCodeView.isSecureTextEntry=true
        validateCodeContentView.addSubview(validateCodeView)
        validateCodeView.autoPinEdge(.leading, to: .leading, of: validateCodeContentView, withOffset: 75)
        validateCodeView.autoPinEdge(.trailing, to: .trailing, of: validateCodeContentView, withOffset: -100)
        validateCodeView.autoPinEdge(toSuperviewEdge: .top)
        validateCodeView.autoPinEdge(toSuperviewEdge: .bottom)
        
        //获取验证码按钮
        sendValidateCodeButton=UIButton()
        sendValidateCodeButton.setTitle("获取验证码", for: .normal)
        sendValidateCodeButton.setTitleColor(UIColor.white, for: .normal)
        sendValidateCodeButton.titleLabel?.font=UIFont.systemFont(ofSize: 14.0)
        sendValidateCodeButton.setBackgroundImage(Tools.image(size: CGSize(width:100,height:40), color: appThemeColor), for: .normal)
        sendValidateCodeButton.setBackgroundImage(Tools.image(size: CGSize(width:100,height:40), color: appThemeLightColor), for: .highlighted)
        sendValidateCodeButton.addTarget(self, action: #selector(onValidateButtonClick), for: .touchUpInside)
        validateCodeContentView.addSubview(sendValidateCodeButton)
        sendValidateCodeButton.autoPinEdge(.trailing, to: .trailing, of: validateCodeContentView, withOffset: -10)
        sendValidateCodeButton.autoPinEdge(.top, to: .top, of: validateCodeContentView, withOffset: 5)
        sendValidateCodeButton.autoPinEdge(.bottom, to: .bottom, of: validateCodeContentView, withOffset: -5)
        sendValidateCodeButton.autoSetDimension(.width, toSize: 80)
        
        
        let submitButton=UIButton()
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeColor), for: .normal)
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeLightColor), for: .highlighted)
        submitButton.setTitle(btnTitle, for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font=UIFont.systemFont(ofSize: 16.0)
        submitButton.addTarget(self, action: #selector(onSubmitButtonClick), for: .touchUpInside)
        self.contentView.addSubview(submitButton)
        submitButton.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        submitButton.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        submitButton.autoPinEdge(.top, to: .bottom, of: validateCodeContentView, withOffset: 15)
        submitButton.autoSetDimension(.height, toSize: 40)
    }
    func onValidateButtonClick(){
        if phoneNumberView.text=="" {
            KGProgressAlertHUD.showAlertMsg(message: alertStr, controller: self, delaySeconds: 2)
            return
        }
        let validateType=self.intent == .modifyEmail ?"2" : "1"
        let url="\(url_serverUrl)user/sendValidateCode"
        let params=["validateContent":phoneNumberView.text!,"validateType":validateType]
        KGProgressAlertHUD.showSimpleProgress(title: "正在发送验证码..", view: self.contentView, offsetToCenterY: -64)
        HttpRequest.postRequest(url: url, params: params, successBlock: {(responseData:Any?) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: "验证码发送成功", controller: self, delaySeconds: 2)
            self.seconds=self.invalidateTime
            self.sendValidateCodeButton.isEnabled=false
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.repeatTimer), userInfo: nil, repeats: true)
            
        }, faildBlock: {(errorMsg:String) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: errorMsg, controller: self, delaySeconds: 2)
        })
        
    }
    func repeatTimer(timer:Timer){
        seconds-=1
        sendValidateCodeButton.setTitle("已发送(\(seconds)s)", for: .normal)
        if seconds==0 {
            timer.invalidate()
            seconds=invalidateTime
            sendValidateCodeButton.isEnabled=true
            sendValidateCodeButton.setTitle("重新发送", for: .normal)
        }
    }
    func onSubmitButtonClick(){
        if phoneNumberView.text=="" {
            KGProgressAlertHUD.showAlertMsg(message: alertStr, controller: self, delaySeconds: 2)
            return
        }
        if validateCodeView.text=="" {
            KGProgressAlertHUD.showAlertMsg(message: "请输入验证码", controller: self, delaySeconds: 2)
            return
        }
        let url="\(url_serverUrl)user/checkValidateCode"
        let params=["validateContent":phoneNumberView.text!,"validateCode":validateCodeView.text!]
        KGProgressAlertHUD.showSimpleProgress(title: "正在校验验证码..", view: self.contentView, offsetToCenterY: -64)
        HttpRequest.postRequest(url: url, params: params, successBlock: {(responseData:Any?) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            if self.intent == .modifyEmail{
                self.modifyEmail()
            }
            
        }, faildBlock: {(errorMsg:String) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: errorMsg, controller: self, delaySeconds: 2)
        })
    }
    func modifyEmail(){
        KGProgressAlertHUD.showSimpleProgress(title: "正在修改邮箱..", view: self.contentView, offsetToCenterY: -64)
        let params=["userId":UserTool.getUserId(),"email":phoneNumberView.text]
        HttpRequest.postRequest(url: "\(url_serverUrl)user/modifyEmail", params: params, successBlock: {(responseData:Any?) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            
            KGProgressAlertHUD.showAlertMsg(message: "修改成功", controller: self, delaySeconds: 2)
            UserTool.setEmail(email: self.phoneNumberView.text)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.navigationController?.popViewController(animated: true)
            })
            
        }, faildBlock: {(errorMsg:String) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: errorMsg, controller: self, delaySeconds: 3)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
