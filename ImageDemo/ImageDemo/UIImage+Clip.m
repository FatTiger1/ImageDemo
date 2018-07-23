//
//  UIImage+Clip.m
//  ImageDemo
//
//  Created by default on 2018/7/17.
//  Copyright © 2018年 default. All rights reserved.
//

#import "UIImage+Clip.h"

@implementation UIImage (Clip)

- (UIImage *)thumWithSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/*
CGAffineTransform transform = CGAffineTransformIdentity;
 
transform = CGAffineTransformMakeTranslation(20, 20);
等同于
transform = CGAffineTransformTranslate(transform, 20, 20);
 其它的旋转，和缩放操作也是一样。
 
 但如果需要连续操作
 如：
 
 正确//先平移后旋转  则第二个需要采用用没有make的形式，表示在第一个操作的基础上进行第一个操作，如果连续使用带make的形式则只会保留最后一个操作。
 transform = CGAffineTransformMakeTranslation(self.size.width, self.size.height);//平移
 transform = CGAffineTransformRotate(transform, M_PI/9);//旋转
 错误//只会保留平移操作旋转被忽略
 transform = CGAffineTransformMakeRotation(M_PI/9);//旋转
 transform = CGAffineTransformMakeTranslation(self.size.width/5, self.size.height/5);//平移
 另外推荐最后进行旋转操作 优先进行平移操作，方便坐标系判断。
 
 
 以上操作都是对坐标系的操作。
*/

- (UIImage *)rotateWithOrientation:(UIImageOrientation)orientation{

    CGAffineTransform transform = CGAffineTransformIdentity;
    CGSize size = self.size;
    switch (orientation) {
        case UIImageOrientationUp:
            return self;
            break;
        case UIImageOrientationUpMirrored://图片原本状态 取镜像
            transform = CGAffineTransformMakeTranslation(size.width, size.height);//平移
            transform = CGAffineTransformRotate(transform, M_PI);//顺时针旋转180度
            break;
        case UIImageOrientationDown://将图像旋转180°
            transform = CGAffineTransformMakeTranslation(size.width, 0);//平移
            transform = CGAffineTransformScale(transform, -1.0, 1.0);//缩放，如果为负数则是将图片翻转，此处为沿Y轴翻转
            break;
        case UIImageOrientationDownMirrored://将图片旋转180°后取镜像
            break;
        case UIImageOrientationLeft://将图片逆时针旋转90° 此处用transform也可以实现 只是执行到第二步 “transform = CGAffineTransformRotate(transform, -M_PI/2);”的时候坐标系已经被翻转不方便计算，所以采用和CGContext结合的方式进行变换
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(size.width,0);//平移
            transform = CGAffineTransformRotate(transform, M_PI/2);
            break;
        case UIImageOrientationLeftMirrored:
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(size.width,0);//平移
            transform = CGAffineTransformRotate(transform, M_PI/2);
            break;
        case UIImageOrientationRight:
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(0, size.height);//平移
            transform = CGAffineTransformRotate(transform, -M_PI/2);
            break;
        case UIImageOrientationRightMirrored:
           
            size = CGSizeMake(size.height, size.width);
            transform = CGAffineTransformMakeTranslation(0, size.height);//平移
            transform = CGAffineTransformRotate(transform, -M_PI/2);
            break;
        default:
            break;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    switch (orientation) {
        case UIImageOrientationLeft://将上述已经经过一次变化后的图形进行变换
        case UIImageOrientationRight:
            CGContextTranslateCTM(contextRef,0.0,size.height);
            CGContextScaleCTM(contextRef, 1.0, -1.0);//沿x轴翻转
            break;
        default:
            break;
    }
    
    CGContextConcatCTM(contextRef, transform);//
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);//绘制图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();//取出图片
    UIGraphicsEndImageContext();
    return image;
}

@end
