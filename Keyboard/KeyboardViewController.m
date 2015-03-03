//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Keyboard.h"
#import "CustomKeyView.h"
#import "MBProgressHUD.h"
#import "URBAlertView.h"
#import "ELCImagePickerHeader.h"

#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>

typedef enum KEYBOARDMODE {
    KEYBOARD_MODE_NORMAL = 0,
    KEYBOARD_MODE_RECENT
}MODE_KEYBOARD;

typedef enum KEYBOARDORIENT {
    KEYBOARD_PORTRAIT = 0,
    KEYBOARD_LANDSCAPE
}ORIENT_KEYBOARD;


#define BTN_ID 1000
#define VIEW_ID 2000

#ifdef FREE_VERSION
    #define USER_GROUP  @"group.com.rickey.smileykeyboard"
#else
    #define USER_GROUP  @"group.com.rickey.smileykeyboardpaid"
#endif


//#define MAX_PAGE 5


@interface KeyboardViewController ()<UIScrollViewDelegate, MBProgressHUDDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ELCImagePickerControllerDelegate>
{
    MBProgressHUD *HUD;

    MODE_KEYBOARD mModeKey;
    ORIENT_KEYBOARD mOrientKeyboard;
    
    
    int nMaxPage;
//    int nCurPage;
    
    NSMutableArray * arrOrgDataBase;
    NSMutableArray * arrScrollViewData;
    NSMutableArray * arrRecent;
    
    NSTimer * _timer;
    

    UIView * grayView;
    UIView * grayView2;
    UIImageView * mImgBubble;

    
}

@property (nonatomic, strong) Keyboard * keyboard;




@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifdef FREE_VERSION
    arrOrgDataBase = [[NSMutableArray alloc] initWithObjects:
                      
                      // 1 page
                      [[NSMutableArray alloc] initWithObjects:
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_1.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_2.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_3.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_4.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_5.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_6.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"LMAO_7.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"SAD_1.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"SAD_2.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"SAD_3.png", @"image_name", nil],
                       nil],


                      // 2 page
                      [[NSMutableArray alloc] initWithObjects:
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_1.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_2.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_3.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_4.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_5.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"safe_6.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_1.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_2.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_3.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_4.png", @"image_name", nil],
                       nil],
                      
                      // 3 page
                      [[NSMutableArray alloc] initWithObjects:
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_5.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_6.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_7.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_8.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_9.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_10.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_11.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_12.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_13.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_14.png", @"image_name", nil],
                       nil],
                      
                      // 4 page
                      [[NSMutableArray alloc] initWithObjects:
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_15.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_16.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_17.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_18.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_19.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_20.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_21.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_22.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_23.png", @"image_name", nil],
                       [[NSDictionary alloc] initWithObjectsAndKeys:@"smiley_24.png", @"image_name", nil],
                       nil],

                      nil];
#else
    
    arrOrgDataBase = [[NSMutableArray alloc] init];
    
