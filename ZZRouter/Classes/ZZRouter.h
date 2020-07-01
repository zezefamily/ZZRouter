//
//  ZZRouter.h
//  TestDemo333
//
//  Created by 泽泽 on 2020/6/30.
//  Copyright © 2020 泽泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZZRoutePageConfig.h"

typedef void(^RouteCallBack)(NSString * _Nullable handlerTag, id _Nullable results);

NS_ASSUME_NONNULL_BEGIN

@protocol ZZRouter <NSObject>

+ (instancetype)createViewController;

@end

@class ZZModalStyle;

@interface ZZRouter : NSObject

/// 获取路由对象实例
+ (instancetype)zz_instanceRouter;

/// 路由跳转
/// @param route 路由名称
/// @param from 当前控制器对象
/// @param params 传参
/// @param modalStyle 跳转风格
/// @param callBack 回调
- (BOOL)zz_routeTo:(NSString *)route from:(UIViewController *)from params:(NSDictionary * __nullable)params style:(ZZModalStyle * __nullable)modalStyle callBack:(RouteCallBack __nullable)callBack;

/// 返回
/// @param vc 当前控制器对象
- (void)zz_leavePage:(UIViewController *)vc;

@end


typedef NS_ENUM(NSInteger,ZZModalStyleType){
    ZZModalStyleTypePush = 0,
    ZZModalStyleTypePresent = 1,
};

@interface ZZModalStyle : NSObject

@property (nonatomic,assign) UIModalTransitionStyle modalTransitionStyle;

@property (nonatomic,assign) UIModalPresentationStyle modalPresentationStyle;

@property (nonatomic,assign) ZZModalStyleType type;

+ (ZZModalStyle *)defalutStyle;

+ (ZZModalStyle *)pushStyle;

+ (ZZModalStyle *)presentStyle;

@end


@interface UIViewController (ZZRouter)

@property(nonatomic,copy) RouteCallBack routeCallBack;

@end

NS_ASSUME_NONNULL_END
