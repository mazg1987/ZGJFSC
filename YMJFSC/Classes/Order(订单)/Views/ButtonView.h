//
//  ButtonView.h
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonView;
typedef void(^ClickButtonViewBlock)(ButtonView *btnView);

@interface ButtonView : UIView

@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,strong)ClickButtonViewBlock btnBlock;

+ (instancetype)buttonView;

@end
