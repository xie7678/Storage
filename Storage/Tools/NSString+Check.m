//
//  NSString+Phone.m
//  tranb
//
//  Created by Daniel_Li on 14/10/22.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL) checkIsStock {
    
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^\\+?[1-9][0-9]*$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)checkStringLegal{

    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"illegalString" ofType:@"txt"];
    NSString *stringViaText = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSString *regex =  [NSString stringWithFormat:@"%@",self];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd]  %@", regex];
    return ![pred evaluateWithObject:stringViaText];
    
}

- (BOOL)chechChineseName{
    
    if (self == nil || self.length == 0) {
        return NO;
    }
    NSString *regex =  @"^[\u4e00-\u9fa5]{2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


- (NSString *)transChineseNameIsValidateToMessage{

    if (self == nil || self.length == 0) {
        return nil;
    }
    
    if (self && self.length > 5) {
        return @"姓名必须是中文，2-5个汉字！";
    }
    
    if (![self chechChineseName]) {
        return  @"姓名必须是中文，2-5个汉字！";
    }
    
    if (![self checkStringLegal]) {
       return @"请输入正确的姓名，不要输入非法字符";
    }
    
    return nil;
}


- (BOOL)checkPassword{
    if (self == nil || self.length == 0) {
        return NO;
    }
    NSString *regex = @"\\b\\w{6,32}\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
- (BOOL)checkIsWechat {
    
    return false;
}
- (BOOL)checkIsEmail{
    if (self == nil || self.length == 0) {
        return YES;
    }
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
- (BOOL)checkIsPhoneNum
{
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(177)|(176)|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)checkIsMoney
{
    if (self == nil || self.length == 0 || self.length > 8 || self.floatValue <= 0) {
        return NO;
    }
    
    NSString *regex = @"^(([0-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)transToMoney
{
    if ([self rangeOfString:@"."].location != NSNotFound) {
        NSString *regex = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0})?$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:self]) {
            return [self stringByAppendingString:@"00"];
        }
        
        regex = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1})?$";
        pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:self]) {
            return [self stringByAppendingString:@"0"];
        }
    }
    return self;
}
- (BOOL)stringContainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
         return returnValue;
     }
@end
