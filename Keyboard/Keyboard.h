//
//  Keyboard.h
//  ImageKeyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Keyboard : UIView


@property(strong, nonatomic) IBOutlet UIScrollView *mScrollView;
@property(strong, nonatomic) IBOutlet UIButton *btnChangeInput;
@property(strong, nonatomic) IBOutlet UIButton *btnRecent;
@property(strong, nonatomic) IBOutlet UIButton *btnAdd;
@property(strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnDefault;

@property(strong, nonatomic) IBOutlet UIButton *btnSpace;
@property(strong, nonatomic) IBOutlet UIPageControl *mPageControl;
@property(strong, nonatomic) IBOutlet UILabel *mLbRecentUsed;

@end