#endif
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; //Get the docs directory
    NSLog(@"path = %@", documentsDirectory);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory
                                                     error:nil];
    
    //    NSLog(@"filelist = %@", fileList);
    int nCount = 0;
    NSMutableArray * pageArry = nil;
    for (NSString *filename in fileList){
        NSString *ext = [filename pathExtension];
        NSLog(@"filename = %@, ext = %@, counter = %d", filename, ext, nCount);
        if ([ext isEqualToString:@"png"]) {
            
            if (nCount % 10 == 0) {
                pageArry = [[NSMutableArray alloc] init];;
            }
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[documentsDirectory stringByAppendingPathComponent:filename], @"image_name",
                                         [NSNumber numberWithBool:YES], @"enable_option", nil];
            
            [pageArry addObject:dic];
            
            if (nCount % 10 == 9) {
                [arrOrgDataBase addObject:pageArry];
                pageArry = nil;
            }
            
            nCount ++;
        }
    }
    if (pageArry != nil) {
        [arrOrgDataBase addObject:pageArry];
    }
    
    // get REcent
    NSUserDefaults * prefs = [[NSUserDefaults alloc] initWithSuiteName:USER_GROUP];//[NSUserDefaults standardUserDefaults];
    arrRecent =  [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"recent_data"]];
    
    
    
    // Perform custom UI setup here
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"Keyboard" owner:self options:nil] objectAtIndex:0];
    self.inputView = (UIInputView*)self.keyboard;
 
    
    // implement button methods
    [self.keyboard.btnChangeInput addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnRecent addTarget:self action:@selector(onClickRecentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnDefault addTarget:self action:@selector(onClickDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnAdd addTarget:self action:@selector(onClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnSpace addTarget:self action:@selector(onClickSpaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnDelete addTarget:self action:@selector(onClickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBackBtn:)];
    [self.keyboard.btnDelete addGestureRecognizer:longPress];
    
    
    self.keyboard.mScrollView.delegate = self;
    self.keyboard.mScrollView.layer.borderColor = [UIColor grayColor].CGColor;
    self.keyboard.mScrollView.layer.borderWidth = 1;

    mModeKey = KEYBOARD_MODE_NORMAL;
    mOrientKeyboard = KEYBOARD_PORTRAIT;
    
//    nCurPage = 0;

    [self initLayoutButtons];
    
#ifndef FREE_VERSION
    
    [self addBubbleImage];
    
#endif
}


-(BOOL)isOpenAccessGranted{
    
    return YES;
/*
#ifndef FREE_VERSION
    return YES;
#else
    
#ifdef DEBUG
    return YES;
#else

    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *containerPath = [[fm containerURLForSecurityApplicationGroupIdentifier:USER_GROUP] path];
    
    NSError* err = nil;
    [fm contentsOfDirectoryAtPath:containerPath error:&err];
    
    if(err != nil){
        NSLog(@"Full Access: Off");
        return NO;
    }
    
    NSLog(@"Full Access On");
    return YES;
#endif
#endif
*/
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self isOpenAccessGranted])
    {
        [self showNotification:@"Please Allow Full Access!"];
    }
    
}


- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (arrRecent != nil) {
        NSUserDefaults * prefs = [[NSUserDefaults alloc] initWithSuiteName:USER_GROUP];
        [prefs setObject:arrRecent forKey:@"recent_data"];
        [prefs synchronize];
    }
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        mOrientKeyboard = KEYBOARD_PORTRAIT;
    }
    else {
        mOrientKeyboard = KEYBOARD_LANDSCAPE;
    }
    
//    [self initLayoutButtons];
    
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)) {
//        mOrientKeyboard = KEYBOARD_PORTRAIT;
//    }
//    else {
//        mOrientKeyboard = KEYBOARD_LANDSCAPE;
//    }
//
    [self initLayoutButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

#pragma mark ------- Interface UI ------
- (void) addBubbleImage
{
    static int count = 0;
    
    if (count >= 1 || [arrOrgDataBase count] != 0) {
        return;
    }
    count ++;
    
    
    int screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;
    
    grayView = [[UIView alloc] initWithFrame:CGRectMake(0, self.keyboard.frame.size.height-self.keyboard.btnAdd.frame.size.height,
                                                        self.keyboard.btnDefault.frame.origin.x + self.keyboard.btnDefault.frame.size.width,
                                                        self.keyboard.btnAdd.frame.size.height)];
    grayView.backgroundColor = [UIColor grayColor];
    grayView.alpha = 0.5;
    [self.keyboard addSubview:grayView];

    grayView2 = [[UIView alloc] initWithFrame:CGRectMake(self.keyboard.btnSpace.superview.frame.origin.x,
                                                         self.keyboard.frame.size.height-self.keyboard.btnAdd.frame.size.height,
//                                                         self.keyboard.btnDelete.frame.origin.x + self.keyboard.btnDelete.frame.size.width - spaceView.frame.origin.x,
                                                         screenWidth - grayView.frame.size.width - self.keyboard.btnAdd.frame.size.width,
                                                        self.keyboard.btnAdd.frame.size.height)];
    grayView2.backgroundColor = [UIColor grayColor];
    grayView2.alpha = 0.5;
    [self.keyboard addSubview:grayView2];


    int width = 277;
    int height = 49;
    CGRect rt = CGRectMake((screenWidth-width)/2, self.keyboard.btnAdd.frame.origin.y - height - 10, width, height);
    mImgBubble = [[UIImageView alloc] initWithFrame:rt];
    [mImgBubble setImage:[UIImage imageNamed:@"note.png"]];
    mImgBubble.userInteractionEnabled = YES;
    [self.keyboard addSubview:mImgBubble];
    
    UITapGestureRecognizer * tapGestureUser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNote:)];
    tapGestureUser.numberOfTapsRequired = 1;
    [mImgBubble addGestureRecognizer:tapGestureUser];

    
//    [self imageAnimation];
}

