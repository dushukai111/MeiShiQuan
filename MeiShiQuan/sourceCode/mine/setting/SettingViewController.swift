//
//  SettingViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/12/17.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class SettingViewController: BasicViewController {

    private var imgQualityLabel:UILabel!
    private var cacheLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="设置"
        self.backTitle=""
        self.contentView.backgroundColor=pageBackgroundColor
        self.initViews()
        self.initContent()
    }
    func initViews(){
        //推送通知
        let notificationContentView=UIView()
        notificationContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(notificationContentView)
        notificationContentView.autoPinEdge(toSuperviewEdge: .leading)
        notificationContentView.autoPinEdge(toSuperviewEdge: .trailing)
        notificationContentView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 15)
        notificationContentView.autoSetDimension(.height, toSize: 40)
        
        let notificationLabel=UILabel()
        notificationLabel.font=UIFont.systemFont(ofSize: 16.0)
        notificationLabel.text="推送通知"
        notificationContentView.addSubview(notificationLabel)
        notificationLabel.autoPinEdge(.leading, to: .leading, of: notificationContentView, withOffset: 15)
        notificationLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        let notificationSwitch=MySwitchView()
        notificationSwitch.isOn=true
        notificationSwitch.translatesAutoresizingMaskIntoConstraints=false
        notificationSwitch.switchChangeBlock={(pwdSwitch:UIView,isSwitchOn:Bool)in
            print(isSwitchOn)
        }
        notificationContentView.addSubview(notificationSwitch)
        notificationSwitch.autoPinEdge(.trailing, to: .trailing, of: notificationContentView, withOffset: -10)
        notificationSwitch.autoAlignAxis(.horizontal, toSameAxisOf: notificationContentView)
        notificationSwitch.autoSetDimensions(to: CGSize(width: 60, height: 30))
        
        //非wifi下图片质量
        let imageQualityContentView=UIView()
        imageQualityContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(imageQualityContentView)
        imageQualityContentView.autoPinEdge(toSuperviewEdge: .leading)
        imageQualityContentView.autoPinEdge(toSuperviewEdge: .trailing)
        imageQualityContentView.autoPinEdge(.top, to: .bottom, of: notificationContentView, withOffset: 1)
        imageQualityContentView.autoSetDimension(.height, toSize: 40)
        //添加单击手势
        let imageQualityTap=UITapGestureRecognizer(target: self, action: #selector(onImageQualityTap))
        imageQualityContentView.addGestureRecognizer(imageQualityTap)
        
        let imageQualityLabel=UILabel()
        imageQualityLabel.font=UIFont.systemFont(ofSize: 16.0)
        imageQualityLabel.text="非wifi下图片质量"
        imageQualityContentView.addSubview(imageQualityLabel)
        imageQualityLabel.autoPinEdge(.leading, to: .leading, of: imageQualityContentView, withOffset: 15)
        imageQualityLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        imgQualityLabel=UILabel()
        imgQualityLabel.font=UIFont.systemFont(ofSize: 16.0)
        imgQualityLabel.textColor=UIColor.gray
        imgQualityLabel.translatesAutoresizingMaskIntoConstraints=false
        imageQualityContentView.addSubview(imgQualityLabel)
        imgQualityLabel.autoPinEdge(.trailing, to: .trailing, of: imageQualityContentView, withOffset: -15)
        imgQualityLabel.autoAlignAxis(.horizontal, toSameAxisOf: imageQualityContentView)
        
        //清除图片缓存
        let clearCacheContentView=UIView()
        clearCacheContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(clearCacheContentView)
        clearCacheContentView.autoPinEdge(toSuperviewEdge: .leading)
        clearCacheContentView.autoPinEdge(toSuperviewEdge: .trailing)
        clearCacheContentView.autoPinEdge(.top, to: .bottom, of: imageQualityContentView, withOffset: 1)
        clearCacheContentView.autoSetDimension(.height, toSize: 40)
        //添加单击手势
        let clearCacheTap=UITapGestureRecognizer(target: self, action: #selector(onClearCacheTap))
        clearCacheContentView.addGestureRecognizer(clearCacheTap)
        
        let clearCacheLabel=UILabel()
        clearCacheLabel.font=UIFont.systemFont(ofSize: 16.0)
        clearCacheLabel.text="清除图片缓存"
        clearCacheContentView.addSubview(clearCacheLabel)
        clearCacheLabel.autoPinEdge(.leading, to: .leading, of: clearCacheContentView, withOffset: 15)
        clearCacheLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        cacheLabel=UILabel()
        cacheLabel.font=UIFont.systemFont(ofSize: 16.0)
        cacheLabel.textColor=UIColor.gray
        cacheLabel.translatesAutoresizingMaskIntoConstraints=false
        clearCacheContentView.addSubview(cacheLabel)
        cacheLabel.autoPinEdge(.trailing, to: .trailing, of: clearCacheContentView, withOffset: -15)
        cacheLabel.autoAlignAxis(.horizontal, toSameAxisOf: clearCacheContentView)
        
        //关于
        let aboutContentView=UIView()
        aboutContentView.backgroundColor=UIColor.white
        self.contentView.addSubview(aboutContentView)
        aboutContentView.autoPinEdge(toSuperviewEdge: .leading)
        aboutContentView.autoPinEdge(toSuperviewEdge: .trailing)
        aboutContentView.autoPinEdge(.top, to: .bottom, of: clearCacheContentView, withOffset: 8)
        aboutContentView.autoSetDimension(.height, toSize: 40)
        
        let aboutLabel=UILabel()
        aboutLabel.font=UIFont.systemFont(ofSize: 16.0)
        aboutLabel.text="关于美食圈"
        aboutContentView.addSubview(aboutLabel)
        aboutLabel.autoPinEdge(.leading, to: .leading, of: clearCacheContentView, withOffset: 15)
        aboutLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        //退出登录
        if UserTool.isLogin() {
            let logoutButton=UIButton()
            logoutButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)), for: .normal)
            logoutButton.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth-20,height:40), color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)), for: .highlighted)
            logoutButton.setTitle("退出登录", for: .normal)
            logoutButton.setTitleColor(UIColor.white, for: .normal)
            logoutButton.titleLabel?.font=UIFont.systemFont(ofSize: 16.0)
            logoutButton.addTarget(self, action: #selector(logoutButtonClick), for: .touchUpInside)
            self.contentView.addSubview(logoutButton)
            logoutButton.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
            logoutButton.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
            logoutButton.autoPinEdge(.top, to: .bottom, of: aboutContentView, withOffset: 15)
            logoutButton.autoSetDimension(.height, toSize: 40)
        }
        
    }
    //初始化显示内容
    func initContent(){
        //获取图片缓存所占空间，单位byte
        let cacheBytes=SDImageCache.shared().getSize()
        var cacheSizeStr:String?
        if cacheBytes>1024*1024 {
            cacheSizeStr="\(cacheBytes/1024/1024)MB"
        }else{
            cacheSizeStr="\(cacheBytes/1024)KB"
        }
        //初始化图片缓存信息
        cacheLabel.text=cacheSizeStr
        
        //初始化图片质量信息
        imgQualityLabel.text=UserTool.getImageQuality()
    }
    func onImageQualityTap(){
        let imageQualitys=["普通","高质量"]
        let alertView=SelectionAlertView(title: "图片质量", items: imageQualitys)
        alertView.completeSelectionBlock={[weak self](selectIndex:Int) in
            UserTool.setImageQuality(qualityDis: imageQualitys[selectIndex])
            self?.imgQualityLabel.text=imageQualitys[selectIndex]
        }
        alertView.show()
    }
    func onClearCacheTap(){
        SDImageCache.shared().clearDisk {
            KGProgressAlertHUD.showAlertMsg(message: "清理成功", controller: self, delaySeconds: 2)
            self.cacheLabel.text="0KB"
        }
    }
    func logoutButtonClick(){
        let alertController=UIAlertController(title: "提示", message: "确定退出登录？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (alertAction:UIAlertAction) in
            KGProgressAlertHUD.showSimpleProgress(title: "正在退出登录..", view: self.contentView, offsetToCenterY: -64)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
                UserTool.logout()
                self.navigationController?.popViewController(animated: true)
            })
            
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
