//
//  ModifyEmailViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/29.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class ModifyEmailViewController: BasicViewController {

    private var emailView:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.title="修改邮箱"
        self.backTitle=""
        self.initViews()
        
        let backViewTap=UITapGestureRecognizer(target: self, action: #selector(onBackViewTap))
        self.contentView.addGestureRecognizer(backViewTap)
        // Do any additional setup after loading the view.
    }
    func onBackViewTap(){
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    func initViews(){
        let emailContentView=UIView()
        emailContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(emailContentView)
        emailContentView.autoPinEdge(toSuperviewEdge: .leading)
        emailContentView.autoPinEdge(toSuperviewEdge: .trailing)
        emailContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        emailContentView.autoSetDimension(.height, toSize: 40)
        
        let emailLabel=UILabel()
        emailLabel.font=UIFont.systemFont(ofSize: 17.0)
        emailLabel.text="邮   箱"
        emailContentView.addSubview(emailLabel)
        emailLabel.autoPinEdge(.leading, to: .leading, of: emailContentView, withOffset: 15)
        emailLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        emailView=UITextField()
        emailView.placeholder="请输入邮箱"
        emailView.contentVerticalAlignment = .center
        emailContentView.addSubview(emailView)
        emailView.autoPinEdge(.leading, to: .leading, of: emailContentView, withOffset: 75)
        emailView.autoPinEdge(.trailing, to: .trailing, of: emailContentView, withOffset: -15)
        emailView.autoPinEdge(toSuperviewEdge: .top)
        emailView.autoPinEdge(toSuperviewEdge: .bottom)
        
        
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
        submitButton.autoPinEdge(.top, to: .bottom, of: emailContentView, withOffset: 15)
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