-(void)imageAnimation{

    static int count = 0;
    
    [UIView animateWithDuration:1.5 animations:^{
        mImgBubble.alpha = 1.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.5 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            mImgBubble.alpha = 0.0;
        } completion:^(BOOL finished){
            count ++;
            if (count <= 3) {
                [self imageAnimation];
            } else {
                [mImgBubble removeFromSuperview];
                [grayView removeFromSuperview];
            }
        }];
    }];
}
- (void)hideNote:(UITapGestureRecognizer* ) gesture
{
    if (mImgBubble != nil) {
        [mImgBubble removeFromSuperview];
        mImgBubble = nil;
    }
    
    if (grayView != nil) {
        [grayView removeFromSuperview];
        grayView = nil;
    }

    if (grayView2 != nil) {
        [grayView2 removeFromSuperview];
        grayView2 = nil;
    }
    
}

- (void) initLayoutButtons
{

    if (mModeKey == KEYBOARD_MODE_NORMAL) {
        self.keyboard.mLbRecentUsed.hidden = YES;
        self.keyboard.mPageControl.hidden = NO;
        arrScrollViewData = [[NSMutableArray alloc] initWithArray:arrOrgDataBase];
    }
    else {
        self.keyboard.mLbRecentUsed.hidden = NO;
        self.keyboard.mPageControl.hidden = YES;
        arrScrollViewData = [[NSMutableArray alloc] initWithArray:arrRecent];
    }
    
    nMaxPage = (int)arrScrollViewData.count;
    [self.keyboard.mPageControl setNumberOfPages:nMaxPage];

    
    for (UIView *v in self.keyboard.mScrollView.subviews) {
        if ([v isKindOfClass:[UIView class]]) {
            [v removeFromSuperview];
        }
        
        if ([v isKindOfClass:[UILabel class]]) {
            [v removeFromSuperview];
        }
    }
    
    int screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;
//    int pageWidth =  self.keyboard.mScrollView.bounds.size.width;
    int pageHeight = self.keyboard.mScrollView.bounds.size.height;
    
    [self.keyboard.mScrollView setContentSize:CGSizeMake(nMaxPage * screenWidth, pageHeight)];
    
    if (mModeKey == KEYBOARD_MODE_RECENT) {
        if (nMaxPage == 0) {
            UILabel * lbNote = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
            lbNote.numberOfLines = 5;
            lbNote.text = @"This section will automatically collect your most recent and frequently used icons.";
            lbNote.textAlignment = NSTextAlignmentCenter;
            lbNote.font = [UIFont systemFontOfSize:12.0f];
            [lbNote sizeToFit];
            lbNote.center = CGPointMake(screenWidth/2, pageHeight/2);

            [self.keyboard.mScrollView addSubview:lbNote];
        }
    }
    
/*
    int offset = 1;
    
    for (int i = 0 ; i < nMaxPage; i ++) {
        UIView * keysView = [[UIView alloc] initWithFrame:CGRectMake(0 + i * screenWidth, 0, screenWidth, pageHeight)];
        
        int btnWidth = (keysView.frame.size.width - offset*(nMaxPage+1)) / 5;
        int btnHeight = (keysView.frame.size.height - offset*3) / 2;
        
        int posx = 0;
        int posy = 0;
        for (int j = 0; j < 10; j ++) {
            
            posx = offset * j + btnWidth * j;
            if (j >= 5) {
                posx = offset * (j-5) + btnWidth * (j-5);
                posy = offset * 2 + btnHeight;
            }
            
            CustomKeyView * btnKey = [[CustomKeyView alloc] initWithFrame:CGRectMake(posx, posy, btnWidth, btnHeight)];
            btnKey.tag = BTN_ID + i * 10 + j;
//            [btnKey addTarget:self action:@selector(onClickKeyBtn:) forControlEvents:UIControlEventTouchUpInside];

            NSDictionary * dic = arrOrgDataBase[i][j];

            UIImage * image = [UIImage imageNamed:dic[@"image_name"]];
            NSString * title = dic[@"title"];
            
            if (image != nil) {
                [btnKey setCustomKeyViewWithImage:image text:title];
                
                UITapGestureRecognizer * tapGestureUser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickKeyBtn:)];
                tapGestureUser.numberOfTapsRequired = 1;
                [btnKey addGestureRecognizer:tapGestureUser];

            }
            
            [keysView addSubview:btnKey];
            
        }
        
        [self.keyboard.mScrollView addSubview:keysView];
    }
*/
    
    [self loadVisiblePages];
}

