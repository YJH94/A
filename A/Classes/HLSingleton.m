//
//  HLSingleton.m
//  HLBabyCare
//
//  Created by 姚军辉 on 2020/4/2.
//  Copyright © 2020 KeWen. All rights reserved.
//

#import "HLSingleton.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <objc/runtime.h>

@interface HLSingleton ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation HLSingleton

+ (HLSingleton *)defaultSingleton
{
    static HLSingleton *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLSingleton alloc] init];
    });
    return singleton;
}

//TODO 可用runtime实现
+ (NSString *)modelDescriptionWithClass:(id)modelObject
{
#if DEBUG
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    uint count;
    objc_property_t *properties = class_copyPropertyList([modelObject class], &count);
    for (int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithFormat:@"%s",property_getName(properties[i])];
        id value = [modelObject valueForKey:name] ?:@"nil";
        [dict setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@:%p>:%@",[modelObject class],self,dict];
#endif
    return @"";
}

+ (BOOL)isIphoneX {
    BOOL isIPhoneX;
    // iPhone X以上设备iOS版本一定是11.0以上。
    if(@available(iOS 11.0, *))
    {
        // 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X以上设备。
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0)
        {
            isIPhoneX = YES;
        }else
        {
            isIPhoneX = NO;
        }
    }else
    {
        isIPhoneX = NO;
    }
    
    return isIPhoneX;
}

+ (CGFloat)statusBarHeight{
    return [self isIphoneX] ? 44 : 20;
}

+ (CGFloat)navBarHeight {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}

+ (CGFloat)safeAreaHeight {
    return [self isIphoneX] ? 34 : 0;
}

+(CGFloat)getSpaceLabelWidth:(NSString *)str withHeight:(CGFloat)height Font:(UIFont *)font
{
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing= 0;//设置行距为0
    paragphStyle.firstLineHeadIndent =  0.0;
    paragphStyle.hyphenationFactor=  0.0;
    paragphStyle.paragraphSpacingBefore=  0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:font, NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@0.5f
                        
                        };
    CGSize size=[str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.width;
}

 + (CGFloat)getSpaceLabelHeight:(NSString *)str withWidh:(CGFloat)width Font:(UIFont *)font
{
    if (!font) {
        return 0;
    }
    if ([[NSString stringWithFormat:@"%@",str] isEqualToString:@""])
    {
        return 0;
    }
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing= 0;//设置行距为0
    paragphStyle.firstLineHeadIndent =  0.0;
    paragphStyle.hyphenationFactor=  0.0;
    paragphStyle.paragraphSpacingBefore=  0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:font, NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@0.1f
                        
                        };
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height + 1;
}

//userDefaults设置
+ (void)setUserDefaultsWithKey:(NSString *)key
                         value:(id)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
    if ([defaults synchronize]) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
}

//userDefaults获取
+ (id)getUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

@end
