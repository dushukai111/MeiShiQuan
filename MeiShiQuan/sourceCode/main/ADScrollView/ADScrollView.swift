//
//  ADScrollView.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/1.
//  Copyright © 2016年 dushukai. All rights reserved.
//  该空间不依赖于任何第三方库，但由于里面用到了oc中的MD5，需要在桥接头文件中导入<CommonCrypto/CommonHMAC.h>

import UIKit
import Security
class ADScrollView: UIView,UIScrollViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private var scrollView:UIScrollView=UIScrollView()
    var imageType:ADScrollViewImageType!
    private var images:[String]!
    private var imageClickBlock:((Int)->Void)!
    private var defaultImage:UIImage!
    private var imageStates:[Int]=[] //用于网络图片的状态记录，0准备下载，1正在下载，2完成下载
    private let cachePath=NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0].appending("/ADScrollViewImageCache")
    private var delayTime:Double=3.0
    private var timer:Timer!
    private var pageControlViews:[UIView]=[]
    private let pageControlNormalColor=UIColor(white: 1.0, alpha: 0.6)
    private let pageControlSelectedColor=UIColor.white
    private var imageViews:[UIImageView]=[]
    private static var imageCaches:[String:Data]=[:]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.scrollView.showsVerticalScrollIndicator=false
        self.scrollView.showsHorizontalScrollIndicator=false
        self.scrollView.bounces=false
        self.scrollView.translatesAutoresizingMaskIntoConstraints=false
        self.scrollView.isPagingEnabled=true
        self.scrollView.delegate=self
        self.addSubview(self.scrollView)
        //设置scrollView约束，基于通用性考虑，ADScrollView使用原生代码添加autolayout
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    func setImages(images:[String]){
        self.images=images
        if self.images.count>1{
            self.images.append(self.images[0])
            self.images.insert(self.images[self.images.count-2], at: 0)
        }
        
        self.imageStates.removeAll()
        for _ in 0..<self.images.count{//初始化图片状态数组
            self.imageStates.append(0)
        }
    }
    func setDefaultImage(defaultImage:UIImage){
        self.defaultImage=defaultImage
    }
    func setImageClickBlock(imageClickBlock:@escaping (Int)->Void){
        self.imageClickBlock=imageClickBlock
    }
    func setDelayTime(seconds:Double){
        self.delayTime=seconds
    }
    func onImageTap(gesture:UIGestureRecognizer){
        if let index = gesture.view?.tag{
            if let _=self.imageClickBlock {
                self.imageClickBlock(index-1)
            }
            
        }
    }
    func loadViews(){
        self.imageViews.removeAll()
        for subView in self.scrollView.subviews{
            subView.removeFromSuperview()
        }
        guard let _=self.imageType else{
            print("ADScrollView:please set imageType...")
            return
        }
        var referView:UIView=self.scrollView
        for i in 0..<self.images.count{
            
            let imageView=UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints=false
            imageView.isUserInteractionEnabled=true
            imageView.tag=i
            self.scrollView.addSubview(imageView)
            self.scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: referView, attribute: i==0 ? .leading:.trailing, multiplier: 1.0, constant: 0))
            self.scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 0))
            self.scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0))
            self.scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 1.0, constant: 0))
            let imageTap=UITapGestureRecognizer(target: self, action: #selector(onImageTap))
            imageView.addGestureRecognizer(imageTap)
            referView=imageView
            if let _=self.defaultImage {
                imageView.image=self.defaultImage
            }
            let imageName=self.images[i] //imageName可能是文件名，也可能是链接地址
            if self.imageType == .localImage {
                imageView.image=UIImage(named: imageName)
            }else{
                self.downloadImage(imageView: imageView, index: i)
            }
            self.imageViews.append(imageView)
            
        }
        
        if self.images.count>0 {
            self.scrollView.addConstraint(NSLayoutConstraint(item: referView, attribute: .trailing, relatedBy: .equal, toItem: self.scrollView, attribute: .trailing, multiplier: 1.0, constant: 0))
        }
        
        if self.images.count>1 {
            self.startTimer()
            //采用autolayout后，初始化过程中获取scrollview的size为0，采用延时的方式获取
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                self.scrollView.contentOffset=CGPoint(x: self.scrollView.bounds.size.width, y: 0)
            })
        }
        
        self.setPageControl()
    }
    private func setPageControl(){
        self.pageControlViews.removeAll()
        //移除所有pageControl圆点
        for view in self.subviews{
            if view.tag==100 {
                view.removeFromSuperview()
            }
        }
        if self.images.count>0 {
            let pointSpace=CGFloat(5.0)
            let pointWidth=CGFloat(10.0)
            let bottomDistance=CGFloat(10.0)
            let imageCount=self.images.count>1 ? self.images.count-2:self.images.count  //此时的images数组有可能是多加了首尾两个，当实际只有一个图片时，不增加首尾图片
            for i in 0..<imageCount{
                let pointView=UIView()
                pointView.layer.cornerRadius=CGFloat(pointWidth/2)
                pointView.backgroundColor = i==0 ? self.pageControlSelectedColor : self.pageControlNormalColor
                pointView.tag=100
                pointView.translatesAutoresizingMaskIntoConstraints=false
                self.addSubview(pointView)
                
                self.addConstraint(NSLayoutConstraint(item: pointView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -bottomDistance))
                self.addConstraint(NSLayoutConstraint(item: pointView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: pointWidth))
                self.addConstraint(NSLayoutConstraint(item: pointView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: pointWidth))
                self.addConstraint(NSLayoutConstraint(item: pointView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: -(CGFloat(imageCount)*pointWidth+CGFloat(imageCount-1)*pointSpace)/2.0+CGFloat(i)*(pointSpace+pointWidth)))
                
                self.pageControlViews.append(pointView)
                
            }
        }
    }
    private func startTimer(){
        self.timer=Timer.scheduledTimer(withTimeInterval: self.delayTime, repeats: true){ (timer:Timer) in
            let pageIndex:Int=Int(self.scrollView.contentOffset.x/self.scrollView.bounds.size.width)
            self.scrollView.setContentOffset(CGPoint(x: CGFloat(self.scrollView.bounds.size.width*CGFloat(pageIndex+1)), y: 0), animated: true)
        }
        
    }
    private func downloadImage(imageView:UIImageView,index:Int){
        if self.imageStates[index]==0 {
            let imageUrl=self.images[index]
            let imageName=self.getMD5String(str: imageUrl)
            let imagePath=cachePath.appendingFormat("/%@", imageName)
            let fileManeger=FileManager.default
            self.imageStates[index]=1 //先设置为下载中
            if let imageData=ADScrollView.imageCaches[imageName]{//文件存在
                imageView.image=UIImage(data: imageData)
                self.imageStates[index]=2
                
            }else if fileManeger.fileExists(atPath: imagePath){
                DispatchQueue.global().async {
                    do{
                        let data=try Data(contentsOf: URL(fileURLWithPath: imagePath))
                        ADScrollView.imageCaches[imageName]=data
                        let image=UIImage(data: data)
                        DispatchQueue.main.async {
                            imageView.image=image
                            self.imageStates[index]=2
                        }
                    }catch{
                        print("ADScrollView:load image data faild!")
                        self.imageStates[index]=0
                    }
                    
                    
                }
            }else{ //不存在，进行下载
                let session=URLSession(configuration: URLSessionConfiguration.default)
                session.dataTask(with: URL(string:imageUrl)!, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                    if error==nil{
                        if !fileManeger.fileExists(atPath: self.cachePath){//检查缓存目录是否存在，不存在则创建
                            do{
                                try fileManeger.createDirectory(atPath: self.cachePath, withIntermediateDirectories: true, attributes: nil)
                            }catch {
                                print("ADScrollview:Create cache path faild!")
                            }
                            
                        }
                        if !fileManeger.createFile(atPath: imagePath, contents: data, attributes: nil){
                            print("ADScrollview:Cache image faild!")
                        }
                        ADScrollView.imageCaches[imageName]=data
                        DispatchQueue.main.async {
                            imageView.image=UIImage(data: data!)
                            self.imageStates[index]=2
                        }
                    }else{
                        //                        print(error!)
                        self.imageStates[index]=0
                    }
                }).resume()
            }
        }
        
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.dealWithPage()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.dealWithPage()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer.invalidate() //触摸是停止timer，防止手动滑动和自动冲突
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer() //触摸结束，恢复timer
    }
    private func dealWithPage(){
        let pageIndex:Int=Int(self.scrollView.contentOffset.x/self.scrollView.bounds.size.width)
        
        if self.images.count>1{
            if pageIndex==self.images.count-1 {
                self.scrollView.setContentOffset(CGPoint(x:self.scrollView.bounds.size.width,y:0), animated: false)
                let imageView=self.imageViews[1]
                self.downloadImage(imageView: imageView, index: 1)
            }else if pageIndex==0{
                self.scrollView.setContentOffset(CGPoint(x:self.scrollView.bounds.size.width*CGFloat(self.images.count-2),y:0), animated: false)
            }
            
            self.switchPageControl(pageIndex: pageIndex)
        }
        if self.images.count>0 {
            let imageView=self.imageViews[pageIndex]
            self.downloadImage(imageView: imageView, index: pageIndex)
        }
        
    }
    private func switchPageControl(pageIndex:Int){
        var realPageIndex:Int!
        if pageIndex==0 {
            realPageIndex=pageControlViews.count-1
        }else if pageIndex==self.images.count-1{
            realPageIndex=0
        }else{
            realPageIndex=pageIndex-1
        }
        for i in 0..<self.pageControlViews.count{
            let view=self.pageControlViews[i]
            if i==realPageIndex{
                view.backgroundColor=self.pageControlSelectedColor
            }else{
                view.backgroundColor=self.pageControlNormalColor
            }
        }
    }
    private func isImageCached(imageUrl:String)->Bool{
        let imageName=self.getMD5String(str: imageUrl)
        let imagePath=cachePath.appending(imageName)
        let fileManeger=FileManager.default
        return fileManeger.fileExists(atPath: imagePath)
    }
    
    private func getMD5String(str:String)->String{
        let cStr = str.cString(using: .utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ADScrollViewImageType{
    case localImage,webImage
}
