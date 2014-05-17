//
//  TrackedViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 08/09/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TrackedViewController.h"
#import "MBProgressHUD.h"

@interface TrackedViewController ()

@end

@implementation TrackedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.screenName =  NSStringFromClass([self class]);
}

-(void)showMessage:(NSString*)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.detailsLabelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

@end
