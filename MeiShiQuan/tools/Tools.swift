//
//  Tools.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/29.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

class Tools: NSObject {

    static func image(size:CGSize,color:UIColor)-> UIImage?{
        UIGraphicsBeginImageContext(size)
        let context=UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.addRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        context?.fillPath()
        let image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    static func scaleImage(image:UIImage,size:CGSize)->UIImage?{
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resultImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
