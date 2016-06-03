//
//  ShoppingCell.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ShoppingCell.h"
#import "ResponseObject.h"

@implementation ShoppingCell

- (void)awakeFromNib {
    //关闭选中按钮的交互功能
    _selBtn.enabled = NO;
    _nameLabel.font = k_Font_Small;
    _priceLabel.font = k_Font_Small;
    _buyCountLabel.font = k_Font_LessThenBig;
    _priceLabel.textColor = k_color_normal_red;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProModel:(ProductModel *)proModel{
    _proModel = proModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_proModel.thumbnail]];
    _nameLabel.text = _proModel.name;
    _priceLabel.text = [NSString stringWithFormat:@"%@积分",_proModel.subtotal];
    _buyCountLabel.text = [NSString stringWithFormat:@"%@",_proModel.quantity];
}

- (IBAction)lessAction:(id)sender {
    //Request_Method_update_goods
    NSInteger count = [_proModel.quantity integerValue];
    if (count>=1) {
        count--;
    }
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"goods_id"] = _proModel.goods_id;
    paramters[@"product_id"] = _proModel.product_id;
    paramters[@"num"] = @(count);
    
    [self requestWithDictionary:paramters];
}

- (IBAction)moreAction:(id)sender {
    NSInteger count = [_proModel.quantity integerValue];
    count++;
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"goods_id"] = _proModel.goods_id;
    paramters[@"product_id"] = _proModel.product_id;
    paramters[@"num"] = @(count);
    
    [self requestWithDictionary:paramters];
}


- (void)requestWithDictionary:(NSDictionary *)dict{
    [HttpRequest httpRequestGET:Request_Method_update_goods parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        if (self.delegate ) {
            [self.delegate passValueWithDictionary:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:nil];
}

//功能关闭，交给tableView处理
- (IBAction)selectAction:(id)sender {
}
@end
