//
//  TutorialViewController.m
//  Expresser Smiley Keyboard
//
//  Created by iGold on 10/13/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()


@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *mImageView;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
//                                                                      attribute:NSLayoutAttributeLeading
//                                                                      relatedBy:0
//                                                                         toItem:self.view
//                                                                      attribute:NSLayoutAttributeLeft
//                                                                     multiplier:1.0
//                                                                       constant:0];
//    [self.view addConstraint:leftConstraint];
//    
//    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
//                                                                       attribute:NSLayoutAttributeTrailing
//                                                                       relatedBy:0
//                                                                          toItem:self.view
//                                                                       attribute:NSLayoutAttributeRight
//                                                                      multiplier:1.0
//                                                                        constant:0];
//    [self.view addConstraint:rightConstraint];
    
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:self.mImageView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1  constant:self.view.frame.size.width];
    [self.mImageView addConstraints:@[con1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
