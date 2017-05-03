//
//  LoginViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/14.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class LoginViewController: BasicViewController {
    
    var userNameView:UITextField!
    var passwordView:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="用户登录"
        self.backTitle=""
        self.contentView.backgroundColor=pageBackgroundColor
        
        self.initViews()
    }
    func initViews(){
        let userNameContentView=UIView()
        userNameContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(userNameContentView)
        userNameContentView.autoPinEdge(toSuperviewEdge: .leading)
        userNameContentView.autoPinEdge(toSuperviewEdge: .trailing)
        userNameContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        userNameContentView.autoSetDimension(.height, toSize: 45)
        
        let userNameLabel=UILabel()
        userNameLabel.font=UIFont.systemFont(ofSize: 16.0)
        userNameLabel.text="手机号"
        userNameContentView.addSubview(userNameLabel)
        userNameLabel.autoPinEdge(.leading, to: .leading, of: userNameContentView, withOffset: 15)
        userNameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        userNameView=UITextField()
        userNameView.placeholder="请输入手机号"
        userNameView.contentVerticalAlignment = .center
        userNameContentView.addSubview(userNameView)
        userNameView.autoPinEdge(.leading, to: .leading, of: userNameContentView, withOffset: 75)
        userNameView.autoPinEdge(.trailing, to: .trailing, of: userNameContentView, withOffset: -15)
        userNameView.autoPinEdge(toSuperviewEdge: .top)
        userNameView.autoPinEdge(toSuperviewEdge: .bottom)
        
        let passwordContentView=UIView()
        passwordContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(passwordContentView)
        passwordContentView.autoPinEdge(toSuperviewEdge: .leading)
        passwordContentView.autoPinEdge(toSuperviewEdge: .trailing)
        passwordContentView.autoPinEdge(.top, to: .bottom, of: userNameContentView, withOffset: 1)
        passwordContentView.autoSetDimension(.height, toSize: 45)
        
        let passwordLabel=UILabel()
        passwordLabel.font=UIFont.systemFont(ofSize: 16.0)
        passwordLabel.text="密　码"
        passwordContentView.addSubview(passwordLabel)
        passwordLabel.autoPinEdge(.leading, to: .leading, of: passwordContentView, withOffset: 15)
        passwordLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        passwordView=UITextField()
        passwordView.placeholder="请输入密码"
        passwordView.contentVerticalAlignment = .center
        passwordView.isSecureTextEntry=true
        passwordContentView.addSubview(passwordView)
        passwordView.autoPinEdge(.leading, to: .leading, of: passwordContentView, withOffset: 75)
        passwordView.autoPinEdge(.trailing, to: .trailing, of: passwordContentView, withOffset: -80)
        passwordView.autoPinEdge(toSuperviewEdge: .top)
        passwordView.autoPinEdge(toSuperviewEdge: .bottom)
        
        //密码开关
        let pwdSwitch=MySwitchView()
        pwdSwitch.switchType = .security
        pwdSwitch.switchChangeBlock={[weak self](switchView:UIView,isOn:Bool) in
            self?.passwordView.isSecureTextEntry = !isOn
        }
        passwordContentView.addSubview(pwdSwitch)
        pwdSwitch.autoPinEdge(.trailing, to: .trailing, of: passwordContentView, withOffset: -10)
        pwdSwitch.autoAlignAxis(.horizontal, toSameAxisOf: passwordContentView)
        pwdSwitch.autoSetDimensions(to: CGSize(width: 60, height: 30))
        
        let submitButton=UIButton()
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeColor), for: .normal)
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeLightColor), for: .highlighted)
        submitButton.setTitle("登录", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font=UIFont.systemFont(ofSize: 16.0)
        submitButton.addTarget(self, action: #selector(onSubmitButtonClick), for: .touchUpInside)
        self.contentView.addSubview(submitButton)
        submitButton.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        submitButton.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        submitButton.autoPinEdge(.top, to: .bottom, of: passwordContentView, withOffset: 15)
        submitButton.autoSetDimension(.height, toSize: 40)
        
        //忘记密码
        let forgetPwdLabel=UILabel()
        forgetPwdLabel.font=UIFont.systemFont(ofSize: 16.0)
        forgetPwdLabel.textColor=UIColor.gray
        forgetPwdLabel.text="忘记密码？"
        forgetPwdLabel.isUserInteractionEnabled=true
        self.contentView.addSubview(forgetPwdLabel)
        forgetPwdLabel.autoPinEdge(.trailing, to: .trailing, of: submitButton)
        forgetPwdLabel.autoPinEdge(.top, to: .bottom, of: submitButton, withOffset: 10)
        
        //忘记密码手势
        let forgetPwdTap=UITapGestureRecognizer(target: self, action: #selector(onForgetPwdLabelTap))
        forgetPwdLabel.addGestureRecognizer(forgetPwdTap)
    }
    func onForgetPwdLabelTap(){
        let phoneValidate=ValidateViewController()
        phoneValidate.intent = .findPassword
        self.navigationController?.pushViewController(phoneValidate, animated: true)
    }
    func onSubmitButtonClick(){
        if self.userNameView.text=="" {
            KGProgressAlertHUD.showAlertMsg(message: "手机号不能为空", controller: self, delaySeconds: 2)
            return
        }
        if self.passwordView.text==""{
            KGProgressAlertHUD.showAlertMsg(message: "密码不能为空", controller: self, delaySeconds: 2)
            return
        }
        if !StringValidate.validatePhoneNumber(phoneNumber: self.userNameView.text!) {
            KGProgressAlertHUD.showAlertMsg(message: "手机号格式不正确", controller: self, delaySeconds: 2)
            return
        }
        self.login()
    }
    private func login(){
        KGProgressAlertHUD.showSimpleProgress(title: "登录中..", view: self.contentView, offsetToCenterY: -64)
        let params=["phoneNumber":self.userNameView.text,"password":self.passwordView.text]
        HttpRequest.postRequest(url: "\(url_serverUrl)user/userLogin", params: params, successBlock: {(responseData:Any?) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            
            if let responseDic = responseData as? [String:Any]{
                UserTool.setLogin()
                UserTool.setUserId(userId: responseDic["userId"])
                UserTool.setPhoneNumber(phoneNumber: self.userNameView.text)
                UserTool.setPassword(password: self.passwordView.text)
                UserTool.setUserName(userName: responseDic["userName"])
                UserTool.setHeadUrl(headUrl: responseDic["headUrl"])
                UserTool.setEmail(email: responseDic["email"])
                KGProgressAlertHUD.showAlertMsg(message: "登录成功", controller: self, delaySeconds: 2)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                KGProgressAlertHUD.showAlertMsg(message: "返回数据异常", controller: self, delaySeconds: 2)
            }
            
        }, faildBlock: {(errorMsg:String) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: errorMsg, controller: self, delaySeconds: 2)
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
