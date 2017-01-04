//
//  CustomButton.h
//  Storage
//
//  Created by Sam on 16/12/22.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CustomButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *borderColor;

@end
