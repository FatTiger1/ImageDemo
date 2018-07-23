//
//  ViewController.m
//  ImageDemo
//
//  Created by default on 2018/7/17.
//  Copyright © 2018年 default. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Clip.h"
@interface ViewController ()

@property(nonatomic, strong)UIScrollView * scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    [self addScrollerView];
    [self addImageViews];
    [self addthirdImageView];
    [self addUIImageOrientationUpMirrored];
    [self addUIImageOrientationDown];
    [self addUIImageOrientationDownMirrored];
    [self addUIImageOrientationLeft];
    [self addUIImageOrientationLeftMirrored];
    [self addUIImageOrientationRight];
    [self addUIImageOrientationRightMirrored];
}

- (void)addScrollerView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
}

- (void)addImageViews{
    CGFloat imageViewY = 20;
    NSArray * array = @[@"",
                        @"UIImageOrientationUpMirrored\n正常状态的镜面图像",
                        @"UIImageOrientationDown\n图片被翻转180°",
                        @"UIImageOrientationDownMirrored\n图片被翻转180°后的镜面图像",
                        @"UIImageOrientationLeft\n图片被逆时针翻转90°",
                        @"UIImageOrientationLeftMirrored\n图片被逆时针翻转90°后的镜面图像",
                        @"UIImageOrientationRight\n图片被顺时针翻转90°",
                        @"UIImageOrientationRightMirrored\n图片被顺时针翻转90°后的镜面图像"];
    for (int i = 0; i < 9; i ++) {
        UIImageView * imageView = nil;
        for (int j = 0; j < 2; j ++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + j*(250), imageViewY + 20, 0, 0)];
            imageView.backgroundColor = [UIColor orangeColor];
            imageView.tag = 100*(i+1) + j;
            imageView.image = [UIImage imageNamed:@"backImage"];
            [self.scrollView addSubview:imageView];
            [imageView sizeToFit];
            if (j == 0) {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), imageView.frame.origin.y, 150, imageView.frame.size.height)];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12];
                label.numberOfLines = 0;
                if (i < array.count) {
                    label.text = array[i];
                }
                [self.scrollView addSubview:label];
            }
        }
        imageViewY = CGRectGetMaxY(imageView.frame);
    }
    self.scrollView.contentSize = CGSizeMake(0, imageViewY);
}

- (void)addthirdImageView{//不做任何修改的transform 和CGContext修改的话 图像的位置不变但 会形成倒立的像，
    UIImageView * imageView = [self.view viewWithTag:100 + 1];
    UIImage * image1 = imageView.image;
    CGImageRef  cgimage = image1.CGImage;
    UIGraphicsBeginImageContext(image1.size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0, 0, image1.size.width, image1.size.height), cgimage);//绘制图片
    UIImage * image2 = UIGraphicsGetImageFromCurrentImageContext();//取出图片
    UIGraphicsEndImageContext();
    imageView.image = image2;
}

- (void)addUIImageOrientationUpMirrored{
    UIImageView * imageView = [self.view viewWithTag:200 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationUpMirrored];
    imageView.image = image2;
}

- (void)addUIImageOrientationDown{
    UIImageView * imageView = [self.view viewWithTag:300 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationDown];
    imageView.image = image2;
}

- (void)addUIImageOrientationDownMirrored{
    UIImageView * imageView = [self.view viewWithTag:400 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationDownMirrored];
    imageView.image = image2;
}

- (void)addUIImageOrientationLeft{
    UIImageView * imageView = [self.view viewWithTag:500 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationLeft];
    imageView.image = image2;
    [imageView sizeToFit];
}

- (void)addUIImageOrientationLeftMirrored{
    UIImageView * imageView = [self.view viewWithTag:600 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationLeftMirrored];
    imageView.image = image2;
    [imageView sizeToFit];
}

- (void)addUIImageOrientationRight{
    UIImageView * imageView = [self.view viewWithTag:700 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationRight];
    imageView.image = image2;
    [imageView sizeToFit];
}

- (void)addUIImageOrientationRightMirrored{
    UIImageView * imageView = [self.view viewWithTag:800 + 1];
    UIImage * image1 = imageView.image;
    UIImage * image2 = [image1 rotateWithOrientation:UIImageOrientationRightMirrored];
    imageView.image = image2;
    [imageView sizeToFit];
}


@end
