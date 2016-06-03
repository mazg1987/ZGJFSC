//
//  RecommonCell.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"
#import "ProductModel.h"

@interface RecommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;
@property (nonatomic,strong)GoodModel *model;

//结算页面复用了本cell
@property (nonatomic,strong)ProductModel *payModel;

//订单model
@property (nonatomic,strong)ProductModel *orderProductModel;

- (IBAction)buyBtnPressed:(id)sender;

@end
