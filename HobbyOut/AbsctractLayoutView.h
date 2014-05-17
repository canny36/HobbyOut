//
//  EasyLayoutView.h
//  SmartLayout
//
//  Created by Frédéric DE MATOS on 30/01/13.
//  Copyright (c) 2013 Smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBackgroundImageView.h"

@interface AbsctractLayoutView : UIBackgroundImageView

enum Layout {horizontal, vertical};
enum HorizontalAlign {left, right, center};
enum VerticalAlign {top, bottom, middle};

@property (nonatomic) enum Layout layout;
@property (nonatomic) enum HorizontalAlign hAlign;
@property (nonatomic) enum VerticalAlign vAlign;
@property (nonatomic) int gap;
@property (nonatomic) int padding;

-(void) defaultInit;

-(void) layoutSubview:(UIView *)view;
-(void) layoutSubview:(UIView *)view withSize:(CGSize )size;
-(void) updateSubViewsPosition;

-(NSInteger) getFreeWidth;
-(NSInteger) getFreeHeight;



@end
