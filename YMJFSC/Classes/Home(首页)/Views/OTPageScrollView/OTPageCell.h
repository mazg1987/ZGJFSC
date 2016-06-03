//
//  OTPageCell.h
//  OTPageScrollView
//
//  Created by Yangxingyi on 15-10-26.
//

#import <UIKit/UIKit.h>

@interface OTPageCell : UIView

@property (strong, nonatomic) UIView* contentView;
@property (strong, nonatomic) UIView* selectedBackgroundView;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString* identifiy;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithIdentifiy:(NSString*)identifiy;

@end