- (void) loadPage:(int) page
{
    
    if (page < 0 || page >= nMaxPage) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView * keysView = [self.keyboard.mScrollView viewWithTag:VIEW_ID + page];
    if (keysView == nil) {

        int pageWidth = [[UIScreen mainScreen] applicationFrame].size.width;
        int pageHeight = self.keyboard.mScrollView.bounds.size.height;
        
//        NSLog(@"width = %d, height = %d", pageWidth, pageHeight);
        
        
        UIView * keysView = [[UIView alloc] initWithFrame:CGRectMake(page * pageWidth, 0, pageWidth, pageHeight)];
        keysView.tag = VIEW_ID + page;
        
        int row = mOrientKeyboard == KEYBOARD_PORTRAIT ? 5 : 10;
        int col = mOrientKeyboard == KEYBOARD_PORTRAIT ? 2 : 1;
        
        int btnWidth = keysView.frame.size.width / row;
        int btnHeight = keysView.frame.size.height / col;
        
        int posx = 0;
        int posy = 0;
        
        NSArray * arrKeys = arrScrollViewData[page];
        int numOfKey = (int)arrKeys.count;
        
        for (int j = 0; j < numOfKey; j ++) {
            
            posx = btnWidth * j;
            if (j >= row) {
                posx = btnWidth * (j-row);
                posy = btnHeight;
            }
            
            CustomKeyView * btnKey = nil;
            if (j < row) {
                btnKey = [[CustomKeyView alloc] initWithFrame:CGRectMake(posx, posy, btnWidth, btnHeight) direct:YES];
            } else {
                btnKey = [[CustomKeyView alloc] initWithFrame:CGRectMake(posx, posy, btnWidth, btnHeight) direct:NO];
            }
            btnKey.tag = BTN_ID + page * 10 + j;
            
            NSDictionary * dic = arrScrollViewData[page][j];
            
            UIImage * image = [UIImage imageNamed:dic[@"image_name"]];
            if (image == nil) {
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"image_name"]]];
                image = [UIImage imageWithData:data];
            }
            
            if (image != nil) {
                [btnKey setCustomKeyViewWithImage:image];
                
                UITapGestureRecognizer * tapGestureUser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickKeyBtn:)];
                tapGestureUser.numberOfTapsRequired = 1;
                [btnKey addGestureRecognizer:tapGestureUser];
                
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressKeyBtn:)];
                [btnKey addGestureRecognizer:longPress];
            }
            
            [keysView addSubview:btnKey];
            
        }
        
        [self.keyboard.mScrollView addSubview:keysView];

    }
    
}

