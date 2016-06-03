//
//  FootView.h
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootView : UIView

@property (weak, nonatomic) IBOutlet UILabel *footSumLabel;
- (IBAction)footBtnAction:(id)sender;

+ (instancetype)footView;

@end
