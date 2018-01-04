//
//  AddWorkersController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/13/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "AddWorkersController.h"
/// kits
#import "AliOSSKit.h"
#import "MYUser.h"
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
/// views
#import "AddWorkerPickerVC.h"
#import "NMTextField.h"


@interface AddWorkersController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, AliOSSKitDelegate>

@property (nonatomic,strong) UIImage *img;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *pickerIdentifer;
@property (nonatomic,strong) NSArray *proArr;
@property (nonatomic,strong) NSArray *workerTypeArr;
@property (nonatomic,strong) NSDictionary *selectedWorkerTypeDic;
@property (nonatomic,strong) NSDictionary *selectedCityDic;



@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet NMTextField *nameTextField;
@property (weak, nonatomic) IBOutlet NMTextField *telTextField;
@property (weak, nonatomic) IBOutlet UILabel *workerTypeLabel;
@property (weak, nonatomic) IBOutlet NMTextField *idNumTextField;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet NMButton *commitBtn;

@end

@implementation AddWorkersController

# pragma mark - click btn
- (IBAction)clickAddHeaderBtn:(id)sender {
    UIImagePickerController *imgPicCon = [[UIImagePickerController alloc] init];
    imgPicCon.delegate = self;
    imgPicCon.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imgPicCon.allowsEditing = YES;
    
    [self presentViewController:imgPicCon animated:YES completion:^{
    }];
}
- (IBAction)clickAddWorkerTypeBtn:(id)sender {
    [self resignTextInput];
    self.pickerIdentifer = @"worker";
    [self performSegueWithIdentifier:@"menu" sender:self];
}
- (IBAction)clickPickCityBtn:(id)sender {
    [self resignTextInput];
    self.pickerIdentifer = @"city";
    [self performSegueWithIdentifier:@"menu" sender:self];
}
- (IBAction)clickBackGround:(id)sender {
    [self resignTextInput];
}

-(void)resignTextInput{
    [self.nameTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.idNumTextField resignFirstResponder];
}

- (IBAction)clickCommitBtn:(id)sender {
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDict = @{@"token": token,
                                @"personalname":self.nameTextField.text,
                                @"tel":self.telTextField.text,
                                @"province":self.selectedCityDic[@"province"] ,
                                @"idcard":self.idNumTextField.text,
                                @"city":self.selectedCityDic[@"city"],
                                @"area": self.selectedCityDic[@"area"],
                                @"workTypeId":self.selectedWorkerTypeDic[@"id"] ,
                                @"image":@""};
    
    [[BeeNet sharedInstance]requestWithType:Request_POST andUrl:@"/typework/personalIOE" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        [SVProgressHUD showWithStatus:@"上传成功！"];
        [SVProgressHUD dismissWithDelay:0.5];
        [self.navigationController popViewControllerAnimated:YES];
    } andFailed:^(NSString *str) {
        // failed
    }];
}


# pragma mark - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AddWorkerPickerVC *controller = segue.destinationViewController;
    controller.identifier = self.pickerIdentifer;
    controller.workerTypeArr = self.workerTypeArr;
    controller.proArr = self.proArr;
}


# pragma mark - return image
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    NSLog(@"%@",info);
//    NSURL *url = info[UIImagePickerControllerReferenceURL];
//    PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
//    PHAsset *asset = [result firstObject];
//    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
//
//    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:phImageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//        UIImage *image = [UIImage imageWithData:imageData];
//        self.img = image;
//        [self.headImgView setImage:image];
//    }];
//    [picker dismissViewControllerAnimated:YES completion:^{
//        // done
//    }];
    
    UIImage* editImg = info[UIImagePickerControllerEditedImage];
    self.img = editImg;
    [self.headImgView setImage:editImg];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)setImg:(UIImage *)img{
    _img = img;
    NSDate *date = [NSDate date];
    NSInteger tStamp = [date timeIntervalSince1970];
    NSString *imgName = [NSString stringWithFormat:@"iOS_%ld.jpeg",tStamp];
    
    AliOSSKit *kit = [[AliOSSKit alloc] init];
    kit.delegate = self;
    [kit pushImage:img withName:imgName];
}

-(void)aliKitFinishUploadImg:(UIImage *)img withName:(NSString *)imgName{
    self.imgUrl = imgName;
}

# pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStatesAtBackGround];
    [self loadWorkerTypesAtBackGround];
}


-(BOOL)canAddTheWorker{
    
    if (self.img) {
        if (self.nameTextField.text) {
            if (self.telTextField.text) {
                if (self.workerTypeLabel) {
                    if (![self.workerTypeLabel.text isEqualToString:@""]) {
                        if (![self.cityLabel.text isEqualToString:@""]) {
                            if (![self.idNumTextField.text isEqualToString:@""]) {
                                return YES;
                            }
                        }
                    }
                }
            }
        }
    }
    return NO;
}

# pragma mark - request
// 请求省
-(void)loadStatesAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // Thread 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getAllProvice", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.proArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue1 addOperation:operation1];
    
}

// 请求工种
-(void)loadWorkerTypesAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // Thread 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getAllWorkType", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.workerTypeArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue1 addOperation:operation1];
    
}


# pragma mark - unwind segue
-(IBAction)unWindToViewController:(UIStoryboardSegue *)segue{
    AddWorkerPickerVC *controller = [segue sourceViewController];
    if ([controller.identifier isEqualToString:@"city"]) {
        if (controller.selectedCityDic) {
            self.selectedCityDic = controller.selectedCityDic;
            self.cityLabel.text = controller.selectedCityDic[@"area"];
        }
    }else{
        if (controller.selectedWorkerTypeDic) {
            self.selectedWorkerTypeDic = controller.selectedWorkerTypeDic;
            self.workerTypeLabel.text = controller.selectedWorkerTypeDic[@"name"];
        }
    }
    if ([self canAddTheWorker]) {
        [self.commitBtn setBackgroundColor:[UIColor colorWithHexString:@"429BFF"]];
        [self.commitBtn setEnabled:YES];
    }
}


@end