- (void) purgePage:(int) page
{
    
    if (page < 0 || page >= nMaxPage) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView * subView = [self.keyboard.mScrollView viewWithTag:VIEW_ID + page];
    [subView removeFromSuperview];
}

- (void) loadVisiblePages
{
    int pageWidth = [[UIScreen mainScreen] applicationFrame].size.width;
    int page = (self.keyboard.mScrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0);
    
    // Update the page control
    self.keyboard.mPageControl.currentPage = page;
    
    // Work out which pages you want to load
    int firstPage = page - 1;
    int lastPage = page + 1;
    
    
    // Purge anything before the first page
    for (int index = 0; index < firstPage; index ++) {
        [self purgePage:index];
    }
    
    // Load pages in our range
    for (int index = firstPage; index <= nMaxPage; index ++) {
        [self loadPage:index];
    }
    
    // Purge anything after the last page
    for (int index = lastPage + 1; index < nMaxPage; index ++) {
        [self purgePage:index];
    }

}

#pragma mark ------ UIScrollView Delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat pageWidth = [[UIScreen mainScreen] applicationFrame].size.width; //scrollView.frame.size.width;
//    nCurPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    self.keyboard.mPageControl.currentPage = nCurPage;
    
    // Load the pages that are now on screen
    [self loadVisiblePages];
}


#pragma mark ---- Button Event
- (void)onClickKeyBtn:(UITapGestureRecognizer* ) gesture
{
    CustomKeyView * view = (CustomKeyView*)gesture.view;
    int tag = (int)view.tag;
    
    int page = (tag - BTN_ID) / 10;
    int index = (tag - BTN_ID) % 10;
    
    NSLog(@"page = %d, index = %d", page, index);
    
    NSDictionary* dic = arrScrollViewData[page][index];
    UIImage * newImage = [UIImage imageNamed:dic[@"image_name"]];
    
    
    if (newImage == nil) {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"image_name"]]];
        newImage = [UIImage imageWithData:data];
    }
    
    
    if (newImage != nil) {
        UIPasteboard *pasteBoard = [UIPasteboard pasteboardWithName:UIPasteboardNameGeneral create:NO];
        pasteBoard.persistent = YES;
        NSData *data = UIImagePNGRepresentation(newImage);
        [pasteBoard setData:data forPasteboardType:@"public.png"];
        
        

        [self showMessage:@"Now paste in a message"];
        
        
        /*
         *  Add recent
         */
        
        if (arrRecent == nil) {
            arrRecent = [[NSMutableArray alloc] init];
        }
        
        for (int i = 0; i < (int)arrRecent.count; i ++) {
            NSArray * arr = arrRecent[i];
            if ([arr containsObject:dic]) {
                return;
            }
        }
        
        
        BOOL bNewPage = NO;
        int pageSize = (int)arrRecent.count;
        NSMutableArray * pageArry = nil;
        if (pageSize == 0) {
            pageArry = [[NSMutableArray alloc] init];
            bNewPage = YES;
        } else {
            pageArry = [[NSMutableArray alloc] initWithArray:arrRecent[pageSize - 1]];
            int size = (int)pageArry.count;
            if (size == 10) {
//                pageArry = [[NSMutableArray alloc] init];
//                bNewPage = YES;
                [pageArry removeObjectAtIndex:0];
            }
        }
        
        [pageArry addObject:dic];
        
        if (bNewPage) {
            [arrRecent addObject:pageArry];
        } else {
            [arrRecent replaceObjectAtIndex:pageSize-1 withObject:pageArry];
        }
        
    }
}

