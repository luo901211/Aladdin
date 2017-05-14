//
//  UserInfoListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserInfoListVC.h"
#import "UserInfoListViewModel.h"

@interface UserInfoListVC ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UserInfoListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) UIImage *selectImage;

@end

@implementation UserInfoListVC

- (UserInfoListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[UserInfoListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.accountTextField.enabled = NO;
    self.saveButton.layer.cornerRadius = self.saveButton.height/2;
    [self loadData];
}

- (void)loadData {
    @weakify(self)
    [self.viewModel loadDataWithComplete:^(NSString *msg) {
        @strongify(self)
        if (msg) {
            [MBProgressHUD showAutoMessage:msg];
        }else{
            self.accountTextField.text = self.viewModel.userInfo[@"mobile"];
            self.nameTextField.text = self.viewModel.userInfo[@"real_name"];
            self.addressTextField.text = self.viewModel.userInfo[@"address"];
            self.companyTextField.text = self.viewModel.userInfo[@"company"];
            self.positionTextField.text = self.viewModel.userInfo[@"position"];
        }
    }];
}

- (IBAction)save:(UIButton *)sender {
    //    token：必传，用户标识
    //    real_name：必传
    //    address：必传
    //    company：必传
    //    position：必传
    //    pic ： 必传，name=pic, 使用file方式上传图像
    NSDictionary *params = @{
                             @"real_name": self.nameTextField.text,
                             @"address": self.addressTextField.text,
                             @"company": self.companyTextField.text,
                             @"position": self.positionTextField.text,
                             @"pic": @""
                             };
    [self.viewModel saveDataWithParams:params complete:^(NSString *msg) {
        if (msg) {
            [MBProgressHUD showAutoMessage:msg];
        }else{
            [MBProgressHUD showAutoMessage:@"保存成功"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressedOnImagePickerButton:(UIButton *)sender {
    
    if (self.selectImage) {
        // 提示删除操作
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"移除图片", nil];
        actionSheet.tag = 1000;
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
    }else{
        // 提示选择图片操作
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"现在拍摄", @"相册选取", nil];
        actionSheet.tag = 900;
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
    }
}

- (void)setSelectImage:(UIImage *)selectImage {
    _selectImage = selectImage;
    [self.avatarButton setImage:selectImage ? : [UIImage imageNamed:@"upload_image_item"] forState:UIControlStateNormal];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 1000:
        {
            if (buttonIndex == 0) {
                self.selectImage = nil;
            }
        }
            break;
            
        case 900:
        {
            if (buttonIndex != 0 && buttonIndex != 1) {
                return;
            }
            // 1.判断相册是否可以打开
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && buttonIndex == 0) {
                return [MBProgressHUD showAutoMessage:@"没有设置访问相机权限"];
            }
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && buttonIndex == 1) {
                return [MBProgressHUD showAutoMessage:@"没有设置访问相册权限"];
            }
            
            // 2. 创建图片选择控制器
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            
            if (buttonIndex == 0) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else if (buttonIndex == 1) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigationController.navigationBar setBarTintColor:GLOBAL_TINT_COLOR];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    navigationController.navigationBar.titleTextAttributes = dict;
}

#pragma mark - UIImagePickerController
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    __block UIImage *image = nil;
    image = [info[UIImagePickerControllerEditedImage] copy];
    image = [info[UIImagePickerControllerOriginalImage] copy];
    
    NSParameterAssert(image);
    self.selectImage = image;
}

#pragma mark - Table view data source
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;//section头部高度
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

@end
