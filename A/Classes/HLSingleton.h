//
//  HLSingleton.h
//  HLBabyCare
//
//  Created by 姚军辉 on 2020/4/2.
//  Copyright © 2020 KeWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLSingleton : NSObject

+ (HLSingleton *)defaultSingleton;

+(CGFloat)getSpaceLabelWidth:(NSString *)str withHeight:(CGFloat)height Font:(UIFont *)font;
+(CGFloat)getSpaceLabelHeight:(NSString *)str withWidh:(CGFloat)width Font:(UIFont *)font;

/// 输出model各属性
/// @param modelObject model对象
+ (NSString *)modelDescriptionWithClass:(id)modelObject;

+ (BOOL)isIphoneX;
+ (CGFloat)statusBarHeight;
+ (CGFloat)navBarHeight;
+ (CGFloat)tabBarHeight;
+ (CGFloat)safeAreaHeight;

//userDefaults设置
+ (void)setUserDefaultsWithKey:(NSString *)key
                         value:(id)value;
//userDefaults获取
+ (id)getUserDefaultsWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
