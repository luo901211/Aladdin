//
//  QuestionReportVC.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionReportVC.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "NSString+Additions.h"
#import "QuestionReportViewModel.h"

#define kQuestionMaxLength 500
@interface QuestionReportVC ()<UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imagePickerButtons;
@property (strong, nonatomic) NSMutableArray *imageDataArray;
@property (assign, nonatomic) NSInteger pressedButtonIndex;

@property (strong, nonatomic) QuestionReportViewModel *viewModel;
@end

@implementation QuestionReportVC

- (QuestionReportViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QuestionReportViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableArray *)imageDataArray {
    if (!_imageDataArray) {
        _imageDataArray = [NSMutableArray array];
    }
    return _imageDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"提问";
    
    if (self.expertModel) {
        self.avatarImageV.layer.cornerRadius = self.avatarImageV.height/2;
        [self.avatarImageV sd_setImageWithURL:[NSURL URLWithString:self.expertModel.pic_url]];
        self.nameLabel.text = self.expertModel.real_name;
        self.companyLabel.text = self.expertModel.company;
        self.positionLabel.text =  self.expertModel.position;
    }else{
        self.bannerHeight.constant = 0;
    }
    self.submitButton.layer.cornerRadius = 4;

    self.textView.placeholder = @"请尽可能详细地描述您的具体问题";
    self.textView.placeholderColor = HEXCOLOR(0xcdcdcd);
    self.textView.delegate = self;
    self.lengthLabel.text = [NSString stringWithFormat:@"0/%d",kQuestionMaxLength];
}
- (IBAction)didPressedOnSubmitButton:(UIButton *)sender {
    
    if ([self.titleTextField.text chineseTextLength] > 40) {
        return [MBProgressHUD showAutoMessage:@"标题字数超过最长限制"];
    }
    
    if ([self.textView.text chineseTextLength] > kQuestionMaxLength) {
        return [MBProgressHUD showAutoMessage:@"问题描述字数超过最长限制"];
    }
    
    NSString *title = self.titleTextField.text;
    NSString *content = self.textView.text;
    NSInteger expertID = self.expertModel.ID;
    NSMutableArray *pics = self.imageDataArray;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.viewModel submitQuestionWithTitle:title content:content expertID:expertID pics:pics success:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showAutoMessage:@"提问成功"];
    } failure:^(id obj) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showAutoMessage:obj];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressedOnImagePickerButton:(UIButton *)sender {
    NSInteger index = [self.imagePickerButtons indexOfObject:sender];
    self.pressedButtonIndex = index;
    
    if (index < self.imageDataArray.count) {
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

- (void)reloadImageButtons {
    for (int i = 0; i < self.imagePickerButtons.count; i++) {
        UIButton *button = self.imagePickerButtons[i];
        
        if (i < self.imageDataArray.count) {
            UIImage *image = self.imageDataArray[i];
            [button setImage:image forState:UIControlStateNormal];
            button.hidden = NO;
        }else{
            [button setImage:[UIImage imageNamed:@"question_image_picker_button"] forState:UIControlStateNormal];
            button.hidden = (i == self.imageDataArray.count) ? NO : YES;
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 1000:
        {
            if (buttonIndex == 0) {
                [self.imageDataArray removeObjectAtIndex:self.pressedButtonIndex];
                [self reloadImageButtons];
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
    [self.imageDataArray addObject:image];
    [self reloadImageButtons];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.lengthLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)[textView.text chineseTextLength], kQuestionMaxLength];
    if ([textView.text chineseTextLength] > kQuestionMaxLength) {
        self.lengthLabel.textColor = HEXCOLOR(0xe64340);
    }else{
        self.lengthLabel.textColor = HEXCOLOR(0x999999);
    }
}

@end
