//
//  CustomButton.m
//  Storage
//
//  Created by Sam on 16/12/22.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    
    self.layer.borderColor = borderColor.CGColor;
    
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
    
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
    
    self.layer.masksToBounds = cornerRadius > 0 ? true : false;
}

- (void) setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
    
    self.layer.borderWidth = borderWidth;
    
}

@end
