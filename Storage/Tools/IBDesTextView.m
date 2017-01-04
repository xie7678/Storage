//
//  IBDesTextView.m
//  Storage
//
//  Created by Sam on 16/12/21.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "IBDesTextView.h"

@implementation IBDesTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_placeholder.length > 0) {
        
        if (_placeholderLabel == nil) {
            
            _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, CGRectGetWidth(self.frame) - 16, 30)];
            
            _placeholderLabel.textColor = [UIColor lightGrayColor];
            
            _placeholderLabel.textAlignment = NSTextAlignmentLeft;
            
            _placeholderLabel.alpha = 1;
            
            [self addSubview:_placeholderLabel];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        
    }
    
    //首行缩进
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;    //行间距
    //    paragraphStyle.maximumLineHeight = 60;   /**最大行高*/
    paragraphStyle.firstLineHeadIndent = 15;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentLeft;
//    NSTextAlignmentJustified;
    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    
//    _placeholderLabel = [UILabel ];
    
}

- (void) setPlaceholderFont:(CGFloat)placeholderFont {
    
    _placeholderFont = placeholderFont;
    
    _placeholderLabel.font = [UIFont systemFontOfSize:placeholderFont];
    
}

- (void) setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    
    self.layer.borderColor = borderColor.CGColor;
    
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
    
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
    
    self.layer.masksToBounds = cornerRadius > 0 ? true : false;
}

- (void) setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    
    if (_placeholder.length > 0) {
        
        if (_placeholderLabel == nil){
            
            _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
            
            _placeholderLabel.font = [UIFont systemFontOfSize:14.0];
            
            _placeholderLabel.textColor = [UIColor lightGrayColor];
            
            _placeholderLabel.textAlignment = NSTextAlignmentLeft;
            
            _placeholderLabel.alpha = 1;
            
            [self addSubview:_placeholderLabel];
            
//            [_placeholderLabel sizeToFit];
        }
    }
    
    _placeholderLabel.text = placeholder;
    
}

- (void) setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
    
    self.layer.borderWidth = borderWidth;
    
}

- (void) textViewDidChange: (NSNotification *) noti {
    
    IBDesTextView *tv = (IBDesTextView *)noti.object;
    
    if (tv.text.length > 0) {
        _placeholderLabel.alpha = 0;
    } else {
        _placeholderLabel.alpha = 1;
    }
    
//    NSLog(@"text == %@",noti.object);
}

@end
