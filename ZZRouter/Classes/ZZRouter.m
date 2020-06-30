//
//  ZZRouter.m
//  TestDemo333
//
//  Created by 泽泽 on 2020/6/30.
//  Copyright © 2020 泽泽. All rights reserved.
//

#import "ZZRouter.h"
#import <objc/message.h>

@class ZZRouter;

@implementation UIViewController (ZZRouter)

static char kAssociatedParamsObjectKey;

- (void)setRouteCallBack:(RouteCallBack)routeCallBack
{
    objc_setAssociatedObject(self, &kAssociatedParamsObjectKey, routeCallBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (RouteCallBack)routeCallBack
{
    return objc_getAssociatedObject(self, &kAssociatedParamsObjectKey);
}

@end


@interface ZZRouter ()

@end
@implementation ZZRouter

+ (instancetype)zz_instanceRouter
{
    static ZZRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[self alloc]init];
    });
    return router;
}

- (instancetype)init
{
    if(self == [super init]){
        
    }
    return self;
}

- (BOOL)zz_routeTo:(NSString *)route from:(id)viewController target:(NSString *)targetName
{
    return [self zz_routeTo:route from:viewController target:targetName params:nil style:nil callBack:nil];
}

- (BOOL)zz_routeTo:(NSString *)route from:(id)viewController target:(NSString *)targetName params:(NSDictionary *)params
{
    return [self zz_routeTo:route from:viewController target:targetName params:params style:nil callBack:nil];
}

- (BOOL)zz_routeTo:(NSString *)route from:(id)viewController target:(NSString *)targetName params:(NSDictionary *)params style:(ZZModalStyle *)modalStyle
{
    return [self zz_routeTo:route from:viewController target:targetName params:params style:modalStyle callBack:nil];
}

- (BOOL)zz_routeTo:(NSString *)route from:(id)viewController target:(NSString *)targetName params:(NSDictionary * __nullable)params style:(ZZModalStyle * __nullable)modalStyle callBack:(RouteCallBack __nullable)callBack
{
    BOOL canOpen = NO;
    
    if(modalStyle == nil){
        modalStyle = [ZZModalStyle defalutStyle];
    }
    
    Class targetClass = objc_getClass([targetName UTF8String]);
    SEL selector = NSSelectorFromString(@"createViewController");
    if([targetClass respondsToSelector:selector]){
        //创建
        UIViewController *targetController = [targetClass createViewController];
        //传参
        if(params != nil){
            [targetController setValuesForKeysWithDictionary:params];
        }
        if(callBack){
            targetController.routeCallBack = callBack;
        }
        //跳转
        [viewController presentViewController:targetController animated:YES completion:nil];
        canOpen = YES;
    }else{
        canOpen = NO;
        @throw [NSException exceptionWithName:@"路由跳转异常" reason:@"target没有实现必要的协议" userInfo:@{@"func":@"+(instancetype)createViewController"}];
    }
    return canOpen;
}

@end

@implementation ZZModalStyle

- (instancetype)init
{
    if(self == [super init]){
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

+ (ZZModalStyle *)defalutStyle
{
    ZZModalStyle *style = [[ZZModalStyle alloc]init];
    return style;
}

@end
