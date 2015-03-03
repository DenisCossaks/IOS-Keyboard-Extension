//
//  ViewController.m
//  ImageKeyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import "ViewController.h"
#import "GADInterstitial.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MFMailComposeViewController.h>//mail controller

#define ADMOB_ID    @"ca-app-pub-4311000974756091/6138209368"



@interface ViewController ()<GADInterstitialDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    
    IBOutlet UITableView *mTableView;
    
    MPMoviePlayerController * moviePlayer;
}

@end

@implementation ViewController{
    GADInterstitial * bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#ifdef FREE_VERSION
//    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-GAD_SIZE_320x50.width)/2, self.view.frame.size.height-GAD_SIZE_320x50.height,
//                                                                 GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    bannerView =  [[GADInterstitial alloc] init];
    bannerView.delegate = self;

    bannerView.adUnitID = ADMOB_ID;
    
    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           nil];
    [bannerView loadRequest:request];
    
    [bannerView presentFromRootViewController:self];
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidLayoutSubviews
//{
//    [self.view bringSubviewToFront:bannerView];
//}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    // Alert the error.
    UIAlertView *alert = [[UIAlertView alloc]
                           initWithTitle:@"GADRequestError"
                           message:[error localizedDescription]
                           delegate:nil cancelButtonTitle:@"Drat"
                           otherButtonTitles:nil] ;
    [alert show];
}

-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    NSLog(@"on screen");
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];
}


#pragma mark
#pragma -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString * text = @"";
    if (indexPath.row == 0) {
        text = @"Help Tutorial (Video)";
    } else if (indexPath.row == 1) {
        text = @"Quick Setup";
    } else if (indexPath.row == 2) {
        text = @"Feedback";
    } else {
        text = @"Privacy Policy";
    }
    
    cell.textLabel.text = text;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self playVideo];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"gotoTutorial" sender:self];        
    }
    else if (indexPath.row == 2) {
        [self onReportEmail];
    }
    else {
        [self onPrivacy];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (IBAction)onClickInstruction:(id)sender {
    
}

-(void) playVideo
{
    NSString * fileName = @"long_version_extended";
    
    moviePlayer= [[MPMoviePlayerController alloc] initWithContentURL:
                  [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:fileName ofType:@"mov"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStarted:) name:MPMoviePlayerWillEnterFullscreenNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished:) name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDonePressed:) name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    
    moviePlayer.controlStyle=MPMovieControlStyleDefault;
    //    moviePlayer.shouldAutoplay=NO;
    [moviePlayer play];
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

-(void)videoStarted:(NSNotification *)notification{
    
    
    // Entered Fullscreen code goes here..
//    GHAppDelegate *appDelegate = APPDELEGATE;
//    appDelegate.fullScreenVideoIsPlaying = YES;
    
}
-(void)videoFinished:(NSNotification *)notification{
    
    // Left fullscreen code goes here...
//    GHAppDelegate *appDelegate = APPDELEGATE;
//    appDelegate.fullScreenVideoIsPlaying = NO;
    
    //CODE BELOW FORCES APP BACK TO PORTRAIT ORIENTATION ONCE YOU LEAVE VIDEO.
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    //present/dismiss viewcontroller in order to activate rotating.
    UIViewController *mVC = [[UIViewController alloc] init];
    [self presentViewController:mVC animated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) moviePlayBackDonePressed:(NSNotification*)notification
{

    [moviePlayer stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
    moviePlayer=nil;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    [moviePlayer stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer setFullscreen:NO animated:YES];
        [moviePlayer.view removeFromSuperview];
    }
}



-(void) onReportEmail
{
    
    NSString *subject = @"Feedback";
    
    if(![MFMailComposeViewController canSendMail]){
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please configure your mail settings to send email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    MFMailComposeViewController* mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:subject];
    [mc setToRecipients:@[@"admin@expresserapp.com"]];

    [self presentViewController:mc animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    switch (result) {
        case MFMailComposeResultSent:
            
            [[[UIAlertView alloc] initWithTitle:nil message:@"Email sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) onPrivacy
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://expresserapp.com/e/privacy.html"]];
}

@end
