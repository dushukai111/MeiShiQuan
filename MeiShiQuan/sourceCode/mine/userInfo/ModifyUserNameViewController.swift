//
//  ModifyUserNameViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/29.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class ModifyUserNameViewController: BasicViewController {

    private var userNameView:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.title="修改用户名"
        self.backTitle=""
        self.initViews()
        // Do any additional setup after loading the view.
    }
    func initViews(){
        let userNameContentView=UIView()
        userNameContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(userNameContentView)
        userNameContentView.autoPinEdge(toSuperviewEdge: .leading)
        userNameContentView.autoPinEdge(toSuperviewEdge: .trailing)
        userNameContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        userNameContentView.autoSetDimension(.height, toSize: 40)
        
        let userNameLabel=UILabel()
        userNameLabel.font=UIFont.systemFont(ofSize: 17.0)
        userNameLabel.text="用户名"
        userNameContentView.addSubview(userNameLabel)
        userNameLabel.autoPinEdge(.leading, to: .leading, of: userNameContentView, withOffset: 15)
        userNameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        userNameView=UITextField()
        userNameView.placeholder="请输入用户名"
        userNameView.contentVerticalAlignment = .center
        userNameView.text=UserTool.getUserName()
        userNameContentView.addSubview(userNameView)
        userNameView.autoPinEdge(.leading, to: .leading, of: userNameContentView, withOffset: 75)
        userNameView.autoPinEdge(.trailing, to: .trailing, of: userNameContentView, withOffset: -15)
        userNameView.autoPinEdge(toSuperviewEdge: .top)
        userNameView.autoPinEdge(toSuperviewEdge: .bottom)
        
        let warnLabel=UILabel()
        warnLabel.font=UIFont.systemFont(ofSize: 13.0)
        warnLabel.textColor=UIColor.gray
        warnLabel.text="用户名由字母数字下划线组成，且由字母开头"
        self.contentView.addSubview(warnLabel)
        warnLabel.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        warnLabel.autoPinEdge(.top, to: .bottom, of: userNameContentView, withOffset: 5)
        
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
        submitButton.autoPinEdge(.top, to: .bottom, of: warnLabel, withOffset: 5)
        submitButton.autoSetDimension(.height, toSize: 40)
    }
    func onSubmitButtonClick(){
        if userNameView.text=="" {
            KGProgressAlertHUD.showAlertMsg(message: "用户名不能为空", controller: self, delaySeconds: 3)
            return
        }
        self.modifyUserName()
    }
    func modifyUserName(){
        KGProgressAlertHUD.showSimpleProgress(title: "正在修改用户名..", view: self.contentView, offsetToCenterY: -64)
        let params=["userId":UserTool.getUserId(),"userName":self.userNameView.text]
        HttpRequest.postRequest(url: "\(url_serverUrl)user/modifyUserName", params: params, successBlock: {(responseData:Any?) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            
            KGProgressAlertHUD.showAlertMsg(message: "修改成功", controller: self, delaySeconds: 2)
            UserTool.setUserName(userName: self.userNameView.text)
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
