//
//  CustomKeyView.h
//  ImageKeyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyView : UIView

@property (nonatomic, assign) UIImage * image;

@property (nonatomic, strong) UIImageView * mImageView;

- (id) initWithFrame:(CGRect)frame direct:(BOOL) bUp;
- (void) setCustomKeyViewWithImage:(UIImage*) image;

@end
