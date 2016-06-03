//
//  ModifyUNameController.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ModifyUNameController.h"

@interface ModifyUNameController ()
@property (weak, nonatomic) IBOutlet UITextField *textfiled;

@end

@implementation ModifyUNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改用户名";
    //创建导航栏按钮
    [self createBarItem];
    [self.textfiled becomeFirstResponder];
}

- (void)createBarItem{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightAction:(UIBarButtonItem *)item{
    DLog(@"保存");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
