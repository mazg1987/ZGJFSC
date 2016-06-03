//
//  RecommonCell.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "RecommonCell.h"
#import "ResponseObject.h"

//全局变量，用于处理购物车列表是否需要刷新
extern BOOL needReloadShoppingList;

@implementation RecommonCell

- (void)setUpFrame{
#define IconViewW self.frame.size.height
#define PaddIng 10
#define TitleLabelWidth W(180)
#define TitleLableHeight 30
#define BuyButtonWidth self.frame.size.height-2*PaddIng
    _iconView.frame = CGRectMake(0, 0, IconViewW, IconViewW);
    _titlelabel.frame = CGRectMake(IconViewW +PaddIng, PaddIng, TitleLabelWidth, TitleLableHeight);
    _priceLabel.frame = CGRectMake(IconViewW +PaddIng, 2*PaddIng+TitleLableHeight, TitleLabelWidth, TitleLableHeight);
    _buyBtn.frame = CGRectMake(CGRectGetMaxX(_titlelabel.frame), PaddIng, BuyButtonWidth, BuyButtonWidth);
    _buyCountLabel.frame =_buyBtn.frame;
}

- (void)awakeFromNib {
    _titlelabel.font = k_Font_Normal;
    _titlelabel.textColor = k_color_black;
    
    _priceLabel.font = k_Font_Normal;
    _priceLabel.textColor= k_color_normal_red;
    
    _buyCountLabel.font = k_Font_Normal;
    _buyCountLabel.textColor= k_color_black;
    _buyCountLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setUpFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(GoodModel *)model{
    _model = model;
    _buyCountLabel.hidden = YES;
    _buyBtn.hidden = NO;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_model.src]];
    _titlelabel.text = _model.name;
    _priceLabel.text= _model.price;
}

- (void)setPayModel:(ProductModel *)payModel{
    _payModel = payModel;
    _buyCountLabel.hidden = NO;
    _buyBtn.hidden = YES;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_payModel.thumbnail]];
    _titlelabel.text = _payModel.name;
    _priceLabel.text= [NSString stringWithFormat:@"%@",_payModel.subtotal];
    //购买数量
    _buyCountLabel.text = [NSString stringWithFormat:@"✖️%@",_payModel.quantity];
}

- (void)setOrderProductModel:(ProductModel *)orderProductModel{
    _orderProductModel = orderProductModel;
    _buyCountLabel.hidden = NO;
    _buyBtn.hidden = YES;
    
    //这里服务器返回的图片数据有问题，使用的是默认情况下的占为图片
    _iconView.image = ImageNamed(@"goods1");
    _titlelabel.text = _orderProductModel.name;
    _priceLabel.text = [NSString stringWithFormat:@"%@积分",_orderProductModel.score];
    _buyCountLabel.text = [NSString stringWithFormat:@"✖️%@",_orderProductModel.quantity];
}

- (IBAction)buyBtnPressed:(id)sender {
    DLog(@"购买----------------");
    if ([UserModel logoStatus] == 0) {
        [MBProgressHUD showMessage:@"登录后方可添加购物车" toView:self.superview.superview.superview afterDelty:1.0];
        return;
    }
    
    if ([_model.store integerValue]==0) {
        [MBProgressHUD showMessage:@"库存为空，不能添加购物车" toView:self.superview.superview.superview afterDelty:1.0];
        return;
    }
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"goods_id"] = _model.goods_id;
    paramters[@"product_id"] = _model.product_id;
    paramters[@"num"] = @1;
    [HttpRequest httpRequestGET:Request_Method_addShopping parameters:paramters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        needReloadShoppingList = YES;
        //提示添加购物车成功
        [MBProgressHUD showMessage:obj.message toView:self.superview.superview.superview afterDelty:1.0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:nil];
    
}
@end
