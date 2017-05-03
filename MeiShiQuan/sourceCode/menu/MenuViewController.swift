//
//  MenuViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/31.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit
protocol MenuCellDelegate {
    func onExpandButtonClick(index:Int)
}
class MenuViewController: BasicViewController,UITableViewDataSource,UITableViewDelegate,MenuCellDelegate {
    private let pageSize=5
    private var tableView:UITableView!
    private var datas:[[String:Any]]!
    private var refreshFooter:MJRefreshAutoNormalFooter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor=pageBackgroundColor
        self.title="菜单"
        self.isBackButtonHidden=true
        KGProgressAlertHUD.showSimpleProgress(title: "加载中..", view: self.contentView, offsetToCenterY: -navigationBarHeight-statusBarHeight)
        self.initUI()
        self.requestDatas(type: 1)
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.tableView=UITableView()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight=150
        self.tableView.backgroundColor=pageBackgroundColor
        self.tableView.showsVerticalScrollIndicator=false
        self.contentView.addSubview(self.tableView)
        self.tableView.autoPinEdge(toSuperviewEdge: .leading)
        self.tableView.autoPinEdge(toSuperviewEdge: .top)
        self.tableView.autoPinEdge(toSuperviewEdge: .trailing)
        self.tableView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -tabBarHeight)
        
        let refreshHeader=MJRefreshNormalHeader {[weak self] in
            self?.requestDatas(type: 1)
        }
        refreshHeader?.setTitle("下拉刷新..", for: .idle)
        refreshHeader?.setTitle("释放刷新..", for: .pulling)
        refreshHeader?.setTitle("正在刷新..", for: .refreshing)
        refreshHeader?.lastUpdatedTimeLabel.isHidden=true
        self.tableView.mj_header=refreshHeader
        
        self.refreshFooter=MJRefreshAutoNormalFooter {[weak self] in
            self?.requestDatas(type: 2)
        }
        refreshFooter?.setTitle("上拉加载更多", for: .idle)
        refreshFooter?.setTitle("无更多数据", for: .noMoreData)
        refreshFooter?.setTitle("正在加载..", for: .refreshing)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _=self.datas {
            return self.datas.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="menuCell"
        var cell=tableView.dequeueReusableCell(withIdentifier: cellId) as? MenuCell
        if cell==nil {
            cell=MenuCell(style: .default, reuseIdentifier: cellId)
            cell?.delegate=self
        }
        cell?.tag=indexPath.row
        let item=self.datas[indexPath.row]
        cell?.setData(data: item)
        return cell!
    }
    func onExpandButtonClick(index: Int) {
        let isExpand=self.datas[index]["isExpand"] as! Bool
        self.datas[index]["isExpand"] = !isExpand
        self.tableView.reloadRows(at: [IndexPath(row:index,section:0)], with: .fade)
    }
    
    private func requestDatas(type:Int){//type 1刷新  2加载更多
        var lastOrderId:Int=0
        if type==2&&self.datas.count>0 {
            lastOrderId=self.datas[self.datas.count-1]["id"] as! Int
        }
        let params=["userId":(UserTool.getUserId())!,"type":type,"count":pageSize,"lastOrderId":lastOrderId] as [String : Any]
        
        let url=url_serverUrl+"order/getOrderListByUserId"
        HttpRequest.postRequest(url: url, params: params, successBlock: {[weak self](responseData:Any?) -> Void in
            self?.tableView.mj_header.endRefreshing()
            KGProgressAlertHUD.dismissProgressView(view: (self?.contentView)!)
            if var orders=responseData as? [[String:Any]]{
                for i in 0..<orders.count{
                    orders[i]["isExpand"]=false
                }
                if(type==1){
                    self?.datas=orders
                }else{
                    self?.datas.append(contentsOf: orders)
                    
                }
                self?.setFooterView(dataCount: orders.count)
                self?.tableView.reloadData()
            }
            
            }, faildBlock: {[weak self](errorMsg:String) -> Void in
                if type==1{
                    self?.tableView.mj_header.endRefreshing()
                }else{
                    self?.tableView.mj_footer.state = .idle
                    self?.refreshFooter.setTitle("加载失败，点击重新加载", for: .idle)
                }
                
                KGProgressAlertHUD.dismissProgressView(view: (self?.contentView)!)
                print(errorMsg)
        })
        
    }
    private func setFooterView(dataCount:Int){
        if self.tableView.contentSize.height<self.tableView.bounds.size.height {
            if dataCount<pageSize {
                self.tableView.mj_footer=nil
            }else{
                self.tableView.mj_footer=self.refreshFooter
                self.tableView.mj_footer.state = .idle
            }
            
        }else{
            self.tableView.mj_footer=self.refreshFooter
            if dataCount<pageSize {
                self.tableView.mj_footer.state = .noMoreData
            }else{
                self.tableView.mj_footer.state = .idle
            }
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

class MenuCell:UITableViewCell,UITableViewDataSource,UITableViewDelegate{
    private let dishItemHeight=CGFloat(25)
    private var dishs:[[String:Any]]!
    public var delegate:MenuCellDelegate?
    private let separatorLineColor=UIColor(white: 0.9, alpha: 1.0)
    private var hotelImageView:UIImageView!
    private var hotelNameLabel:UILabel!
    private var orderStateLabel:UILabel!
    private var createTimeLabel:UILabel!
    private var totalPriceLabel:UILabel!
    private var dishTableView:UITableView!
    private var expandBtn:UIButton!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //店铺logo
        self.hotelImageView=UIImageView()
        self.contentView.addSubview(self.hotelImageView)
        self.hotelImageView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.hotelImageView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
        self.hotelImageView.autoSetDimensions(to: CGSize(width:70,height:70))
        
        //店铺名称
        self.hotelNameLabel=UILabel()
        self.hotelNameLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.contentView.addSubview(self.hotelNameLabel)
        self.hotelNameLabel.autoPinEdge(.leading, to: .trailing, of: self.hotelImageView, withOffset: 10)
        self.hotelNameLabel.autoPinEdge(.top, to: .top, of: self.hotelImageView, withOffset: 5)
        
        //订单状态
        self.orderStateLabel=UILabel()
        self.orderStateLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.contentView.addSubview(self.orderStateLabel)
        self.orderStateLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        self.orderStateLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.hotelNameLabel)
        
        //订单创建时间
        self.createTimeLabel=UILabel()
        self.createTimeLabel.font=UIFont.systemFont(ofSize: 15.0)
        self.createTimeLabel.textColor=UIColor.gray
        self.contentView.addSubview(self.createTimeLabel)
        self.createTimeLabel.autoPinEdge(.leading, to: .leading, of: self.hotelNameLabel, withOffset: 0)
        self.createTimeLabel.autoPinEdge(.bottom, to: .bottom, of: self.hotelImageView, withOffset: -5)
        
        //订单总金额
        self.totalPriceLabel=UILabel()
        self.totalPriceLabel.font=UIFont.systemFont(ofSize: 22.0)
        self.totalPriceLabel.textColor=UIColor.red
        self.contentView.addSubview(self.totalPriceLabel)
        self.totalPriceLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        self.totalPriceLabel.autoPinEdge(.bottom, to: .bottom, of: self.hotelImageView, withOffset: -5)
        
        //分割线1
        let separatorLine=UIView()
        separatorLine.backgroundColor=separatorLineColor
        self.contentView.addSubview(separatorLine)
        separatorLine.autoPinEdge(.leading, to: .leading, of: self.hotelNameLabel, withOffset: 0)
        separatorLine.autoPinEdge(.top, to: .bottom, of: self.hotelImageView, withOffset: 5)
        separatorLine.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
        separatorLine.autoSetDimension(.height, toSize: 1)
        
        //菜品列表
        self.dishTableView=UITableView()
        self.dishTableView.dataSource=self
        self.dishTableView.delegate=self
        self.dishTableView.separatorStyle = .none
        self.dishTableView.bounces=false
        self.dishTableView.isScrollEnabled=false
        self.contentView.addSubview(self.dishTableView)
        self.dishTableView.autoPinEdge(.leading, to: .leading, of: self.hotelNameLabel, withOffset: 0)
        self.dishTableView.autoPinEdge(.top, to: .top, of: separatorLine, withOffset: 5)
        self.dishTableView.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -50)
        self.dishTableView.autoSetDimension(.height, toSize: dishItemHeight*2)
        
        //展开按钮
        self.expandBtn=UIButton()
        self.expandBtn.setBackgroundImage(UIImage(named:"down"), for: .normal)
        self.expandBtn.addTarget(self, action: #selector(onExpandBtnClick), for: .touchUpInside)
        self.contentView.addSubview(self.expandBtn)
        self.expandBtn.autoPinEdge(.leading, to: .trailing, of: self.dishTableView, withOffset: 15)
        self.expandBtn.autoPinEdge(.bottom, to: .bottom, of: self.dishTableView, withOffset: -3)
        self.expandBtn.autoSetDimensions(to: CGSize(width:15,height:15))
        //分割线2
        let separatorLine1=UIView()
        separatorLine1.backgroundColor=separatorLineColor
        self.contentView.addSubview(separatorLine1)
        separatorLine1.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 0)
        separatorLine1.autoPinEdge(.top, to: .bottom, of: self.dishTableView, withOffset: 0)
        separatorLine1.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: 0)
        separatorLine1.autoSetDimension(.height, toSize: 5)
        separatorLine1.autoPinEdge(toSuperviewEdge: .bottom)
        
        
    }
    func onExpandBtnClick(sender:UIButton){
        //            UIView.animate(withDuration: 0.3, animations: {
        //                if sender.transform.b==0 {
        //                    sender.transform=CGAffineTransform(rotationAngle: CGFloat(M_PI))
        //                }else{
        //                    sender.transform=CGAffineTransform(rotationAngle: 0)
        //                }
        //            }, completion: {(completed:Bool) in
        //                if let _=self.delegate {
        //                    self.delegate?.onExpandButtonClick(index: self.tag)
        //                }
        //            })
        if let _=self.delegate {
            self.delegate?.onExpandButtonClick(index: self.tag)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _=self.dishs {
            return self.dishs.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId="orderDishCell"
        var cell=tableView.dequeueReusableCell(withIdentifier: cellId) as? OrderDishCell
        if cell==nil {
            cell=OrderDishCell(style: .default, reuseIdentifier: cellId)
        }
        let dishData=self.dishs[indexPath.row];
        cell?.setData(data: dishData)
        return cell!
    }
    func setData(data:[String:Any]){
        var hotelImageUrl=""
        if let value=data["hotelLogoUrl"] {
            hotelImageUrl="\(value)"
        }
        var hotelName="未知"
        if let value=data["hotelName"] {
            hotelName="\(value)"
        }
        var orderState="未知"
        if let value=data["orderState"] {
            orderState="\(value)"
        }
        var createTime="未知"
        if let value=data["createTime"] {
            let format=DateFormatter()
            format.dateFormat="yyyy-MM-dd HH:mm:ss"
            createTime=format.string(from: Date(timeIntervalSince1970: TimeInterval((value as! Int)/1000)))
        }
        var totalPrice="未知"
        if let value=data["total"] {
            totalPrice="￥\(value)"
        }
        self.dishs=data["dishs"] as? [[String:Any]]
        
        self.hotelImageView.sd_setImage(with: URL(string:hotelImageUrl), placeholderImage: UIImage(named:""));
        self.hotelNameLabel.text=hotelName
        self.createTimeLabel.text=createTime
        self.totalPriceLabel.text=totalPrice
        if orderState=="1" {
            self.orderStateLabel.text="待支付"
            self.orderStateLabel.textColor=UIColor.red
        }else if orderState=="2"{
            self.orderStateLabel.text="已完成"
            self.orderStateLabel.textColor=UIColor.green
        }else{
            self.orderStateLabel.text="待支付"
            self.orderStateLabel.textColor=UIColor.gray
        }
        var isExpand=false
        if let value=data["isExpand"] as? Bool{
            isExpand=value
        }
        for constraint in self.dishTableView.constraints{
            if constraint.firstAttribute == .height {
                if self.dishs.count<=2 {
                    self.expandBtn.isHidden=true
                    constraint.constant=dishItemHeight*CGFloat(self.dishs.count)
                }else{
                    self.expandBtn.isHidden=false
                    if isExpand {
                        constraint.constant=dishItemHeight*CGFloat(self.dishs.count)
                    }else{
                        constraint.constant=dishItemHeight*2
                    }
                }
                break
            }
        }
        if isExpand{
            self.expandBtn.transform=CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }else{
            self.expandBtn.transform=CGAffineTransform(rotationAngle: 0)
        }
        self.dishTableView.reloadData()
        
    }
    private func getState(state:String)->String{
        var stateStr="未知"
        if state=="1" {
            stateStr="待支付"
        }else if state=="2"{
            stateStr="已完成"
        }else{
            stateStr="已取消"
        }
        return stateStr
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //dishCell内部类
    class OrderDishCell:UITableViewCell{
        private var dishNameLabel:UILabel!
        private var countLabel:UILabel!
        private var priceLabel:UILabel!
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            let labelFont=UIFont.systemFont(ofSize: 14.0)
            let labelColor=UIColor.gray
            //菜品名
            self.dishNameLabel=UILabel()
            self.dishNameLabel.font=labelFont
            self.dishNameLabel.textColor=labelColor
            self.contentView.addSubview(self.dishNameLabel)
            self.dishNameLabel.autoPinEdge(toSuperviewEdge: .leading)
            self.dishNameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            //数量
            self.countLabel=UILabel()
            self.countLabel.font=labelFont
            self.countLabel.textColor=labelColor
            self.contentView.addSubview(self.countLabel)
            self.countLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            self.countLabel.autoAlignAxis(.vertical, toSameAxisOf: self.contentView, withOffset: 30)
            //价格
            self.priceLabel=UILabel()
            self.priceLabel.font=labelFont
            self.priceLabel.textColor=labelColor
            self.contentView.addSubview(self.priceLabel)
            self.priceLabel.autoPinEdge(toSuperviewEdge: .trailing)
            self.priceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        }
        func setData(data:[String:Any]){
            var dishName="未知"
            if let value=data["dishName"] {
                dishName="\(value)"
            }
            var count="未知"
            if let value=data["number"] {
                count="×\(value)"
            }
            var price="未知"
            if let value=data["price"] {
                price="￥\(value)"
            }
            self.dishNameLabel.text=dishName
            self.countLabel.text=count
            self.priceLabel.text=price
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
