//
//  AddressCell.h
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selStatuView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic,strong)AddressModel *model;

@end