- (void)longPressKeyBtn:(UILongPressGestureRecognizer*)gesture {
    
    if (mModeKey == KEYBOARD_MODE_RECENT) {
        return;
    }
    
    
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        
    }
    else if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CustomKeyView * view = (CustomKeyView*)gesture.view;
        int tag = (int)view.tag;
        
        int page = (tag - BTN_ID) / 10;
        int index = (tag - BTN_ID) % 10;
        
        NSLog(@"page = %d, index = %d", page, index);
        
        NSDictionary* dic = arrOrgDataBase[page][index];
        NSNumber * enableOpt = dic[@"enable_option"];
        if (enableOpt != nil && [enableOpt boolValue] == YES) { // custom image
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:@"NOTE!"
                                                                   parent:self.keyboard
                                                                  message:@"Do you want to delete this smiley?"
                                                        cancelButtonTitle:@"YES"
                                                        otherButtonTitles: @"NO", nil];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{

                    if (buttonIndex == 0) {
                        NSMutableArray * arrPage = [[NSMutableArray alloc] initWithArray:arrOrgDataBase[page]];
                        [arrPage removeObject:dic];

                        // image file delete in app
                        NSFileManager *manager = [NSFileManager defaultManager];
                        NSError *error;
                        [manager removeItemAtPath:dic[@"image_name"] error:&error];
                        if (error){
                            NSLog(@"%@", error);
                        }
                        
                        [arrOrgDataBase replaceObjectAtIndex:page withObject:arrPage];
                        
                        [self sortkeys];
                        
                        [self initLayoutButtons];
                    }
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationSlideLeft];
        }
        else {
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:@"NOTE!"
                                                                   parent:self.keyboard
                                                                  message:@"Sorry, you can not remove this smiley."
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil, nil];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    // stub
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationFlipVertical];
        }
    }
    
    [self.textDocumentProxy deleteBackward];
}

-(void) sortkeys
{
    NSMutableArray * arrTemp = [[NSMutableArray alloc] init];
    NSMutableArray * arrOne = nil;
    
    
    int count = 0;
    for (NSArray * arrOnePage in arrOrgDataBase) {
        for (NSDictionary * oneDic in arrOnePage) {
            
            if (count == 10) {
                [arrTemp addObject:arrOne];
                arrOne = nil;
                count = 0;
            }
            
            if (arrOne == nil) {
                arrOne = [[NSMutableArray alloc] init];
            }
            
            [arrOne addObject:oneDic];
            count ++;
        }
    }
    
    if (arrOne.count != 0) {
        [arrTemp addObject:arrOne];
    }
    
    arrOrgDataBase = [[NSMutableArray alloc] initWithArray:arrTemp];
}


- (void)onClickRecentBtn:(UIButton *) sender
{
    if (mModeKey == KEYBOARD_MODE_NORMAL) {
        mModeKey = KEYBOARD_MODE_RECENT;
        [self initLayoutButtons];
    }
    
}
- (void)onClickDefaultBtn:(UIButton *) sender
{
    if (mModeKey == KEYBOARD_MODE_RECENT) {
        mModeKey = KEYBOARD_MODE_NORMAL;
        [self initLayoutButtons];
    }
}
- (void)onClickAddBtn:(UIButton *) sender
{
    
    [self hideNote:nil];
    
    
    int maxlimit = 5;
#ifdef FREE_VERSION
    maxlimit = 5;
#else
    maxlimit = 10;
#endif

    int pageSize = (int)arrOrgDataBase.count;
    if (pageSize >= maxlimit) {
        NSMutableArray* pageArry = arrOrgDataBase[maxlimit-1];
        if (pageArry != nil) {
            int size = (int)pageArry.count;
            if (size == 10 || pageSize > maxlimit) {
                [self showMessage:@"You've reached your upload limit."];
                return;
            }
        }
    }
    
    
#ifdef FREE_VERSION
//    [self oneImageController];
    [self onClickCameraRoll:nil];
#else
    [self moreImageController];
#endif
    
//    URBAlertView *multiAlertView = [[URBAlertView alloc] initWithTitle:@"Select Option"
//                                                                parent:self.keyboard
//                                                               message:@"" cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Camera Roll", @"Take Photo", nil];
//    [multiAlertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
//
//        if (buttonIndex == 0) {
//            [self onClickCameraRoll:nil];
//        }
//        else if (buttonIndex == 1) {
//            [self onClickTakePhoto:nil];
//        }
//        
//        [alertView hide];
//    }];
//    [multiAlertView show:self.keyboard];
}

