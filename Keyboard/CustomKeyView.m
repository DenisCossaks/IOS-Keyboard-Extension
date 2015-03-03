//
//  CustomKeyView.m
//  ImageKeyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import "CustomKeyView.h"

@implementation CustomKeyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame direct:(BOOL) bUp
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UIView * backView = [[UIView alloc] init]; //initWithFrame:CGRectMake(1, 1, frame.size.width-1, frame.size.height-2)];
        if (bUp) {
            backView.frame = CGRectMake(0, 1, frame.size.width-1, frame.size.height-2);
        } else {
            backView.frame = CGRectMake(0, 0, frame.size.width-1, frame.size.height-1);
        }
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        // image
        CGRect fr = CGRectMake(2, 2, frame.size.width - 4, frame.size.height - 4);
        self.mImageView = [[UIImageView alloc] initWithFrame:fr];
        self.mImageView.userInteractionEnabled = YES;
        [self addSubview:self.mImageView];
        
        
    }
    return self;
}

- (void) setCustomKeyViewWithImage:(UIImage*) image
{
    [self.mImageView setImage:image];
}

@end
