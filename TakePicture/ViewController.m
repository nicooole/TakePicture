//
//  ViewController.m
//  TakePicture
//
//  Created by 南珂 on 16/6/2.
//  Copyright © 2016年 Nicole. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //1.检测当前相机是否可用（另一个demo里有，此处就不再写）
    
    //2.配置UIImagePickerController
    [self configImagePickerController];
}
- (void)configImagePickerController
{
    //创建实例
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    //选择数据来源类型 （Camera/Library/Album）
//    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSString *requireMediaType = (__bridge NSString*)kUTTypeImage;
    controller.mediaTypes = [[NSArray alloc] initWithObjects:requireMediaType, nil];
//    controller.allowsEditing = NO;
    controller.delegate = self;
    //闪光灯打开
//    controller.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    //摄像头为前置还是后置
//    controller.cameraDevice =
    //导航推出界面
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}
//info: 1.媒体类型  2.image  3.媒体附加信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //拿到传进来文件的类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        //拿到图像
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //显示图片
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        
        SEL saveImage = @selector(imageWasSaveSuccessful:didFinishSavingWithError:contextInfo:);
        //info可以拿到媒体附加信息
        NSDictionary *dic = [info objectForKey:UIImagePickerControllerMediaMetadata];
        NSLog(@"dic = %@", dic);
        
        //保存图片
        UIImageWriteToSavedPhotosAlbum(image, self, saveImage, nil);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageWasSaveSuccessful:(UIImage *)paraImage didFinishSavingWithError:(NSError *)paraError contextInfo:(void*)paraInfo
{
    if (paraError == nil) {
        NSLog(@"图片保存成功");
    } else {
        NSLog(@"图片保存不成功");
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
