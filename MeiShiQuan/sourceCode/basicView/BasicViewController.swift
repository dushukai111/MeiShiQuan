//
//  BasicViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/31.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController,UIGestureRecognizerDelegate {

    private var titleLabel:UILabel!
    private var naviBackView:UIView!
    private var backIcon:UIImageView!
    private var backLabel:UILabel!
    var navigationBar:UIView!
    var contentView:UIView!
    override var title: String?{
        didSet{
            if let _=self.titleLabel{
                self.titleLabel.text=title
            }
            
        }
    }
    var backTitle:String=""{
        didSet{
            if let _=self.backLabel{
                self.backLabel.text=backTitle
            }
        }
    }
    var isTitleHidden=false{
        didSet{
            if let _=self.titleLabel{
                self.titleLabel.isHidden=isTitleHidden
            }
            
        }
    }
    var isBackButtonHidden=false{
        didSet{
            if let _=self.naviBackView{
                self.naviBackView.isHidden=isBackButtonHidden
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        self.initNavigationBar()
        // Do any additional setup after loading the view.
        self.contentView=UIView()
//        self.contentView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.view.addSubview(self.contentView)
        self.contentView.autoPinEdge(.leading, to: .leading, of: self.view)
        self.contentView.autoPinEdge(.top, to: .bottom, of: self.navigationBar)
        self.contentView.autoPinEdge(.trailing, to: .trailing, of: self.view)
        self.contentView.autoPinEdge(.bottom, to: .bottom, of: self.view)
        
        let tap=UITapGestureRecognizer(target: self, action: nil)
        tap.delegate=self
        self.contentView.addGestureRecognizer(tap)
    }
    func initNavigationBar(){
        navigationBar=UIView()
        navigationBar.backgroundColor=appThemeColor
        self.view.addSubview(navigationBar)
        navigationBar.autoPinEdge(toSuperviewEdge: .leading)
        navigationBar.autoPinEdge(toSuperviewEdge: .top)
        navigationBar.autoPinEdge(toSuperviewEdge: .trailing)
        navigationBar.autoSetDimension(.height, toSize: navigationBarHeight)
        
        self.titleLabel=UILabel()
        self.titleLabel.font=UIFont.systemFont(ofSize: navigationBarTitleFontSize)
        self.titleLabel.textColor=UIColor.white
        self.titleLabel.isHidden=isTitleHidden
        self.titleLabel.text=self.title
        navigationBar.addSubview(self.titleLabel)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        self.titleLabel.autoSetDimension(.height, toSize: 44.0)
        
        self.naviBackView=UIView()
        self.naviBackView.isHidden=isBackButtonHidden
        navigationBar.addSubview(self.naviBackView)
        self.naviBackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        self.naviBackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 7)
        self.naviBackView.autoSetDimension(.height, toSize: 30.0)
        //添加手势
        let naviBackViewTap=UITapGestureRecognizer(target: self, action: #selector(onBackButtonPressed))
        self.naviBackView.addGestureRecognizer(naviBackViewTap)
        
        self.backIcon=UIImageView()
        self.backIcon.image=UIImage(named: "navi_back_icon")
        self.backIcon.isUserInteractionEnabled=true
        self.naviBackView.addSubview(self.backIcon)
        self.backIcon.autoPinEdge(toSuperviewEdge: .leading)
        self.backIcon.autoAlignAxis(.horizontal, toSameAxisOf: self.naviBackView)
        self.backIcon.autoSetDimensions(to: CGSize(width:25,height:25))
        
        self.backLabel=UILabel()
        self.backLabel.font=UIFont.boldSystemFont(ofSize: navigationBarTintFontSize)
        self.backLabel.textColor=UIColor.white
        self.backLabel.text=backTitle
        self.naviBackView.addSubview(self.backLabel)
        self.backLabel.autoPinEdge(.leading, to: .trailing, of: self.backIcon)
        self.backLabel.autoPinEdge(toSuperviewEdge: .trailing)
        self.backLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.backIcon)
        
        
    }
    func onBackButtonPressed(){
        _=self.navigationController?.popViewController(animated: true)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        UIApplication.shared.keyWindow?.endEditing(true)
        return false
        
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
