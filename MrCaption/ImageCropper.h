//
//  ImageCropper.h
//  MrCaption
//
//  Created by Fido Wang on 9/12/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.
//
//
//  ImageCropper.h
//  Created by NapoleonBai on 14-7-24.
//  Copyright (c) 2014 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCropperDelegate;
@interface ImageCropper : UIViewController <UIScrollViewDelegate> {
    UIView *viewZoom;//缩放截图View
}
@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong) UIImageView *imageView;//显示图片View
@property (nonatomic, assign) id <ImageCropperDelegate> delegate;
- (id)initWithImage:(UIImage *)image;//初始化方法
@end
//代理
@protocol ImageCropperDelegate <NSObject>
//完成剪切的代理方法
- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image;
@end