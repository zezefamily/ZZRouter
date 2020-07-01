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
@property (nonatomic,strong) NSMutableDictionary *routePathAndStyles;
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
        self.routePathAndStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)zz_routeTo:(NSString *)route from:(UIViewController *)from params:(NSDictionary * __nullable)params style:(ZZModalStyle * __nullable)modalStyle callBack:(RouteCallBack __nullable)callBack
{
    if(modalStyle == nil){
        modalStyle = [ZZModalStyle defalutStyle];
    }
    //获取目标路由
    NSString *targetName = [ZZRoutePageConfig getTargetNameWithRoutPath:route];
    if(targetName == nil || targetName.length == 0){
        NSLog(@"没有找到目标路由/未配置");
        return NO;
    }
    //创建
    UIViewController *targetController = [self getViewControllerWithTargetName:targetName];
    //传参
    if(params != nil){
        [targetController setValuesForKeysWithDictionary:params];
    }
    if(callBack){
        targetController.routeCallBack = callBack;
    }
    targetController.modalPresentationStyle =  modalStyle.modalPresentationStyle;
    targetController.modalTransitionStyle = modalStyle.modalTransitionStyle;
    //跳转
    if(modalStyle.type == ZZModalStyleTypePush){
        if(from.navigationController && from != nil){
            [from.navigationController pushViewController:targetController animated:YES];
        }
    }else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:targetController];
        nav.modalPresentationStyle = modalStyle.modalPresentationStyle;
        nav.modalTransitionStyle = modalStyle.modalTransitionStyle;
        [from presentViewController:nav animated:YES completion:nil];
    }
    return YES;
}

- (void)zz_leavePage:(UIViewController *)vc
{
    if([vc.navigationController.topViewController isEqual:vc.navigationController.viewControllers[0]]){
        [vc dismissViewControllerAnimated:YES completion:nil];
    }else{
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

- (UIViewController *)getViewControllerWithTargetName:(NSString *)targetName
{
    Class targetClass = objc_getClass([targetName UTF8String]);
    //创建
    UIViewController *targetController = [targetClass new];
    return targetController;
}

@end

@implementation ZZModalStyle

- (instancetype)init
{
    if(self == [super init]){
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        self.type = ZZModalStyleTypePush;
    }
    return self;
}

+ (ZZModalStyle *)defalutStyle
{
    ZZModalStyle *style = [[ZZModalStyle alloc]init];
    return style;
}

+ (ZZModalStyle *)pushStyle
{
    ZZModalStyle *style = [[ZZModalStyle alloc]init];
    style.type = ZZModalStyleTypePush;
    return style;
}

+ (ZZModalStyle *)presentStyle
{
    ZZModalStyle *style = [[ZZModalStyle alloc]init];
    style.type = ZZModalStyleTypePresent;
    return style;
}

@end
