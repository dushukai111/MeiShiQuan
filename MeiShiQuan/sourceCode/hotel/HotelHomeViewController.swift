//
//  HotelHomeViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2017/1/23.
//  Copyright © 2017年 dushukai. All rights reserved.
//

import UIKit

class HotelHomeViewController: BasicViewController,UITableViewDataSource,UITableViewDelegate,DishListCellDelegate,CAAnimationDelegate {
    var animationImageView:UIImageView!//用于点击添加菜品按钮时的动画
    var hotelImageView:UIImageView! //饭店logo
    var hotelNameLabel:UILabel!  //饭店名称
    var averageScoreLabel:UILabel!  //评分
    var hotelDisLabel:UILabel!  //饭店描述
    var discountLabel:UILabel!  //折扣信息
    var scrollView:UIScrollView!  //
    var shopingCarView:UIImageView!  //购物车图标
    var shopingCarDishNumberLabel:UILabel!  //购物车菜品数量label
    var shopingCarDisLabel:UILabel!  //购物车描述
    var underLine:UIView!  //
    var dishTypeTableView:UITableView! //菜品类型table
    var dishTableView:UITableView!  //菜品table
    var evaluateView:UIView!  //评价视图
    var datas:[String:Any]!  //
    var dishTypes:[[String:Any]]!  //菜品类型数组
    var dishs:[[[String:Any]]]!  //菜品数组
    var currentDishTypeIndex=0  //当前选中的菜品类型索引，0为全部
    var totalPrice:Float=0.0  //购物车中的菜品总价
    var totalDishNumber=0  //购物车中的菜品总数量
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initUI()
        self.requestDatas()
    }
    private func initUI(){
        let topContentView=UIView()
        topContentView.backgroundColor=UIColor(red: 215/255.0, green: 165/255.0, blue: 112/255.0, alpha: 1.0)
        self.contentView.addSubview(topContentView)
        topContentView.autoPinEdge(toSuperviewEdge: .leading)
        topContentView.autoPinEdge(toSuperviewEdge: .top)
        topContentView.autoPinEdge(toSuperviewEdge: .trailing)
        
        self.hotelImageView=UIImageView()
        topContentView.addSubview(self.hotelImageView)
        self.hotelImageView.autoPinEdge(.leading, to: .leading, of: topContentView, withOffset: 10)
        self.hotelImageView.autoPinEdge(.top, to: .top, of: topContentView, withOffset: 10)
        self.hotelImageView.autoSetDimensions(to: CGSize(width: 70, height: 70))
        
        self.hotelNameLabel=UILabel()
        self.hotelNameLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.hotelNameLabel.textColor=UIColor.white
        topContentView.addSubview(self.hotelNameLabel)
        self.hotelNameLabel.autoPinEdge(.leading, to: .trailing, of: self.hotelImageView, withOffset: 10)
        self.hotelNameLabel.autoPinEdge(.top, to: .top, of: self.hotelImageView, withOffset: 0)
        self.hotelNameLabel.autoPinEdge(.trailing, to: .trailing, of: topContentView, withOffset: -30)
        
        self.averageScoreLabel=UILabel()
        self.averageScoreLabel.font=UIFont.systemFont(ofSize: 15.0)
        self.averageScoreLabel.textColor=UIColor.white
        topContentView.addSubview(self.averageScoreLabel)
        self.averageScoreLabel.autoPinEdge(.leading, to: .leading, of: self.hotelNameLabel, withOffset: 0)
        self.averageScoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.hotelImageView)
        
        self.hotelDisLabel=UILabel()
        self.hotelDisLabel.font=UIFont.systemFont(ofSize: 13.0)
        self.hotelDisLabel.textColor=UIColor.white
        topContentView.addSubview(self.hotelDisLabel)
        self.hotelDisLabel.autoPinEdge(.leading, to: .leading, of: self.hotelNameLabel, withOffset: 0)
        self.hotelDisLabel.autoPinEdge(.trailing, to: .trailing, of: topContentView, withOffset: -30)
        self.hotelDisLabel.autoPinEdge(.bottom, to: .bottom, of: self.hotelImageView, withOffset: 0)
        
        let rightArrow=UIImageView()
        rightArrow.image=UIImage(named: "right_white")
        topContentView.addSubview(rightArrow)
        rightArrow.autoPinEdge(.trailing, to: .trailing, of: topContentView, withOffset: -10)
        rightArrow.autoAlignAxis(.horizontal, toSameAxisOf: self.hotelImageView)
        rightArrow.autoSetDimensions(to: CGSize(width: 15, height: 15))
        
        self.discountLabel=UILabel()
        self.discountLabel.font=UIFont.systemFont(ofSize: 13.0)
        self.discountLabel.textColor=UIColor.white
        self.discountLabel.numberOfLines=0
        topContentView.addSubview(self.discountLabel)
        self.discountLabel.autoPinEdge(.leading, to: .leading, of: self.hotelImageView, withOffset: 0)
        self.discountLabel.autoPinEdge(.top, to: .bottom, of: self.hotelImageView, withOffset: 10)
        self.discountLabel.autoPinEdge(.trailing, to: .trailing, of: topContentView, withOffset: -10)
        self.discountLabel.autoPinEdge(.bottom, to: .bottom, of: topContentView, withOffset: -10)
        
        
        
        //
        let selectButton1=UIButton()
        selectButton1.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth/2,height:40), color: UIColor.white), for: .normal)
        selectButton1.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth/2,height:40), color: UIColor(white: 0.9, alpha: 1.0)), for: .normal)
        selectButton1.setTitle("菜品", for: .normal)
        selectButton1.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        selectButton1.setTitleColor(appThemeColor, for: .normal)
        self.contentView.addSubview(selectButton1)
        selectButton1.autoPinEdge(toSuperviewEdge: .leading)
        selectButton1.autoPinEdge(.top, to: .bottom, of: topContentView)
        selectButton1.autoMatch(.width, to: .width, of: self.contentView, withMultiplier: 0.5)
        selectButton1.autoSetDimension(.height, toSize: 40)
        
        let selectButton2=UIButton()
        selectButton2.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth/2,height:40), color: UIColor.white), for: .normal)
        selectButton2.setBackgroundImage(Tools.image(size: CGSize(width:screenWidth/2,height:40), color: UIColor(white: 0.9, alpha: 1.0)), for: .normal)
        selectButton2.setTitle("评价", for: .normal)
        selectButton2.setTitleColor(UIColor.black, for: .normal)
        selectButton2.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(selectButton2)
        selectButton2.autoPinEdge(toSuperviewEdge: .trailing)
        selectButton2.autoPinEdge(.top, to: .bottom, of: topContentView)
        selectButton2.autoMatch(.width, to: .width, of: self.contentView, withMultiplier: 0.5)
        selectButton2.autoSetDimension(.height, toSize: 40)
        
        //滑动视图
        self.scrollView=UIScrollView()
        self.scrollView.showsHorizontalScrollIndicator=false
        self.scrollView.isPagingEnabled=true
        self.contentView.addSubview(self.scrollView)
        self.scrollView.autoPinEdge(toSuperviewEdge: .leading)
        self.scrollView.autoPinEdge(.top, to: .bottom, of: selectButton1)
        self.scrollView.autoPinEdge(.trailing, to: .trailing, of: self.contentView)
        self.scrollView.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -50)
        //下划线
        self.underLine=UIView()
        self.underLine.backgroundColor=appThemeColor
        self.contentView.addSubview(self.underLine)
        self.underLine.autoAlignAxis(.vertical, toSameAxisOf: selectButton1)
        self.underLine.autoPinEdge(.bottom, to: .bottom, of: selectButton1, withOffset: -5)
        self.underLine.autoSetDimension(.height, toSize: 1)
        self.underLine.autoMatch(.width, to: .width, of: selectButton1, withOffset: -20)
        
        //左侧菜品分类
        self.dishTypeTableView=UITableView()
        self.dishTypeTableView.dataSource=self;
        self.dishTypeTableView.delegate=self;
        self.dishTypeTableView.separatorStyle = .none
        self.dishTypeTableView.rowHeight = UITableViewAutomaticDimension
        self.dishTypeTableView.estimatedRowHeight = 50
        self.dishTypeTableView.showsVerticalScrollIndicator=false
        self.dishTypeTableView.backgroundColor=UIColor(white: 0.95, alpha: 1.0)
        self.scrollView.addSubview(self.dishTypeTableView)
        self.dishTypeTableView.autoPinEdge(.leading, to: .leading, of: self.scrollView, withOffset: 0)
        self.dishTypeTableView.autoPinEdge(.top, to: .top, of: self.scrollView, withOffset: 0)
        self.dishTypeTableView.autoSetDimension(.width, toSize: 80)
        self.dishTypeTableView.autoMatch(.height, to: .height, of: self.scrollView)
        
        //菜品列表
        self.dishTableView=UITableView()
        self.dishTableView.dataSource=self
        self.dishTableView.delegate=self
        self.dishTableView.separatorStyle = .none
        self.dishTableView.rowHeight = UITableViewAutomaticDimension
        self.dishTableView.estimatedRowHeight = 80
        self.scrollView.addSubview(self.dishTableView)
        self.dishTableView.autoPinEdge(.leading, to: .trailing, of: self.dishTypeTableView, withOffset: 0)
        self.dishTableView.autoPinEdge(.top, to: .top, of: self.scrollView, withOffset: 0)
        self.dishTableView.autoMatch(.width, to: .width, of: self.scrollView, withOffset: -80)
        self.dishTableView.autoMatch(.height, to: .height, of: self.scrollView)
        
        //底部菜单视图
        let bottomView=UIView()
        bottomView.backgroundColor=UIColor(white: 0.4, alpha: 1.0)
        self.contentView.addSubview(bottomView)
        bottomView.autoPinEdge(toSuperviewEdge: .leading)
        bottomView.autoPinEdge(.top, to: .bottom, of: self.scrollView, withOffset: 0)
        bottomView.autoPinEdge(toSuperviewEdge: .trailing)
        bottomView.autoSetDimension(.height, toSize: 50)
        
        //购物篮图标
        self.shopingCarView=UIImageView()
        self.shopingCarView.image=UIImage(named: "shoppingCar2")
        self.contentView.addSubview(self.shopingCarView)
        self.shopingCarView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.shopingCarView.autoPinEdge(.bottom, to: .bottom, of: bottomView, withOffset: -5)
        self.shopingCarView.autoSetDimensions(to: CGSize(width: 55, height: 55))
        
        //购物篮菜品数量label
        let numberContentView=UIView()
        numberContentView.backgroundColor=UIColor.red
        numberContentView.isHidden=true
        numberContentView.layer.cornerRadius=7.5
        self.contentView.addSubview(numberContentView)
        numberContentView.autoConstrainAttribute(.vertical, to: .trailing, of: self.shopingCarView, withOffset: 0)
        numberContentView.autoPinEdge(.top, to: .top, of: self.shopingCarView, withOffset: 0)
        numberContentView.autoSetDimension(.height, toSize: 15)
        numberContentView.autoSetDimension(.width, toSize: 15, relation: .greaterThanOrEqual)
        
        self.shopingCarDishNumberLabel=UILabel()
        self.shopingCarDishNumberLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.shopingCarDishNumberLabel.textColor=UIColor.white
        numberContentView.addSubview(self.shopingCarDishNumberLabel)
        NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh){
            self.shopingCarDishNumberLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            self.shopingCarDishNumberLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        }
        
        self.shopingCarDishNumberLabel.autoPinEdge(.leading, to: .leading, of: numberContentView, withOffset: 3)
        self.shopingCarDishNumberLabel.autoPinEdge(.trailing, to: .trailing, of: numberContentView, withOffset: -3)
        
        //购物车描述label，显示总价或描述购物车为空
        self.shopingCarDisLabel=UILabel()
        self.shopingCarDisLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.shopingCarDisLabel.textColor=UIColor(white: 0.7, alpha: 1.0)
        self.shopingCarDisLabel.text="购物篮为空"
        bottomView.addSubview(self.shopingCarDisLabel)
        self.shopingCarDisLabel.autoPinEdge(.leading, to: .trailing, of: self.shopingCarView, withOffset: 10)
        self.shopingCarDisLabel.autoAlignAxis(.horizontal, toSameAxisOf: bottomView)
        //结算按钮
        let payBtn=UIButton()
        payBtn.setBackgroundImage(Tools.image(size: CGSize(width:80,height:50), color: UIColor(red: 77/255.0, green: 179/255.0, blue: 91/255.0, alpha: 1.0)), for: .normal)
        payBtn.setTitle("去结算", for: .normal)
        payBtn.setTitleColor(UIColor.white, for: .normal)
        payBtn.titleLabel?.font=UIFont.systemFont(ofSize: 15.0)
        payBtn.addTarget(self, action: #selector(onPayBtnClick), for: .touchUpInside)
        bottomView.addSubview(payBtn)
        payBtn.autoPinEdge(toSuperviewEdge: .top)
        payBtn.autoPinEdge(toSuperviewEdge: .trailing)
        payBtn.autoPinEdge(toSuperviewEdge: .bottom)
        payBtn.autoSetDimension(.width, toSize: 80)
        
        //动画图片
        self.animationImageView=UIImageView(frame:CGRect(x: 0, y: 0, width: 60, height: 60))
        self.animationImageView.isHidden=true
        self.animationImageView.backgroundColor=UIColor.gray
        self.contentView.addSubview(self.animationImageView)
        
    }
    func onPayBtnClick(){
        if self.totalDishNumber != 0 {
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView==self.dishTypeTableView {
            return 1
        }else{
            if let _=self.dishs {
                if currentDishTypeIndex==0 {
                    return self.dishs.count
                }else{
                    return 1
                }
                
            }else{
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==self.dishTypeTableView{
            if let _=self.dishTypes {
                return self.dishTypes.count
            }else{
                return 0
            }
        }else{
            if let _=self.dishs {
                if currentDishTypeIndex==0 {
                    return self.dishs[section].count
                }else{
                    return self.dishs[currentDishTypeIndex-1].count
                }
            }else{
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView==self.dishTableView&&currentDishTypeIndex==0 {
            return 20
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let _=self.datas {
            if currentDishTypeIndex==0 {
                let headerId="dishHeaderId"
                var headerView=tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? DishSetionHeaderView
                if headerView==nil {
                    headerView=DishSetionHeaderView(reuseIdentifier: headerId)
                }
                headerView?.titleLabel.text=self.dishTypes[section+1]["dishTypeName"] as? String
                return headerView
                
            }else{
                return nil
            }
        }else{
            return nil
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==self.dishTypeTableView {
            let cellId="dishTypeCell"
            var cell=tableView.dequeueReusableCell(withIdentifier: cellId) as? DishTypeCell
            if cell==nil {
                cell=DishTypeCell(style: .default, reuseIdentifier: cellId)
            }
            let isSelect=self.dishTypes[indexPath.row]["isSelect"] as! Bool
            if isSelect {
                cell?.contentView.backgroundColor=UIColor.white
            }else{
                cell?.contentView.backgroundColor=UIColor(white: 0.95, alpha: 1.0)
            }
            let dishTypeName=self.dishTypes[indexPath.row]["dishTypeName"] as? String
            cell?.dishTypeLabel.text=dishTypeName
            return cell!
        }else{
            let cellId="dishCell"
            var cell=tableView.dequeueReusableCell(withIdentifier: cellId) as? DishListCell
            if cell==nil {
                cell=DishListCell(style: .default, reuseIdentifier: cellId)
                cell?.delegate=self
            }
            cell?.indexPath=indexPath
            var data:[String:Any]!
            if currentDishTypeIndex==0 {
                data=self.dishs[indexPath.section][indexPath.row]
            }else{
                data=self.dishs[currentDishTypeIndex-1][indexPath.row]
            }
            cell?.setData(data: data)
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==self.dishTypeTableView{
            for i in 0..<self.dishTypes.count {
                if i==indexPath.row {
                    self.dishTypes[i]["isSelect"]=true
                }else{
                    self.dishTypes[i]["isSelect"]=false
                }
            }
            currentDishTypeIndex=indexPath.row
            self.dishTypeTableView.reloadData()
            self.dishTableView.reloadData()
            
        }
    }
    func onDishAddBtnClick(indexPath: IndexPath) {
        var dishId=0
        var dishNumber=0
        var dishPrice:Float=0.0
        if currentDishTypeIndex==0 {
            dishId=self.dishs[indexPath.section][indexPath.row]["id"] as! Int
            dishNumber=self.dishs[indexPath.section][indexPath.row]["number"] as! Int + 1
            dishPrice=self.dishs[indexPath.section][indexPath.row]["price"] as! Float
        }else{
            dishId=self.dishs[currentDishTypeIndex-1][indexPath.row]["id"] as! Int
            dishNumber=self.dishs[currentDishTypeIndex-1][indexPath.row]["number"] as! Int + 1
            dishPrice=self.dishs[currentDishTypeIndex-1][indexPath.row]["price"] as! Float
        }
        //更新dishs数组中所有id为dishId的number
        for i in 0..<self.dishs.count {
            let count=self.dishs[i].count
            for j in 0..<count {
                if self.dishs[i][j]["id"] as! Int == dishId {
                    self.dishs[i][j]["number"]=dishNumber
                    
                }
                
                
            }
        }
        self.dishTableView.reloadRows(at: [indexPath], with: .none)
        
        //先获取cell中的dishImg在self.contentView中的坐标
        let dishCell=self.dishTableView.cellForRow(at: indexPath) as! DishListCell
        let dishImgPosition=dishCell.contentView.convert(dishCell.dishImgView.center, to: self.contentView)
        //设置动画视图的坐标和图片，并显示
        self.animationImageView.image=dishCell.dishImgView.image
        self.animationImageView.center=dishImgPosition
        self.animationImageView.isHidden=false
        //抛物线动画效果
        let path=UIBezierPath()
        path.move(to: CGPoint(x: dishImgPosition.x, y: dishImgPosition.y))
        path.addQuadCurve(to: self.shopingCarView.center, controlPoint: CGPoint(x:dishImgPosition.x-50,y:dishImgPosition.y+30))
        let animation=CAKeyframeAnimation(keyPath: "position")
        animation.path=path.cgPath
        animation.duration=0.3
        animation.delegate=self
        self.animationImageView.layer.add(animation, forKey: nil)
        
        let animation1=CABasicAnimation(keyPath: "transform.scale")
        animation1.toValue=0.5
        animation1.duration=0.3
        self.animationImageView.layer.add(animation1, forKey: nil)
        
        self.totalPrice+=dishPrice
        self.totalDishNumber+=1
        self.changeShoppingCarState()
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.animationImageView.transform=CGAffineTransform(scaleX: 1, y: 1)
        self.animationImageView.alpha=1.0
        self.animationImageView.isHidden=true
    }
    func onDishReduceBtnClick(indexPath: IndexPath) {
        var dishId=0
        var dishNumber=0
        var dishPrice:Float=0.0
        if currentDishTypeIndex==0 {
            dishId=self.dishs[indexPath.section][indexPath.row]["id"] as! Int
            dishNumber=self.dishs[indexPath.section][indexPath.row]["number"] as! Int - 1
            dishPrice=self.dishs[indexPath.section][indexPath.row]["price"] as! Float
        }else{
            dishId=self.dishs[currentDishTypeIndex-1][indexPath.row]["id"] as! Int
            dishNumber=self.dishs[currentDishTypeIndex-1][indexPath.row]["number"] as! Int - 1
            dishPrice=self.dishs[currentDishTypeIndex-1][indexPath.row]["price"] as! Float
        }
        //更新dishs数组中所有id为dishId的number
        for i in 0..<self.dishs.count {
            let count=self.dishs[i].count
            for j in 0..<count {
                if self.dishs[i][j]["id"] as! Int == dishId {
                    self.dishs[i][j]["number"]=dishNumber
                    
                }
                
                
            }
        }
        self.dishTableView.reloadRows(at: [indexPath], with: .none)
        self.totalPrice-=dishPrice
        self.totalDishNumber-=1
        self.changeShoppingCarState()
        
    }
    private func changeShoppingCarState(){
        self.shopingCarDishNumberLabel.text="\(self.totalDishNumber)"
        if self.totalDishNumber==0 {
            self.shopingCarView.image=UIImage(named: "shoppingCar2")
            self.shopingCarDisLabel.font=UIFont.systemFont(ofSize: 14.0)
            self.shopingCarDisLabel.textColor=UIColor(white: 0.7, alpha: 1.0)
            self.shopingCarDisLabel.text="购物篮为空"
            self.shopingCarDishNumberLabel.superview?.isHidden=true
        }else{
            self.shopingCarView.image=UIImage(named: "shoppingCar1")
            self.shopingCarDisLabel.font=UIFont.systemFont(ofSize: 16.0)
            self.shopingCarDisLabel.textColor=UIColor.white
            self.shopingCarDisLabel.text="￥\(self.totalPrice)"
            self.shopingCarDishNumberLabel.superview?.isHidden=false
        }
    }
    private func requestDatas(){
        let params=["hotelId":100001] as [String : Any]
        
        let url=url_serverUrl+"hotel/getHotelHomePageInfo"
        HttpRequest.postRequest(url: url, params: params, successBlock: {[weak self](responseData:Any?) -> Void in
            KGProgressAlertHUD.dismissProgressView(view: (self?.contentView)!)
            if let data=responseData{
                self?.datas=data as! [String:Any]
                
                var hotelLogoUrl=""
                if let value=self?.datas["hotelLogoUrl"]{
                    hotelLogoUrl="\(value)"
                }
                var hotelName=""
                if let value=self?.datas["hotelName"]{
                    hotelName="\(value)"
                }
                var score=""
                if let value=self?.datas["score"]{
                    score="\(value)"
                }
                var hotelDis=""
                if let value=self?.datas["hotelDiscription"]{
                    hotelDis="\(value)"
                }
                var discountStr=""
                if let value=self?.datas["discounts"] as? [[String:Any]]{
                    for i in 0..<value.count{
                        let item=value[i]
                        if let discountId=item["discountId"] as? Int,let fullValue=item["fullValue"] as? Float,let discountValue=item["discountValue"] as? Float{
                            if discountId==1{
                                discountStr.append("满\(fullValue)减\(discountValue)\(i==value.count-1 ? "" : "；")")
                            }else{
                                discountStr.append("满\(fullValue)打\(discountValue*10)折\(i==value.count-1 ? "" : "；")")
                            }
                        }
                        
                    }
                }
                self?.hotelImageView.sd_setImage(with: URL(string:hotelLogoUrl), placeholderImage: nil)
                self?.hotelNameLabel.text=hotelName
                self?.averageScoreLabel.text="\(score)分"
                self?.hotelDisLabel.text="简介："+hotelDis=="" ? "暂无" :hotelDis
                self?.discountLabel.text=discountStr
                self?.dealWithData()
                
            }
            
        }, faildBlock: {[weak self](errorMsg:String) -> Void in
            KGProgressAlertHUD.dismissProgressView(view: (self?.contentView)!)
            print(errorMsg)
        })
    }
    private func dealWithData(){
        
        if let dishList=self.datas["dishs"] as? [[String:Any]] {
            self.dishTypes=[[String:Any]]()
            self.dishTypes.append(["dishTypeId":0,"dishTypeName":"全部","isSelect":true])
            //从dishs中帅选出dishTypeList
            var haveNoType=false //有的菜品无分类
            for i in 0..<dishList.count {
                let item=dishList[i]
                if let dishTypeId=item["dishTypeId"] as? Int,let dishTypeName=item["dishTypeName"] as? String {
                    var isExist=false
                    for item1 in self.dishTypes {
                        if let dishTypeId1=item1["dishTypeId"] as? Int{
                            if dishTypeId==dishTypeId1 {
                                isExist=true
                                break
                            }
                        }
                    }
                    if !isExist {
                        self.dishTypes.append(["dishTypeId":dishTypeId,"dishTypeName":dishTypeName,"isSelect":false])
                    }
                }else{
                    haveNoType=true
                }
                
            }
            if haveNoType {//有无分类的菜品
                self.dishTypes.append(["dishTypeId":-1,"dishTypeName":"无分类","isSelect":false])
            }
            //给dishs分组
            self.dishs=[[[String:Any]]]()
            for item in self.dishTypes {
                if let dishTypeId=item["dishTypeId"] as? Int{
                    if dishTypeId == 0 {
                        continue
                    }
                    var singleTypeDishs=[[String:Any]]()
                    for var item1 in dishList {
                        if let dishTypeId1=item1["dishTypeId"] as? Int{
                            if dishTypeId1==dishTypeId {
                                item1.removeValue(forKey: "dishTypeId")
                                item1.removeValue(forKey: "dishTypeName")
                                item1.removeValue(forKey: "hotelId")
                                item1["number"]=0
                                singleTypeDishs.append(item1)
                            }
                        }else if(dishTypeId == -1){
                            item1.removeValue(forKey: "hotelId")
                            item1["number"]=0
                            singleTypeDishs.append(item1)
                        }
                        
                    }
                    self.dishs.append(singleTypeDishs)
                }
            }
            
        }
        print(self.dishs)
        print(self.dishTypes)
        self.dishTypeTableView.reloadData()
        self.dishTableView.reloadData()
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
class DishTypeCell:UITableViewCell{
    var dishTypeLabel:UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor=UIColor(white: 0.95, alpha: 1.0)
        self.dishTypeLabel=UILabel()
        self.dishTypeLabel.font=UIFont.systemFont(ofSize: 15.0)
        self.dishTypeLabel.textAlignment = .center
        self.dishTypeLabel.numberOfLines=0
        self.contentView.addSubview(self.dishTypeLabel)
        self.dishTypeLabel.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.dishTypeLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        self.dishTypeLabel.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
        self.dishTypeLabel.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -10)
        
        let separatorLine=UIView()
        separatorLine.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.contentView.addSubview(separatorLine)
        separatorLine.autoPinEdge(toSuperviewEdge: .leading)
        separatorLine.autoPinEdge(toSuperviewEdge: .trailing)
        separatorLine.autoPinEdge(toSuperviewEdge: .bottom)
        separatorLine.autoSetDimension(.height, toSize: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
protocol DishListCellDelegate:NSObjectProtocol{
    func onDishAddBtnClick(indexPath:IndexPath)
    func onDishReduceBtnClick(indexPath:IndexPath)
}
class DishListCell: UITableViewCell {
    var dishImgView:UIImageView!
    private var dishNameLabel:UILabel!
    private var salesLabel:UILabel!
    private var priceLabel:UILabel!
    private var addBtn:UIButton!
    private var reduceBtn:UIButton!
    private var dishNumberLabel:UILabel!
    public var indexPath:IndexPath!
    weak public var delegate:DishListCellDelegate!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //---
        self.dishImgView=UIImageView()
        self.contentView.addSubview(self.dishImgView)
        self.dishImgView.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.dishImgView.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
        self.dishImgView.autoSetDimensions(to: CGSize(width: 60, height: 60))
        //---
        self.dishNameLabel=UILabel()
        self.dishNameLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.contentView.addSubview(self.dishNameLabel)
        self.dishNameLabel.autoPinEdge(.leading, to: .trailing, of: self.dishImgView, withOffset: 10)
        self.dishNameLabel.autoPinEdge(.top, to: .top, of: self.dishImgView, withOffset: 0)
        self.dishNameLabel.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        //---
        self.salesLabel=UILabel()
        self.salesLabel.font=UIFont.systemFont(ofSize: 12.0)
        self.salesLabel.textColor=UIColor.gray
        self.contentView.addSubview(self.salesLabel)
        self.salesLabel.autoPinEdge(.leading, to: .leading, of: self.dishNameLabel, withOffset: 0)
        self.salesLabel.autoPinEdge(.bottom, to: .bottom, of: self.dishImgView, withOffset: -10)
        
        //---
        self.priceLabel=UILabel()
        self.priceLabel.font=UIFont.systemFont(ofSize: 16.0)
        self.priceLabel.textColor=UIColor.red
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.autoPinEdge(.leading, to: .leading, of: self.dishNameLabel, withOffset: 0)
        self.priceLabel.autoPinEdge(.top, to: .bottom, of: self.dishImgView, withOffset: 0)
        self.priceLabel.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -10)
        //---
        self.addBtn=UIButton()
        self.addBtn.setBackgroundImage(UIImage(named:"add_icon"), for: .normal)
        self.addBtn.addTarget(self, action: #selector(onAddButtonClick), for: .touchUpInside)
        self.contentView.addSubview(self.addBtn)
        self.addBtn.autoPinEdge(.trailing, to: .trailing, of: self.contentView, withOffset: -10)
        self.addBtn.autoAlignAxis(.horizontal, toSameAxisOf: self.priceLabel)
        self.addBtn.autoSetDimensions(to: CGSize(width: 25, height: 25))
        //---
        self.dishNumberLabel=UILabel()
        self.dishNumberLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.dishNumberLabel.textAlignment = .center
        self.contentView.addSubview(self.dishNumberLabel)
        self.dishNumberLabel.autoPinEdge(.trailing, to: .leading, of: self.addBtn, withOffset: 0)
        self.dishNumberLabel.autoAlignAxis(.horizontal, toSameAxisOf: self.addBtn)
        self.dishNumberLabel.autoSetDimension(.width, toSize: 40)
        //---
        self.reduceBtn=UIButton()
        self.reduceBtn.setBackgroundImage(UIImage(named:"reduce_icon"), for: .normal)
        self.reduceBtn.addTarget(self, action: #selector(onReduceButtonClick), for: .touchUpInside)
        self.contentView.addSubview(self.reduceBtn)
        self.reduceBtn.autoPinEdge(.trailing, to: .leading, of: self.dishNumberLabel, withOffset: 0)
        self.reduceBtn.autoAlignAxis(.horizontal, toSameAxisOf: self.addBtn)
        self.reduceBtn.autoSetDimensions(to: CGSize(width: 25, height: 25))
        //---
        let separatorLine=UIView()
        separatorLine.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        self.contentView.addSubview(separatorLine)
        separatorLine.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        separatorLine.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: 0)
        separatorLine.autoPinEdge(toSuperviewEdge: .trailing)
        separatorLine.autoSetDimension(.height, toSize: 1)
    }
    func onAddButtonClick(){
        if let _=self.delegate,let _=self.indexPath {
            self.delegate.onDishAddBtnClick(indexPath: self.indexPath)
        }
    }
    func onReduceButtonClick(){
        if let _=self.delegate,let _=self.indexPath {
            self.delegate.onDishReduceBtnClick(indexPath: self.indexPath)
        }
    }
    func setData(data:[String:Any]){
        var dishImgUrl=""
        if let value=data["dishImgUrl"] {
            dishImgUrl="\(value)"
        }
        var sales="售0"
        if let value=data["sales"] {
            sales="售\(value)"
        }
        var price=""
        if let value=data["price"] {
            price="￥\(value)"
        }
        var dishNumber=0
        if let value=data["number"]{
            dishNumber=value as! Int
        }
        self.dishImgView.sd_setImage(with: URL(string:dishImgUrl), placeholderImage: UIImage(named: "dish_default"))
        self.dishNameLabel.text=data["dishName"] as? String
        self.salesLabel.text=sales
        self.priceLabel.text=price
        self.dishNumberLabel.text="\(dishNumber)"
        if dishNumber==0 {
            self.reduceBtn.isHidden=true
            self.dishNumberLabel.isHidden=true
        }else{
            self.reduceBtn.isHidden=false
            self.dishNumberLabel.isHidden=false
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class DishSetionHeaderView: UITableViewHeaderFooterView {
    var titleLabel:UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor=UIColor(white: 0.95, alpha: 0.5)
        self.titleLabel=UILabel()
        self.titleLabel.font=UIFont.systemFont(ofSize: 14.0)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 10)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
