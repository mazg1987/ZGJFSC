//
//  AddressCell.m
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = k_color_gray_95;
    [self.editBtn addTarget:nil action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _label1.font = k_Font_Normal;
    _label2.font = k_Font_Normal;
    _label1.textColor = k_color_black;
    _label2.textColor = k_color_black;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(AddressModel *)model{
    _model = model;
    self.label1.text = [NSString stringWithFormat:@"%@  %@",_model.name,_model.mobile];
    self.label2.text = [NSString stringWithFormat:@"%@/%@/%@/%@",_model.province,_model.city,_model.town,_model.addr];
}



@end
