//
//  ModifyPasswordViewController.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/11/30.
//  Copyright © 2016年 dushukai. All rights reserved.
//  修改密码分两种，一个是通过旧密码验证，一个是找回密码，前者比后者多一个旧密码输入框

import UIKit

enum ModifyPasswrodType{
    case findPassword,modifyPassword
}

class ModifyPasswordViewController: BasicViewController {

    var modifyType:ModifyPasswrodType = .modifyPassword
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="修改密码"
        
        self.initUI()
    }
    private func initUI(){
        
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