- (void)onClickSpaceBtn:(UIButton *) sender
{
    [self.textDocumentProxy insertText:@" "];
}

- (void)onClickDeleteBtn:(UIButton *) sender
{
    [self.textDocumentProxy deleteBackward];
}
- (void)longPressBackBtn:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        [self stopTimer];
    }
    else if (gesture.state == UIGestureRecognizerStateBegan) {
        [self startTimer];
    }
}

- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                  target:self
                                                selector:@selector(_timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)stopTimer {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)_timerFired:(NSTimer *)timer {
    [self onClickDeleteBtn:nil];
}






#pragma mark - Image upload

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self onClickCameraRoll:nil];
    }
    else if (buttonIndex == 1) {
        [self onClickTakePhoto:nil];
    }
}

-(IBAction) onClickCameraRoll:(id)sender
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    [imagePicker setAllowsEditing:YES];
    
    [self performSelector:@selector(presentCameraView:) withObject:imagePicker afterDelay:1.0f];

//    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)presentCameraView:(UIImagePickerController*) imagePicker{
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

-(IBAction) onClickTakePhoto:(id)sender
{
    if( ![UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront ]) {
        [self showMessage:@"You cannot take photo from camera"];
        return;
    }
    
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [imagePicker setAllowsEditing:YES];
    [self performSelector:@selector(presentCameraView:) withObject:imagePicker afterDelay:1.0f];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Show camera view controller.
//        [self presentViewController:imagePicker animated:YES completion:nil];
        [self presentCameraView:imagePicker];
    });
    
    [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:^{
        
    }];

}

#define IMAGE_SIZE         640

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

    int width = image.size.width;
    int height = image.size.height;
    int minValue = MIN(width, height);
    int maxValue = MAX(width, height);
    if (maxValue > IMAGE_SIZE) {
        float newWidth = minValue > IMAGE_SIZE ? IMAGE_SIZE : minValue;
        float newHeight = height * newWidth/width;
        
        CGSize size = CGSizeMake(newWidth, newHeight);
        
        image = [self imageResize:image andResizeTo:size];
    }

    
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate *now = [NSDate date];
    NSString *timeString = [format stringFromDate:now];
    NSString *filename = [NSString stringWithFormat:@"%@.png", timeString];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filename]; //Add the file name
    [pngData writeToFile:filePath atomically:YES];
    
    
    // add
    
    BOOL bNewPage = NO;
    int pageSize = (int)arrOrgDataBase.count;
    NSMutableArray * pageArry = nil;
    if (pageSize == 0) {
        pageArry = [[NSMutableArray alloc] init];
        bNewPage = YES;
    } else {
        pageArry = arrOrgDataBase[pageSize - 1];
        int size = (int)pageArry.count;
        if (size == 10) {
#ifdef FREE_VERSION
            if (pageSize == 5)
#else
            if (pageSize == 10)
#endif
            {
                [pageArry removeObjectAtIndex:0];
            }
            else {
                pageArry = [[NSMutableArray alloc] init];
                bNewPage = YES;
            }
        }
    }
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:filePath, @"image_name",
                                 [NSNumber numberWithBool:YES], @"enable_option", nil];
    [pageArry addObject:dic];
    
    if (bNewPage) {
        [arrOrgDataBase addObject:pageArry];
    } else {
        [arrOrgDataBase replaceObjectAtIndex:pageSize-1 withObject:pageArry];
    }

    if (mModeKey == KEYBOARD_MODE_NORMAL) {
        [self initLayoutButtons];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self showMessage:@"saved successfully"];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    UIGraphicsBeginImageContext(newSize);
    //UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark -
