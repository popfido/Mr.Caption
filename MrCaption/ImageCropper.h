//
//  ImageCropper.h
//  MrCaption
//
//  Created by Fido Wang on 9/12/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.

#import <UIKit/UIKit.h>

@protocol ImageCropperDelegate;
@interface ImageCropper : UIViewController <UIScrollViewDelegate> {
    UIView *viewZoom;//Cropping View
}
@property (nonatomic, strong) UIScrollView *scrollView;//Scrolling View
@property (nonatomic, strong) UIImageView *imageView;//Image View
@property (nonatomic, assign) id <ImageCropperDelegate> delegate;
- (id)initWithImage:(UIImage *)image;//Initialized Method
@end
// Delegate
@protocol ImageCropperDelegate <NSObject>
// Delegate Method that finish Cropping
- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image;
@end