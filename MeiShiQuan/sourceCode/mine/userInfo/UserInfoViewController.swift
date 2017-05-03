//
//  UserInfoViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/29.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class UserInfoViewController: BasicViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUserInfo()
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
    func setUserInfo(){
        if let headUrl=UserTool.getHeadUrl(){
            userHeadView.sd_setImage(with: URL(string:headUrl), placeholderImage: UIImage(named: "defaultHead"))
        }
        
        userNameView.text=UserTool.getUserName()==nil||UserTool.getUserName()=="" ? "未设置":UserTool.getUserName()
        emailView.text=UserTool.getEmail()==nil||UserTool.getEmail()=="" ? "未设置":UserTool.getEmail()
    }
    func onUserHeadRowTap(){
        let selectionView=SelectionAlertView(title: "上传/修改头像", items: ["拍照","从相册选择"])
        selectionView.show()
        selectionView.completeSelectionBlock={(selectedIndex:Int) in
            let imagePicker=UIImagePickerController()
            if selectedIndex==0 {
                imagePicker.sourceType = .camera
            }else{
                imagePicker.sourceType = .photoLibrary
            }
            imagePicker.delegate=self
            imagePicker.allowsEditing=true
            self.navigationController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image=info["UIImagePickerControllerOriginalImage"] as! UIImage
        var width:CGFloat=image.size.width
        var height:CGFloat=image.size.height
        if width>100{
            width=100
            height=width*(image.size.height/image.size.width)
        }
        if height>100 {
            height=100
            width=height*(image.size.width/image.size.height)
        }
        let scaleImage=Tools.scaleImage(image: image, size: CGSize(width:width,height:height))
        let imageData=UIImagePNGRepresentation(scaleImage!)
        KGProgressAlertHUD.showSimpleProgress(title: "正在上传头像..", view: self.contentView, offsetToCenterY: -64)
        let manager=AFHTTPSessionManager(sessionConfiguration: .default)
        print(UserTool.getHeadUrl())
        manager.post("\(url_serverUrl)user/updateUserHead", parameters: ["userId",(UserTool.getUserId())!], constructingBodyWith: {(formData:AFMultipartFormData) in
            formData.appendPart(withForm: (UserTool.getUserId()?.data(using: .utf8))!, name: "userId")
            formData.appendPart(withFileData: imageData!, name: "headImage", fileName: "headImage1", mimeType: "image/jpeg")
        }, progress: nil, success: {(dataTask:URLSessionDataTask,responseData:Any?)in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            let responseDic=responseData as? [String:Any]
            if let resultDic=responseDic{
                let code=resultDic["code"] as? String
                let msg=resultDic["msg"] as? String
                let data=resultDic["data"] as? [String:String]
                if code=="0000"{
                    let headUrl=data?["headUrl"]
                    UserTool.setHeadUrl(headUrl: headUrl)
                    print(UserTool.getHeadUrl())
                    self.setUserInfo()
                    KGProgressAlertHUD.showAlertMsg(message: "修改头像成功", controller: self, delaySeconds: 3)
                }else{
                    KGProgressAlertHUD.showAlertMsg(message: msg, controller: self, delaySeconds: 3)
                }
            }else{
                KGProgressAlertHUD.showAlertMsg(message: "返回数据异常", controller: self, delaySeconds: 3)
            }
        }, failure: {(dataTask:URLSessionDataTask?,error:Error) in
            KGProgressAlertHUD.dismissProgressView(view: self.contentView)
            KGProgressAlertHUD.showAlertMsg(message: "修改头像异常", controller: self, delaySeconds: 3)
        })
    }
    func onUserNameRowTap(){
        let modifyUserNameVC=ModifyUserNameViewController()
        self.navigationController?.pushViewController(modifyUserNameVC, animated: true)
    }
    func onEmailRowTap(){
        let validateVC=ValidateViewController()
        validateVC.intent = .modifyEmail
        self.navigationController?.pushViewController(validateVC, animated: true)
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
