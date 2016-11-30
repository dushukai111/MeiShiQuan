//
//  MainViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/31.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class MainViewController: BasicViewController ,UITableViewDelegate,UITableViewDataSource{

    private var areaLabel:UILabel!
    private var searchBarLabel:UILabel!
    private var tableView:UITableView!
    private var scrollToTopView:UIButton!
    private var beginOffset:CGPoint=CGPoint.zero
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="主页"
        self.isBackButtonHidden=true
        self.isTitleHidden=true
        // Do any additional setup after loading the view.
        //导航栏新增views
        self.initBarViews()
        self.initTableView()
        self.addScrollToTopView()
        
        
    }
    private func initTableView(){
        self.tableView=UITableView()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        self.tableView.estimatedRowHeight=100.0
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.none
        self.contentView.addSubview(tableView)
        self.tableView.autoPinEdge(toSuperviewEdge: .leading)
        self.tableView.autoPinEdge(toSuperviewEdge: .trailing)
        self.tableView.autoPinEdge(toSuperviewEdge: .top)
        self.tableView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -tabBarHeight)
        
        let refreshHeader=MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {[unowned self] in
                self.tableView.mj_header.endRefreshing()
            })
        })
        refreshHeader?.lastUpdatedTimeLabel.isHidden=true
        refreshHeader?.setTitle("下拉刷新..", for: .idle)
        refreshHeader?.setTitle("释放刷新..", for: .pulling)
        refreshHeader?.setTitle("正在刷新..", for: .refreshing)
        self.tableView.mj_header=refreshHeader
        
        let headerHeight=self.view.bounds.size.width*0.4+90
        let headerView=UIView(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: headerHeight))
        self.tableView.tableHeaderView=headerView
        
        let adScrollView=ADScrollView()
        adScrollView.setDefaultImage(defaultImage: UIImage(named: "ad_default")!)
        adScrollView.imageType = .webImage
        adScrollView.setImages(images: ["http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1609/27/c0/27587202_1474952311163_800x600.jpg","http://image100.360doc.com/DownloadImg/2016/09/2200/80557672_26.jpg","http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0D/0D/ChMkJ1eV_E2IMTEQABERSEVD0poAAT0hAID5McAERFg559.jpg"])
        adScrollView.loadViews()
        headerView.addSubview(adScrollView)
        adScrollView.setImageClickBlock { (imageIndex:Int) in
            print(imageIndex)
        }
        adScrollView.autoPinEdge(.leading, to: .leading, of: headerView)
        adScrollView.autoPinEdge(.trailing, to: .trailing, of: headerView)
        adScrollView.autoPinEdge(.top, to: .top, of: headerView)
        adScrollView.autoMatch(.height, to: .width, of: adScrollView, withMultiplier: 0.4)
        
        let functionTitles=["美食","周边","优惠券","推荐"]
        let functionIcons=["main_functionButton1","main_functionButton2","main_functionButton3","main_functionButton4"]
        var referView=headerView
        for i in 0..<functionTitles.count{
            let funcButton=FunctionButton()
            funcButton.title=functionTitles[i]
            funcButton.icon=functionIcons[i]
            funcButton.tag=100+i
            funcButton.addTarget(target: self, action: #selector(onFunctionButtonClick))
            headerView.addSubview(funcButton)
            if i==0 {
                funcButton.autoPinEdge(.leading, to: .leading, of: referView, withOffset: 0)
            }else{
                funcButton.autoPinEdge(.leading, to: .trailing, of: referView, withOffset: 0)
            }
            
            funcButton.autoPinEdge(.top, to: .bottom, of: adScrollView, withOffset: 10)
            funcButton.autoSetDimension(.height, toSize: 70)
            funcButton.autoMatch(.width, to: .width, of: headerView, withMultiplier: 1/CGFloat(functionTitles.count))
            referView=funcButton
        }
        
        
        
    }
    func addScrollToTopView(){
        scrollToTopView=UIButton()
        scrollToTopView.setBackgroundImage(UIImage(named:"scroll_to_top_icon"), for: .normal)
        scrollToTopView.addTarget(self, action: #selector(onScrollToTopButtonClick), for: .touchUpInside)
        scrollToTopView.alpha=0.0
        self.contentView.addSubview(scrollToTopView)
        scrollToTopView.autoPinEdge(.bottom, to: .bottom, of: self.tableView, withOffset: -50)
        scrollToTopView.autoPinEdge(.trailing, to: .trailing, of: self.tableView, withOffset: -10)
        scrollToTopView.autoSetDimensions(to: CGSize(width: 40, height: 40))
    }
    func onScrollToTopButtonClick(){
        tableView.contentOffset=CGPoint(x: 0, y: 0)
    }
    func onFunctionButtonClick(sender:UIView){
        print(sender.tag)
    }
    private func initBarViews(){
        //导航栏新增view
          //地区label
        self.areaLabel=UILabel()
        self.areaLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.areaLabel.textColor=UIColor.white
        self.areaLabel.text="北京"
        self.navigationBar.addSubview(self.areaLabel)
        self.areaLabel.autoPinEdge(.leading, to: .leading, of: self.navigationBar, withOffset: 5)
        self.areaLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.navigationBar, withOffset: statusBarHeight/2)
           //地区下拉箭头
        let areaArrow:UIImageView=UIImageView()
        areaArrow.image=UIImage(named: "main_navigation_bar_area_arrow")
        self.navigationBar.addSubview(areaArrow)
        areaArrow.autoPinEdge(.leading, to: .trailing, of: self.areaLabel, withOffset: 3)
        areaArrow.autoAlignAxis(.horizontal, toSameAxisOf: self.areaLabel)
        areaArrow.autoSetDimensions(to: CGSize(width: 15.0, height: 15.0))
           //搜索栏
        let searchBar=UIView()
        searchBar.backgroundColor=UIColor.white
        searchBar.layer.cornerRadius=15.0
        self.navigationBar.addSubview(searchBar)
        searchBar.autoPinEdge(.leading, to: .trailing, of: areaArrow, withOffset: 10)
        searchBar.autoPinEdge(.trailing, to: .trailing, of: self.navigationBar, withOffset: -45.0)
        searchBar.autoAlignAxis(.horizontal, toSameAxisOf: self.areaLabel)
        searchBar.autoSetDimension(.height, toSize: 30.0)
        
        let searchBarTap=UITapGestureRecognizer(target: self, action: #selector(onSearchBarTap))
        searchBar.addGestureRecognizer(searchBarTap)
            //搜索栏中的icon和label
        let centerView=UIView()//centerView用于容纳搜索栏图标和label，用于居中显示
        searchBar.addSubview(centerView)
        centerView.autoAlignAxis(toSuperviewAxis: .vertical)
        centerView.autoAlignAxis(toSuperviewAxis: .horizontal)
        centerView.autoMatch(.height, to: .height, of: searchBar)
        
        let searchIcon=UIImageView()
        searchIcon.image=UIImage(named: "main_search")
        searchIcon.isUserInteractionEnabled=true
        centerView.addSubview(searchIcon)
        searchIcon.autoPinEdge(toSuperviewEdge: .leading)
        searchIcon.autoAlignAxis(toSuperviewAxis: .horizontal)
        searchIcon.autoSetDimensions(to: CGSize(width: 20, height: 20))
        
        self.searchBarLabel=UILabel()
        self.searchBarLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.searchBarLabel.textColor=UIColor.gray
        self.searchBarLabel.text="搜索"
        centerView.addSubview(self.searchBarLabel)
        self.searchBarLabel.autoPinEdge(.leading, to: .trailing, of: searchIcon, withOffset: 5)
        self.searchBarLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        self.searchBarLabel.autoPinEdge(toSuperviewEdge: .trailing)
           //二维码扫描按钮
        let scanBtn=UIButton()
        scanBtn.setBackgroundImage(UIImage(named: "main_scan_normal"), for: .normal)
        scanBtn.setBackgroundImage(UIImage(named: "main_scan_highlight"), for: .highlighted)
        scanBtn.addTarget(self, action: #selector(onScanBtnClick), for: .touchUpInside)
        self.navigationBar.addSubview(scanBtn)
        scanBtn.autoPinEdge(.trailing, to: .trailing, of: self.navigationBar, withOffset: -8)
        scanBtn.autoAlignAxis(.horizontal, toSameAxisOf: self.areaLabel)
        scanBtn.autoSetDimensions(to: CGSize(width: 30.0, height: 30.0))
        
    }
    func onSearchBarTap(){
        
    }
    //二维码扫描
    func onScanBtnClick(){
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="mainCell"
        var cell:MainCell?=tableView.dequeueReusableCell(withIdentifier: cellId) as? MainCell
        if cell==nil{
            cell=MainCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.imgView.image=UIImage(named: "hotel_icon_test")
        cell?.titleLabel.text="巫山烤鱼"
        cell?.averagePriceLabel.text="100"
        cell?.monthAmountLabel.text="月售234"
        cell?.activityArray=indexPath.row % 2==0 ? [["activityType":"1","activityDis":"满199减20"]] : [["activityType":"1","activityDis":"满199减20"],["activityType":"2","activityDis":"满399享8折"]]
        cell?.evaluateAmountLabel.text="56评"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginOffset=scrollView.contentOffset
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y<beginOffset.y&&scrollView.contentOffset.y>0&&scrollToTopView.alpha==0.0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollToTopView.alpha=1.0
            })
        }else if((scrollView.contentOffset.y>beginOffset.y||scrollView.contentOffset.y<=0)&&scrollToTopView.alpha==1.0){
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollToTopView.alpha=0.0
            })
        }
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
