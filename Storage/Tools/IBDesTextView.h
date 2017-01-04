//
//  IBDesTextView.h
//  Storage
//
//  Created by Sam on 16/12/21.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface IBDesTextView : UITextView<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable NSString *placeholder;

@property (nonatomic) IBInspectable CGFloat placeholderFont;

@end
