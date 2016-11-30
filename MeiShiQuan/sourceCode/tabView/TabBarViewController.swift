//
//  TabBarViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/28.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let tabBarNormalColor=UIColor(red: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1.0)
    let tabBarSelectedColor=UIColor(red: 53/255.0, green: 124/255.0, blue: 241/255.0, alpha: 1.0)
    var titles:[String]!
    var normalIcons:[String]!
    var selectedIcons:[String]!
    var imageViews:[UIImageView]=[]
    var labels:[UILabel]=[]
    init(titles:[String],normalIcons:[String],selectedIcons:[String],viewControllers:[UIViewController]){
        self.titles=titles
        self.normalIcons=normalIcons
        self.selectedIcons=selectedIcons
        super.init(nibName: nil, bundle: nil)
        self.viewControllers=viewControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets=false //默认为true，意思是如果controller中有scrollview以及其子类视图，则自动调整他的contentInset，自动调整一般会导致显示不正常的问题，设置为false为不自动调整
        
        // Do any additional setup after loading the view.
        self.tabBar.isHidden=true
        self.initTabBarButtons()
        
    }
    func initTabBarButtons(){
        let tabBarContentView=UIView()
        self.view.addSubview(tabBarContentView)
        tabBarContentView.autoPinEdge(.leading, to: .leading, of: self.view)
        tabBarContentView.autoPinEdge(.trailing, to: .trailing, of: self.view)
        tabBarContentView.autoPinEdge(.bottom, to: .bottom, of: self.view)
        tabBarContentView.autoSetDimension(.height, toSize: tabBarHeight)
        
        //添加顶部线
        let topLine=UIView()
        topLine.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        tabBarContentView.addSubview(topLine)
        topLine.autoPinEdge(toSuperviewEdge: .leading)
        topLine.autoPinEdge(toSuperviewEdge: .top)
        topLine.autoPinEdge(toSuperviewEdge: .trailing)
        topLine.autoSetDimension(.height, toSize: 1.0)
        
        var referView=tabBarContentView //referView为参照视图，下面tabBarItemView设置leading时的参照视图，第一个参照tabBarContentView，后面的均参照前一个tabBarItemView
        for i in 0..<self.titles.count{
            //tabBarItemView用于装载icon和title
            let tabBarItemView=UIView()
            tabBarContentView.addSubview(tabBarItemView)
            tabBarItemView.autoPinEdge(.leading, to:i==0 ?.leading:.trailing , of: referView)
            tabBarItemView.autoPinEdge(toSuperviewEdge: .top)
            tabBarItemView.autoPinEdge(toSuperviewEdge: .bottom)
            tabBarItemView.autoMatch(.width, to: .width, of: tabBarContentView, withMultiplier: 1.0/CGFloat(self.titles.count))
            referView=tabBarItemView
            
            let icon=UIImageView()
            icon.image=UIImage(named: i==0 ? self.selectedIcons[i]:self.normalIcons[i])
            icon.isUserInteractionEnabled=true
            icon.tag=i
            tabBarItemView.addSubview(icon)
            self.imageViews.append(icon)
            icon.autoPinEdge(.top, to: .top, of: tabBarItemView, withOffset: 5.0)
            icon.autoAlignAxis(toSuperviewAxis: .vertical)
            icon.autoSetDimensions(to: CGSize(width:30,height:30))
            //为icon添加点击事件
            let iconTap=UITapGestureRecognizer(target: self, action: #selector(onTabBarButtonClick))
            icon.addGestureRecognizer(iconTap)
            
            let titleLabel=UILabel()
            titleLabel.font=UIFont.systemFont(ofSize: 13.0)
            titleLabel.textColor=i==0 ? tabBarSelectedColor:tabBarNormalColor
            titleLabel.text=self.titles[i]
            tabBarItemView.addSubview(titleLabel)
            self.labels.append(titleLabel)
            titleLabel.autoPinEdge(.bottom, to: .bottom, of: tabBarItemView, withOffset: -3)
            titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        }
        
    }
    func onTabBarButtonClick(sender:UIGestureRecognizer){
        for i in 0..<self.titles.count{
            let icon=self.imageViews[i]
            let label=self.labels[i]
            if (sender.view?.tag)!==i{
                icon.image=UIImage(named: self.selectedIcons[i])
                label.textColor = tabBarSelectedColor
            }else{
                icon.image=UIImage(named: self.normalIcons[i])
                label.textColor = tabBarNormalColor
            }
        }
        
        self.selectedIndex=(sender.view?.tag)!
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
