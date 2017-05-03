//
//  AppDelegate.swift
//  MeiShiQuan
//
//  Created by kaige on 2016/10/28.
//  Copyright © 2016年 dushukai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initViews()
        self.initUserDefaults()
        
        return true
    }
    func initViews(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.window=UIWindow(frame:UIScreen.main.bounds)
        self.window?.backgroundColor=UIColor.white
        let titles=["美食","菜单","发现","我的"]
        let normalIcons=["tabbar_main_normal","tabbar_menu_normal","tabbar_faxian_normal","tabbar_mine_normal"]
        let selectedIcons=["tabbar_main_selected","tabbar_menu_selected","tabbar_faxian_selected","tabbar_mine_selected"]
        let viewControllers = [MainViewController(),MenuViewController(),FindViewController(),MineViewController()]
        let tabBarViewController=TabBarViewController(titles: titles, normalIcons: normalIcons, selectedIcons:selectedIcons,viewControllers: viewControllers)
        
        let naviController=UINavigationController(rootViewController: tabBarViewController)
        naviController.isNavigationBarHidden=true
        self.window?.rootViewController=naviController
        self.window?.makeKeyAndVisible()
    }
    //初始化userDefaults用户参数
    func initUserDefaults(){
        //初始化非wifi下图片质量
        if UserTool.getImageQuality()==nil {
            UserTool.setImageQuality(qualityDis: "普通")
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

