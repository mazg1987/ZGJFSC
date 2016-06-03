//
//  ShoppingCell.h
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@protocol ShoppingCellDelegate <NSObject>
- (void)passValueWithDictionary:(NSDictionary *)dict;
@end

@interface ShoppingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@property (nonatomic,strong)ProductModel *proModel;

@property (nonatomic,weak)id<ShoppingCellDelegate>delegate;

- (IBAction)lessAction:(id)sender;
- (IBAction)moreAction:(id)sender;
- (IBAction)selectAction:(id)sender;

@end
