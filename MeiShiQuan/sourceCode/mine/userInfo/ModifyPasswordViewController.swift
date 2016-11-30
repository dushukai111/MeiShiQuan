//
//  ModifyPasswordViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/30.
//  Copyright © 2016年 dushukai. All rights reserved.
//  修改密码分两种，一个是通过旧密码验证，一个是找回密码，前者比后者多一个旧密码输入框

import UIKit

enum ModifyPasswrodType{
    case findPassword,modifyPassword
}

class ModifyPasswordViewController: BasicViewController {

    var modifyType:ModifyPasswrodType = .modifyPassword
    var textFieldArray:[UITextField]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.title="修改密码"
        
        self.initUI()
        
        let tap=UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        self.contentView.addGestureRecognizer(tap)
    }
    func onViewTap(){
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    private func initUI(){
        var labelArray:[String]!=nil
        if modifyType == .modifyPassword {
            labelArray=["原  密  码","新  密  码","密码确认"]
        }else{
            labelArray=["新  密  码","密码确认"]
        }
        var referView:UIView!=self.contentView  //参照视图
        for i in 0..<labelArray.count{
            let view=UIView()
            view.backgroundColor=UIColor.white
            self.contentView.addSubview(view)
            if i==0{
                view.autoPinEdge(.top, to: .top, of: referView, withOffset: 15)
            }else{
                view.autoPinEdge(.top, to: .bottom, of: referView, withOffset: 1)
            }
            view.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 0)
            view.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
            view.autoSetDimension(.height, toSize: 40)
            
            referView=view
            
            let label=UILabel()
            label.text=labelArray[i]
            label.font=UIFont.systemFont(ofSize: 17.0)
            view.addSubview(label)
            
            label.autoPinEdge(.leading, to: .leading, of: view, withOffset: 15)
            label.autoAlignAxis(.horizontal, toSameAxisOf: view)
            
            let textField=UITextField()
            textField.placeholder="6~12位字符"
            textField.isSecureTextEntry=true
            textField.contentVerticalAlignment = .center
            view.addSubview(textField)
            textField.autoPinEdge(.leading, to: .leading, of: view, withOffset: 95)
            textField.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -65)
            textField.autoPinEdge(toSuperviewEdge: .top)
            textField.autoPinEdge(toSuperviewEdge: .bottom)
            
            textFieldArray.append(textField)
            
            let pwdSwitch=PasswordSwitch()
            pwdSwitch.tag=i
            pwdSwitch.switchChangeBlock={[weak self](switchView:UIView,isOn:Bool) in
                self?.textFieldArray[switchView.tag].isSecureTextEntry = !isOn
            }
            view.addSubview(pwdSwitch)
            pwdSwitch.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -10)
            pwdSwitch.autoAlignAxis(toSuperviewAxis: .horizontal)
            pwdSwitch.autoSetDimensions(to: CGSize(width: 50, height: 25))
            
        }
        
        
        let submitButton=UIButton()
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeColor), for: .normal)
        submitButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: appThemeLightColor), for: .highlighted)
        submitButton.setTitle("确认修改", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font=UIFont.systemFont(ofSize: 16.0)
        submitButton.addTarget(self, action: #selector(onSubmitButtonClick), for: .touchUpInside)
        self.contentView.addSubview(submitButton)
        submitButton.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        submitButton.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        submitButton.autoPinEdge(.top, to: .bottom, of: referView, withOffset: 15)
        submitButton.autoSetDimension(.height, toSize: 40)
    }
    func onSubmitButtonClick(){
        
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
