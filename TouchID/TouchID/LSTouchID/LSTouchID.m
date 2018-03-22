//
//  LSTouchID.m
//  TouchID
//
//  Created by lhs7248 on 2018/3/22.
//  Copyright © 2018年 lhs7248. All rights reserved.
//

#import "LSTouchID.h"

@implementation LSTouchID

//LAPolicyDeviceOwnerAuthenticationWithBiometrics  判读 Touch ID or Face ID
//LAPolicyDeviceOwnerAuthentication 判断  biometry or device passcode.
-(void)canEvaluatePolicy:(void (^)(BOOL success, NSError * _Nullable error))evaluateCallBack{
    
    if (self.context == nil) {
       self.context = [LAContext new];
    }
    NSError *error;
    //判断设备支不支持Touch ID
    if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        
        evaluateCallBack(YES,error);
    }else{
        evaluateCallBack(NO,error);
    }
}

/**请求TouchID
 touchID的回调
 */
-(void)touchIDAuthentication:(void (^)(BOOL success, NSError * _Nullable error))authCallBack {
    
    self.context.localizedFallbackTitle = @"请输入密码";
    self.context.localizedCancelTitle = @"取消";
    
      
    [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
            localizedReason:@"指纹验证"
                      reply:^(BOOL success, NSError * _Nullable error) {
                          if (success) {
                              //验证成功执行
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                    authCallBack(YES,error);
                              });
                          } else {
                              if (error.code == kLAErrorUserFallback) {
                                  NSLog(@"Fallback按钮被点击");
                              } else if (error.code == kLAErrorUserCancel) {
                                  NSLog(@"取消按钮被点击");
                              } else {
                                  //指纹识别失败执行
                                  NSLog(@"指纹识别失败");
                              }
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  authCallBack(NO,error);
                              });
                          }
                      }];
}


@end
