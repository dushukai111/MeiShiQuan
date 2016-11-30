//
//  MineViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/31.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class MineViewController: BasicViewController,UITableViewDataSource,UITableViewDelegate {

    let cellHeight=CGFloat(45)
    let sectionHeight=CGFloat(10)
    
    var tableView:UITableView!
    var dataArray:[[[String:String]]]!
    
    var userHeadView:UIImageView!
    var userNameLabel:UILabel!
    var phoneLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="我的"
        self.isBackButtonHidden=true
        self.navigationBar.alpha=0.0
        self.contentView.isHidden=true
        self.initData()
        self.initUI()
        // Do any additional setup after loading the view.
    }

    func initUI(){
        tableView=UITableView()
        tableView.dataSource=self
        tableView.delegate=self
        tableView.separatorStyle = .none
        tableView.bounces=false
        tableView.rowHeight=cellHeight
        tableView.showsVerticalScrollIndicator=false
        tableView.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.view.insertSubview(tableView, at: 0)
        tableView.autoPinEdge(.leading, to: .leading, of: self.view)
        tableView.autoPinEdge(.top, to: .top, of: self.view)
        tableView.autoPinEdge(.trailing, to: .trailing, of: self.view)
        tableView.autoPinEdge(.bottom, to: .bottom, of: self.view, withOffset: -tabBarHeight)
        //tableHeaderView
        let headerView=UIView(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 140))
        headerView.backgroundColor=UIColor(red: 88/255.0, green: 133/255.0, blue: 244/255.0, alpha: 1.0)
        tableView.tableHeaderView=headerView
          //为headerView添加点击事件
        let headerViewTap=UITapGestureRecognizer(target: self, action: #selector(onHeaderViewTap))
        headerView.addGestureRecognizer(headerViewTap)
        userHeadView=UIImageView()
        userHeadView.image=UIImage(named: "defaultHead")
        userHeadView.layer.cornerRadius=40
        userHeadView.layer.masksToBounds=true
        headerView.addSubview(userHeadView)
        userHeadView.autoPinEdge(.leading, to: .leading, of: headerView, withOffset: 20)
        userHeadView.autoAlignAxis(.horizontal, toSameAxisOf: headerView, withOffset: 10)
        userHeadView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        
        userNameLabel=UILabel()
        userNameLabel.font=UIFont.systemFont(ofSize: 18.0)
        userNameLabel.textColor=UIColor.white
        userNameLabel.text="笑傲江湖"
        headerView.addSubview(userNameLabel)
        userNameLabel.autoPinEdge(.leading, to: .trailing, of: userHeadView, withOffset: 15)
        userNameLabel.autoConstrainAttribute(.bottom, to: .horizontal, of: userHeadView, withOffset: -5)
        
        let cellPhoneIcon=UIImageView()
        cellPhoneIcon.image=UIImage(named: "mine_cellPhone")
        headerView.addSubview(cellPhoneIcon)
        cellPhoneIcon.autoPinEdge(.leading, to: .leading, of: userNameLabel)
        cellPhoneIcon.autoConstrainAttribute(.top, to: .horizontal, of: userHeadView, withOffset: 5)
        cellPhoneIcon.autoSetDimensions(to: CGSize(width: 15, height: 15))
        
        phoneLabel=UILabel()
        phoneLabel.font=UIFont.systemFont(ofSize: 16.0)
        phoneLabel.textColor=UIColor.white
        phoneLabel.text="18658923158"
        headerView.addSubview(phoneLabel)
        phoneLabel.autoPinEdge(.leading, to: .trailing, of: cellPhoneIcon, withOffset: 5)
        phoneLabel.autoAlignAxis(.horizontal, toSameAxisOf: cellPhoneIcon)
        
        let nextPageIcon=UIImageView()
        nextPageIcon.image=UIImage(named: "nextPage")
        headerView.addSubview(nextPageIcon)
        nextPageIcon.autoPinEdge(.trailing, to: .trailing, of: headerView, withOffset: -15)
        nextPageIcon.autoAlignAxis(.horizontal, toSameAxisOf: userHeadView)
        nextPageIcon.autoSetDimensions(to: CGSize(width:20,height:20))
        
    }
    func onHeaderViewTap(){
        let userInfoVC=UserInfoViewController()
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    func initData(){
        dataArray=[[["icon":"mine_jifen","title":"我的积分"],["icon":"mine_shoucang","title":"我的收藏"],["icon":"mine_fuwu","title":"服务中心"],["icon":"mine_jiameng","title":"加盟合作"]],[["icon":"mine_setting","title":"设置"]]]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="mineCell"
        var cell:MineCell!=tableView.dequeueReusableCell(withIdentifier: cellId) as! MineCell!
        if cell==nil {
            cell=MineCell(style: .default, reuseIdentifier: cellId)
        }
        let item=dataArray[indexPath.section][indexPath.row]
        cell.icon.image=UIImage(named: item["icon"]!)
        cell.titleLabel.text=item["title"]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent=scrollView.contentOffset.y/50
        if percent<1 {
            navigationBar.alpha=percent
        }else{
            navigationBar.alpha=1.0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    class MineCell:UITableViewCell{
        var icon:UIImageView!
        var titleLabel:UILabel!
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            icon=UIImageView()
            self.contentView.addSubview(icon)
            icon.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
            icon.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
            icon.autoSetDimensions(to: CGSize(width: 25, height: 25))
            
            titleLabel=UILabel()
            titleLabel.font=UIFont.systemFont(ofSize: 16.0)
            titleLabel.textColor=UIColor(white: 0.5, alpha: 1.0)
            self.contentView.addSubview(titleLabel)
            titleLabel.autoPinEdge(.leading, to: .trailing, of: icon, withOffset: 10)
            titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: icon)
            
            let separatorLine=UIView()
            separatorLine.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
            self.contentView.addSubview(separatorLine)
            separatorLine.autoPinEdge(toSuperviewEdge: .leading)
            separatorLine.autoPinEdge(toSuperviewEdge: .bottom)
            separatorLine.autoPinEdge(toSuperviewEdge: .trailing)
            separatorLine.autoSetDimension(.height, toSize: 1.0)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
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
