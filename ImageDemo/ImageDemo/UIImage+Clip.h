//
//  UIImage+Clip.h
//  ImageDemo
//
//  Created by default on 2018/7/17.
//  Copyright © 2018年 default. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImage (Clip)
#pragma mark - 按照size改变图片 图片可能会被拉伸
- (UIImage *)thumWithSize:(CGSize)size;
- (UIImage *)rotateWithOrientation:(UIImageOrientation)orientation;

@end
