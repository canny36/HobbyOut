//
//  UIView+ShowHide.m
//  HobbyOut
//
//  Created by Srinivas on 16/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "UIView+ShowHide.h"

@implementation UIView (ShowHide)

-(void)hide:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
            self.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        }];
    }else{
        self.hidden = YES;
    }

}

-(void)show:(BOOL)animated{
    if (animated) {
        self.alpha = 0;
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
    }else{
        self.hidden = NO;
    }
}

@end
