//
//  ButtonView.m
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@end

@implementation ButtonView

- (void)awakeFromNib{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    [self addGestureRecognizer:tapGes];
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (_selected == YES) {
        self.titleLabel.backgroundColor = k_color_white;
        self.statusView.backgroundColor = k_color_normal_red;
    }
    else{
        self.titleLabel.backgroundColor = k_color_gray_75;
        self.statusView.backgroundColor = k_color_gray_75;
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)doTap:(UITapGestureRecognizer *)ges{
    if (self.btnBlock) {
        self.btnBlock(self);
    }
}

+ (instancetype)buttonView{
    return [[[NSBundle mainBundle]loadNibNamed:@"ButtonView" owner:nil options:nil] lastObject];
}

@end