#pragma mark Multi image selection

- (void)moreImageController
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 5; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (void)oneImageController
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    NSMutableArray *groups = [NSMutableArray array];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groups addObject:group];
        } else {
            // this is the end
            [self displayPickerForGroup:[groups objectAtIndex:0]];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"A problem occured %@", [error description]);
        // an error here means that the asset groups were inaccessable.
        // Maybe the user or system preferences refused access.
    }];
}

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                int width = image.size.width;
                int height = image.size.height;
                int minValue = MIN(width, height);
                int maxValue = MAX(width, height);
                
                NSLog(@"origin: width = %f, height = %f", image.size.width, image.size.height);

                
                if (maxValue > IMAGE_SIZE) {
                    float newWidth = minValue > IMAGE_SIZE ? IMAGE_SIZE : minValue;
                    float newHeight = height * newWidth/width;
                    
                    CGSize size = CGSizeMake(newWidth, newHeight);
                    
                    image = [self imageResize:image andResizeTo:size];
                }
                NSLog(@"change: width = %f, height = %f", image.size.width, image.size.height);
                
                NSData *pngData = UIImagePNGRepresentation(image);
                
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yyyyMMddHHmmssSSS"];
                NSDate *now = [NSDate date];
                NSString *timeString = [format stringFromDate:now];
                NSString *filename = [NSString stringWithFormat:@"%@.png", timeString];

                NSString *filePath = [documentsPath stringByAppendingPathComponent:filename]; //Add the file name
                [pngData writeToFile:filePath atomically:YES];
                
                
                // add
                
                BOOL bNewPage = NO;
                int pageSize = (int)arrOrgDataBase.count;
                NSMutableArray * pageArry = nil;
                if (pageSize == 0) {
                    pageArry = [[NSMutableArray alloc] init];
                    bNewPage = YES;
                } else {
                    pageArry = arrOrgDataBase[pageSize - 1];
                    int size = (int)pageArry.count;
                    if (size == 10) {
#ifdef FREE_VERSION
                        if (pageSize == 5)
#else
                            if (pageSize == 10)
#endif
                            {
                                [pageArry removeObjectAtIndex:0];
                            }
                            else {
                                pageArry = [[NSMutableArray alloc] init];
                                bNewPage = YES;
                            }
                    }
                }
                
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:filePath, @"image_name",
                                             [NSNumber numberWithBool:YES], @"enable_option", nil];
                [pageArry addObject:dic];
                
                if (bNewPage) {
                    [arrOrgDataBase addObject:pageArry];
                } else {
                    [arrOrgDataBase replaceObjectAtIndex:pageSize-1 withObject:pageArry];
                }
                
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    if (mModeKey == KEYBOARD_MODE_NORMAL) {
        [self initLayoutButtons];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self showMessage:@"saved successfully"];
    }];
    /////////////////////
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- message 
- (void) showNotification:(NSString*) label {
    
    if (HUD == nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        [HUD show:YES];
    }
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = label;
}

- (void) showMessage:(NSString*) label {
    
    if (HUD == nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.delegate = self;
        
        [HUD show:YES];
    }
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = label;
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
}

-(void) myTask {
    sleep(2);
}

- (void) hideLoading
{
    [HUD hide:YES];
}
#pragma mark - MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}


@end
