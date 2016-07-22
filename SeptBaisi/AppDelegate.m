//
//  AppDelegate.m
//  SeptBaisi
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "AppDelegate.h"

#import "JYMainController.h"

@interface AppDelegate ()

@property (nonatomic,strong) NSMutableDictionary *versionDcit;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[JYMainController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (NSMutableDictionary *)versionDcit
{
    if (!_versionDcit) {
        
        _versionDcit = [NSMutableDictionary dictionary];
        
        // 获取appStore版本号
        NSString *url = @"http://itunes.apple.com/lookup?id=1115965900";
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                           timeoutInterval:10];
        
        [request setHTTPMethod:@"POST"];
        
        [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                    
                    [_versionDcit setValue:@"1" forKey:@"status"];
                    [_versionDcit setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                }else{
                    
                    [_versionDcit setValue:@"-1" forKey:@"status"];
                }
            }else{
                [_versionDcit setValue:@"-1" forKey:@"status"];
            }
        }];
    }
    return _versionDcit;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"%s", __func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%s", __func__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
//    NSString *app_Version = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
//    NSLog(@"%@ -- %@", app_Version, self.versionDcit[@"version"]);
////    [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]]
//    
//    if ([app_Version isEqualToString:self.versionDcit[@"version"]]) {
//        NSLog(@"xiangtong");
//    } else {
//        NSLog(@"buxiangtong");
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%s", __func__);
}

@end
