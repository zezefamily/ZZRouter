//
//  ZZRoutePageConfig.m
//  TestDemo333
//
//  Created by 泽泽 on 2020/6/30.
//  Copyright © 2020 泽泽. All rights reserved.
//

#import "ZZRoutePageConfig.h"

@implementation ZZRoutePageConfig

+ (NSString *)getTargetNameWithRoutPath:(NSString *)routePath
{
    return [[self getAllRoutePaths]objectForKey:routePath];
}

+ (NSDictionary *)getAllRoutePaths
{
    return @{
        @"/user/detail":@"SecondViewController",
        @"/user/setting":@"SettingViewController",
        @"/rootNav":@"RootNavViewController",
        @"/user/third":@"ThirdViewController",
        @"/user/four":@"FourViewController"
    };
}
@end
