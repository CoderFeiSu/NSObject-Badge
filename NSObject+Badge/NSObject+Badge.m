//
//  NSObject+Badge.m
//  NSObject+BadgeExample
//
//  Created by 飞飞 on 16/9/23.
//  Copyright © 2016年 FeiFei. All rights reserved.
//

#import "NSObject+Badge.h"
#import <objc/runtime.h>

@implementation NSObject (Badge)
static const char badgeValueKey;
static const char badgeValueViewKey;
- (void)setFf_badgeValue:(NSString *)ff_badgeValue {
    if (![self isKindOfClass:[UIView class]] && ![self isKindOfClass:[UIBarButtonItem class]] && ![self isKindOfClass:[UITabBarItem class]]) return;
    
    objc_setAssociatedObject(self, &badgeValueKey, ff_badgeValue, OBJC_ASSOCIATION_COPY);
    
    UIView *view = nil;
    if ([self isKindOfClass:[UIView class]]) view = (UIView *)self;
    if ([self isKindOfClass:[UIBarButtonItem class]] || [self isKindOfClass:[UITabBarItem class]]) view = [self valueForKeyPath:@"_view"];
    
    
    // 设置初始值
    CGSize badgeValueSize = CGSizeMake(12.0, 12.0);
    if (!self.badgeValueView) {
        self.badgeValueView = [[UIImageView alloc] init];
        self.badgeValueView.image = [self getBadgeValueImageWithSize:badgeValueSize WithToView:view];
        CGFloat badgeValueViewX = view.frame.size.width - badgeValueSize.width * 0.5;
        CGFloat badgeValueViewY =  -badgeValueSize.height * 0.5;
        CGFloat badgeValueViewW = badgeValueSize.width;
        CGFloat badgeValueViewH = badgeValueSize.height;
        self.badgeValueView.frame = CGRectMake(badgeValueViewX, badgeValueViewY, badgeValueViewW, badgeValueViewH);
        self.badgeValueView.alpha = 0.0;
        [view addSubview:self.badgeValueView];
        [UIView animateWithDuration:1.0 animations:^{
            self.badgeValueView.alpha = 1.0;
        }];
        
    } else {
        
        if (self.badgeValueView.superview == nil) [view addSubview:self.badgeValueView];
        
        [UIView animateWithDuration:1.0 animations:^{
            if (self.badgeValueView.alpha == 0) self.badgeValueView.alpha = 1.0;
        }];
        
        self.badgeValueView.image = [self getBadgeValueImageWithSize:badgeValueSize WithToView:view];
        
        if ([ff_badgeValue isEqualToString:@"0"]) [self ff_hide];
    }
    
}


- (UIImage *)getBadgeValueImageWithSize:(CGSize)badgeValueSize WithToView:(UIView *)toView {
    
    CGRect rect = CGRectMake(0, 0, badgeValueSize.width, badgeValueSize.height);
    // 画红色的圆
    UIGraphicsBeginImageContext(badgeValueSize);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [[UIColor redColor] setFill];
    [path fill];
    // 画白色的数字
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                            NSFontAttributeName : [UIFont systemFontOfSize:10.0]
                            };
    CGSize size =  [self.ff_badgeValue sizeWithAttributes:attrs];
    [self.ff_badgeValue drawAtPoint:CGPointMake((badgeValueSize.width - size.width) * 0.5, (badgeValueSize.height - size.height) * 0.5) withAttributes:attrs];
    // 得到图片,结束上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (void)ff_hide {
    
    [UIView animateWithDuration:.5 animations:^{
        self.badgeValueView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.badgeValueView removeFromSuperview];
    }];
    
    
}


- (void)setBadgeValueView:(UIImageView *)badgeValueView {
    objc_setAssociatedObject(self, &badgeValueViewKey, badgeValueView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImageView *)badgeValueView {
    return objc_getAssociatedObject(self, &badgeValueViewKey);
}



- (NSString *)ff_badgeValue {
    return objc_getAssociatedObject(self, &badgeValueKey);
}

@end
