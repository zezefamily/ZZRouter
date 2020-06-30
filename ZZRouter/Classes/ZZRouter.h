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

+ (instancetype)zz_instanceRouter;

- (BOOL)zz_routeTo:(NSString *)route from:(id)viewController target:(NSString *)targetName params:(NSDictionary * __nullable)params style:(ZZModalStyle * __nullable)modalStyle callBack:(RouteCallBack __nullable)callBack;

@end

@interface ZZModalStyle : NSObject

@property (nonatomic,assign) UIModalTransitionStyle modalTransitionStyle;

@property (nonatomic,assign) UIModalPresentationStyle modalPresentationStyle;

@property (nonatomic,assign) BOOL prsentOrPush;

+ (ZZModalStyle *)defalutStyle;

@end


@interface UIViewController (ZZRouter)

@property(nonatomic,copy) RouteCallBack routeCallBack;

@end

NS_ASSUME_NONNULL_END
