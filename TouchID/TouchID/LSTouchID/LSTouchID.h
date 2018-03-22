//
//  LSTouchID.h
//  TouchID
//
//  Created by lhs7248 on 2018/3/22.
//  Copyright © 2018年 lhs7248. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>


@interface LSTouchID : NSObject

/** touchID 的上下文环境判断
 */
@property (nonatomic, strong) LAContext * _Nullable context;

/**
 判断是否支持指纹解锁
 success YES 为支持，NO为不支持
 error 则是请求的错误信息
 */
-(void)canEvaluatePolicy:(void (^_Nullable)(BOOL success, NSError * _Nullable error))evaluateCallBack;


/**请求TouchID
 param touchID的回调
 */
-(void)touchIDAuthentication:(void (^_Nullable)(BOOL success, NSError * _Nullable error))authCallBack;

@end
