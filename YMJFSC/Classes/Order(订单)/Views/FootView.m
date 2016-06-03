//
//  FootView.m
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "FootView.h"

@implementation FootView

- (IBAction)footBtnAction:(id)sender{
    [MBProgressHUD showMessage:@"此功能在完善" toView:self.superview afterDelty:1.0];
}

+ (instancetype)footView{
    return [[[NSBundle mainBundle]loadNibNamed:@"FootView" owner:nil options:nil] lastObject];
}

@end
