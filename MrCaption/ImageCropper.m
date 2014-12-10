//
//  ImageCropper.m
//  MrCaption
//
//  Created by Fido Wang on 9/12/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.
//

#import "ImageCropper.h"

@implementation ImageCropper

- (id)initWithImage:(UIImage *)image {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self = [super init];
    if (self) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        // Initialize UIScrollView - Size Can be Self Determined
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight)];
        [_scrollView setBackgroundColor:[UIColor blackColor]];
        [_scrollView setDelegate:self];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setMaximumZoomScale:2.0];
        // Initialize imageView
        _imageView = [[UIImageView alloc] initWithImage:image];
        
        // Set Image Size
        CGRect rect;
        rect.size.width = image.size.width;
        rect.size.height = image.size.height;
        [_imageView setFrame:rect];
        // Set UIScrollView Content Size
        [_scrollView setContentSize:[_imageView frame].size];
        // Set Minimum Zoom Scale
        [_scrollView setMinimumZoomScale:[_scrollView frame].size.width / [_imageView frame].size.width];
        // Set Initial Zoom Scale
        [_scrollView setZoomScale:[_scrollView minimumZoomScale]];
        // Add Image View to UIScrollView
        [_scrollView addSubview:_imageView];
        
        [[self view] addSubview:_scrollView];
        
        // Set NAvigation Bar
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
        // Set Navigation Item
        UINavigationItem *aNavigationItem = [[UINavigationItem alloc] initWithTitle:@"Zoom/Cut"];
        // Set Cancel Button
        [aNavigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCropping)]];
        // Set Done Button
        [aNavigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishCropping)]];
        // Add Button to Navigation Bar
        [navigationBar setItems:[NSArray arrayWithObject:aNavigationItem]];
        // Set Navigation Bar
        [[self view] addSubview:navigationBar];
        // Initialize Cutting Rectangle
        [self initView];
    }
    
    return self;
}

//Build Cutting View
- (void)initView{
    // Initialize
    viewZoom=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 315, 241)];
    //Remove Background Color
    [viewZoom setBackgroundColor:[UIColor clearColor]];
    //Set Border Color
    viewZoom.layer.borderColor=[[UIColor whiteColor]CGColor];
    //Set Border Width
    viewZoom.layer.borderWidth=2;
    //Set Border CornerRadius
    viewZoom.layer.cornerRadius=2;
    //Add View to ScrollView
    [[self scrollView] addSubview:viewZoom];
    // Open Interaction Gesture
    [viewZoom setUserInteractionEnabled:YES];
    // Set Pan Gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    // Add Pan Gesture
    [viewZoom addGestureRecognizer:panGestureRecognizer];
}

// Pan Handling
- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    // Get translation Poing
    CGPoint translation = [recognizer translationInView:self.view];
    // Set View Center Position
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    // Reset View Position
    [recognizer setTranslation:CGPointZero inView:self.view];
}

#pragma 实现滚动视图的协议方法
//进行缩放时进入，返回图片View
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollViews {
    return _imageView;
}
//Scrolling Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollViews{
    // Get Cutting View frame
    CGRect frame=viewZoom.frame;
    //Lock Cutting View to Screen（x=10,y=10) 可以根据自己需要自行设定
    frame.origin.x=[self.scrollView contentOffset].x+10;
    frame.origin.y=[self.scrollView contentOffset].y+10;
    [viewZoom setFrame:frame];
}

// Cancel Cropping Method
- (void)cancelCropping {
    [self dismissViewControllerAnimated:NO completion:nil];
}

// Cropping Method
- (void)finishCropping {
    // Get Zoom Scale
    float zoomScale = 1.0 / [_scrollView zoomScale];
    // Get Cropping Rectangle Size
    CGRect rect;
    rect.origin.x = viewZoom.frame.origin.x * zoomScale;
    rect.origin.y = viewZoom.frame.origin.y * zoomScale;
    rect.size.width = viewZoom.frame.size.width * zoomScale;
    rect.size.height = viewZoom.frame.size.height * zoomScale;
    //Cropping - Image Position
    CGImageRef cr = CGImageCreateWithImageInRect([[_imageView image] CGImage], rect);
    //Get image
    UIImage *cropped = [UIImage imageWithCGImage:cr];
    //Release 这里可以不做出操作，但是为了内存的严谨，推荐释放
    CGImageRelease(cr);
    // Use Delegate to Deliver Cropped Image
    [self.delegate imageCropper:self didFinishCroppingWithImage:cropped];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

