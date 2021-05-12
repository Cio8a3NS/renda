//
//  AppDelegate.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "AppDelegate.h"
#import "RGGNavigationController.h"
#import "RGGTabBarController.h"
#import "KeychainItemWrapper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    
    self.window.frame = [UIScreen mainScreen].bounds;
// 
    RGGNavigationController *nav = [[RGGNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
////
    self.window.rootViewController = nav;
    NSLog(@"fefsdfsfsdf%f",50/3.0);
//    self.window.rootViewController = [[RGGTabBarController alloc]init];
    
    [self.window makeKeyAndVisible];
    //获取唯一标识
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         [self getuuid];
    });
    
//   [self showGuiView];
    
    return YES;
}

- (void)getuuid{
    //    添加设备唯一标识
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"kUUID" accessGroup:nil];
    NSString *aliaStr = [wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)];
    
    if (aliaStr.length > 0) {
        NSLog(@"*********%@",aliaStr);
    } else {
        aliaStr = [FactoryTool getUniqueclientID];
        //保存数据
        [wrapper resetKeychainItem];
        [wrapper setObject:aliaStr forKey:(id)CFBridgingRelease(kSecValueData)];
        
    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
