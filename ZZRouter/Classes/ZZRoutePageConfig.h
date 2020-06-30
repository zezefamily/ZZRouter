//
//  ZZRoutePageConfig.h
//  TestDemo333
//
//  Created by 泽泽 on 2020/6/30.
//  Copyright © 2020 泽泽. All rights reserved.
//  路由白名单

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZRoutePageConfig : NSObject

+ (NSString *)getTargetNameWithRoutPath:(NSString *)routePath;

@end

NS_ASSUME_NONNULL_END
