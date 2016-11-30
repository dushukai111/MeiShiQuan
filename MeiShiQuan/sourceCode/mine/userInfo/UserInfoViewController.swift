//
//  UserInfoViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/29.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class UserInfoViewController: BasicViewController {

    var userHeadView:UIImageView!
    var userNameView:UILabel!
    var emailView:UILabel!
    
    let leftLabelFontSize=CGFloat(17.0)
    let rightLabelFontSize=CGFloat(15.0)
    let leftLabelLeading=CGFloat(15)
    let rightLabelTrailing=CGFloat(-15)
    let rightLabelTextColor=UIColor.gray
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="用户信息"
        self.backTitle=""
        self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        initViews()
        // Do any additional setup after loading the view.
    }

    func initViews(){
        //头像栏
        let userHeadContentView=UIView()
        userHeadContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(userHeadContentView)
        userHeadContentView.autoPinEdge(toSuperviewEdge: .leading)
        userHeadContentView.autoPinEdge(toSuperviewEdge: .trailing)
        userHeadContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
        userHeadContentView.autoSetDimension(.height, toSize: 50)
        
        let userHeadLabel=UILabel()
        userHeadLabel.font=UIFont.systemFont(ofSize: leftLabelFontSize)
        userHeadLabel.text="头像"
        userHeadContentView.addSubview(userHeadLabel)
        userHeadLabel.autoPinEdge(.leading, to: .leading, of: userHeadContentView, withOffset: leftLabelLeading)
        userHeadLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        userHeadView=UIImageView()
        userHeadView.image=UIImage(named: "defaultHead")
        userHeadView.layer.cornerRadius=20
        userHeadView.layer.masksToBounds=true
        userHeadView.isUserInteractionEnabled=true
        userHeadContentView.addSubview(userHeadView)
        userHeadView.autoPinEdge(.trailing, to: .trailing, of: userHeadContentView, withOffset: -15)
        userHeadView.autoAlignAxis(toSuperviewAxis: .horizontal)
        userHeadView.autoSetDimensions(to: CGSize(width: 40, height: 40))
        
        let userHeadRowTap=UITapGestureRecognizer(target: self, action: #selector(onUserHeadRowTap))
        userHeadContentView.addGestureRecognizer(userHeadRowTap)
        
        //用户名栏
        let userNameContentView=UIView()
        userNameContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(userNameContentView)
        userNameContentView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 0)
        userNameContentView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
        userNameContentView.autoPinEdge(.top, to: .bottom, of: userHeadContentView, withOffset: 1)
        userNameContentView.autoSetDimension(.height, toSize: 40)
        
        let userNameRowTap=UITapGestureRecognizer(target: self, action: #selector(onUserNameRowTap))
        userNameContentView.addGestureRecognizer(userNameRowTap)
        
        let userNameLabel=UILabel()
        userNameLabel.font=UIFont.systemFont(ofSize: leftLabelFontSize)
        userNameLabel.text="用户名"
        userNameContentView.addSubview(userNameLabel)
        userNameLabel.autoPinEdge(.leading, to: .leading, of: userHeadContentView, withOffset: leftLabelLeading)
        userNameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        userNameView=UILabel()
        userNameView.font=UIFont.systemFont(ofSize: rightLabelFontSize)
        userNameView.textColor=rightLabelTextColor
        userNameView.text="kaigege"
        userNameContentView.addSubview(userNameView)
        userNameView.autoPinEdge(.trailing, to: .trailing, of: userNameContentView, withOffset: rightLabelTrailing)
        userNameView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        //邮箱栏
        let emailContentView=UIView()
        emailContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(emailContentView)
        emailContentView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 0)
        emailContentView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
        emailContentView.autoPinEdge(.top, to: .bottom, of: userNameContentView, withOffset: 1)
        emailContentView.autoSetDimension(.height, toSize: 40)
        
        let emailRowTap=UITapGestureRecognizer(target: self, action: #selector(onEmailRowTap))
        emailContentView.addGestureRecognizer(emailRowTap)
        
        let emailLabel=UILabel()
        emailLabel.font=UIFont.systemFont(ofSize: leftLabelFontSize)
        emailLabel.text="邮箱"
        emailContentView.addSubview(emailLabel)
        emailLabel.autoPinEdge(.leading, to: .leading, of: emailContentView, withOffset: leftLabelLeading)
        emailLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        emailView=UILabel()
        emailView.font=UIFont.systemFont(ofSize: rightLabelFontSize)
        emailView.textColor=rightLabelTextColor
        emailView.text="694952115@qq.com"
        emailContentView.addSubview(emailView)
        emailView.autoPinEdge(.trailing, to: .trailing, of: emailContentView, withOffset: rightLabelTrailing)
        emailView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        //修改密码栏
        let pwdContentView=UIView()
        pwdContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(pwdContentView)
        pwdContentView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 0)
        pwdContentView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
        pwdContentView.autoPinEdge(.top, to: .bottom, of: emailContentView, withOffset: 7)
        pwdContentView.autoSetDimension(.height, toSize: 40)
        
        let pwdRowTap=UITapGestureRecognizer(target: self, action: #selector(onPasswordRowTap))
        pwdContentView.addGestureRecognizer(pwdRowTap)
        
        let pwdLabel=UILabel()
        pwdLabel.font=UIFont.systemFont(ofSize: leftLabelFontSize)
        pwdLabel.text="修改密码"
        pwdContentView.addSubview(pwdLabel)
        pwdLabel.autoPinEdge(.leading, to: .leading, of: pwdContentView, withOffset: leftLabelLeading)
        pwdLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    func onUserHeadRowTap(){
        
    }
    func onUserNameRowTap(){
        let modifyUserNameVC=ModifyUserNameViewController()
        self.navigationController?.pushViewController(modifyUserNameVC, animated: true)
    }
    func onEmailRowTap(){
        let modifyEmailVC=ModifyEmailViewController()
        self.navigationController?.pushViewController(modifyEmailVC, animated: true)
    }
    func onPasswordRowTap(){
        let modifyPwdVC=ModifyPasswordViewController()
        self.navigationController?.pushViewController(modifyPwdVC, animated: true)
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
