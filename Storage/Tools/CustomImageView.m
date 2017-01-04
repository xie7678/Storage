//
//  CustomImageView.m
//  Storage
//
//  Created by Sam on 16/12/23.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

//- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)]; imageView.image = [UIImage imageNamed:@"1"];
//    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    //设置大小
//    maskLayer.frame = imageView.bounds;
//    //设置图形样子
//    maskLayer.path = maskPath.CGPath;
//    
//    imageView.layer.mask = maskLayer;
//    
//    CGRect rect = (CGRect){0.f, 0.f, self.size};
//    
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
//    
//    CGContextAddPath(UIGraphicsGetCurrentContext(),
//                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
//    
//    CGContextClip(UIGraphicsGetCurrentContext());
//    
////    [self drawInRect:rect];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return image;
//}
@end
