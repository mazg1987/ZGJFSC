//
//  EditViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
- (IBAction)cancelPickerAction:(id)sender;
- (IBAction)okPickerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *bgPickerView;

@property (nonatomic,strong) UIView *coverView;
//pickerView数据
@property (nonatomic,strong)NSDictionary *allDics;
@property (nonatomic,strong)NSDictionary *selectProvinceDic;
@property (nonatomic,strong)NSArray *allProvinces;
@property (nonatomic,strong)NSArray *allCitys;
@property (nonatomic,strong)NSArray *allTowns;

//地址数据
@property (nonatomic,strong)NSString *selPovince;
@property (nonatomic,strong)NSString *selCity;
@property (nonatomic,strong)NSString *selTown;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.model) {
        _nameTextField.text = _model.name;
        _phoneTextField.text = _model.mobile;
        _areaLabel.text = [NSString stringWithFormat:@"%@/%@/%@",_model.province,_model.city,_model.town];
        _addressTextField.text = _model.addr;
        
        self.selPovince = _model.province;
        self.selCity = _model.city;
        self.selTown = _model.town;
    }
    
    //加载pickerView数据
    [self setUpPickerViewData];
    //设置视图
    [self setUpView];
}

- (void)setUpView{
    _nameTextField.font = k_Font_Normal;
    _phoneTextField.font = k_Font_Normal;
    _areaLabel.font = k_Font_Normal;
    _addressTextField.font = k_Font_Normal;
    
    _nameTextField.textColor = k_color_black;
    _phoneTextField.textColor = k_color_black;
    _areaLabel.textColor = k_color_gray_45;
    _addressTextField.textColor = k_color_black;
    
    //给label添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicker:)];
    self.areaLabel.userInteractionEnabled = YES;
    [self.areaLabel addGestureRecognizer:tapGes];
    
    //设置pickerView为看不见,设置遮盖的view
    setFrameY(self.bgPickerView, kScreenHeight);
    
    self.coverView = [[UIView alloc]init];
    self.coverView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.coverView.alpha = 0.4;
    self.coverView.backgroundColor = k_color_gray_60;
    self.coverView.hidden = YES;
    [self.view addSubview:self.coverView];
    
    //将pickerview视图移到前面，避免被遮盖
    [self.view bringSubviewToFront:self.bgPickerView];
    
    //导航栏按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//设置pickerView的初始数据
- (void)setUpPickerViewData{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Address.plist" ofType:nil];
    self.allDics = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //所有省份
    self.allProvinces = [self.allDics allKeys];
    //选中的省份
    self.selectProvinceDic = self.allDics[self.allProvinces[0]][0];
    //选中省份对应的所有城市
    self.allCitys = [self.selectProvinceDic allKeys];
    //选中省份对应的选中城市的所有区
    self.allTowns = self.selectProvinceDic[self.allCitys[0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//导航栏右侧按钮点击后保存数据(请求服务器)
- (void)rightItemAction:(UIBarButtonItem *)item{
    if (IsNilString(_nameTextField.text) ||IsNilString(_phoneTextField.text)||IsNilString(_areaLabel.text) ||IsNilString(_addressTextField.text)) {
        [MBProgressHUD showMessage:@"信息不能为空" toView:self.view afterDelty:1.0];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"province"] = self.selPovince;
    parameters[@"city"] = self.selCity;
    parameters[@"district"] = self.selTown;
    parameters[@"addr"] = self.addressTextField.text;
    parameters[@"name"] = self.nameTextField.text;
    parameters[@"mobile"] = self.phoneTextField.text;
    parameters[@"zip"] = @"000000";
    if (self.model) {
        parameters[@"addr_id"] = self.model.addr_id;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestPOST:Request_Method_shippingsave parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //保存成功后退出当前控制器
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}

- (void)showPicker:(UITapGestureRecognizer *)ges{
    DLog(@"tap");
    [UIView animateWithDuration:0.5 animations:^{
        setFrameY(self.bgPickerView, H(311));
        self.coverView.hidden = NO;
    }];
}
//隐藏pickerView
- (IBAction)cancelPickerAction:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        setFrameY(self.bgPickerView,kScreenHeight);
        self.coverView.hidden = YES;
    }];
}

//设置数据并隐藏pickerView
- (IBAction)okPickerAction:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        setFrameY(self.bgPickerView,kScreenHeight);
        self.coverView.hidden = YES;
    }];
    self.selPovince = self.allProvinces[[self.pickerView selectedRowInComponent:0]];
    self.selCity = self.allCitys[[self.pickerView selectedRowInComponent:1]];
    self.selTown = self.allTowns[[self.pickerView selectedRowInComponent:2]];
    self.areaLabel.text = [NSString stringWithFormat:@"%@/%@/%@",self.selPovince,self.selCity,self.selTown];
}


#pragma mark UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.allProvinces.count;
    }
    else if(component == 1){
        return self.allCitys.count;
    }
    else{
        return self.allTowns.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return self.allProvinces[row];
    }
    else if(component == 1){
        return self.allCitys[row];
    }
    else{
        return self.allTowns[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.selectProvinceDic = self.allDics[self.allProvinces[row]][0];
        self.allCitys = [self.selectProvinceDic allKeys];
        self.allTowns = self.selectProvinceDic[self.allCitys[0]];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    else if(component ==1){
        self.allTowns = self.selectProvinceDic[self.allCitys[row]];
        [pickerView reloadComponent:2];
    }
}
@end
