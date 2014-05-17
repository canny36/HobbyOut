//
//  MenuView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 22/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MenuView.h"
#import "UIColor+category.h"

@implementation MenuView

- (id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.backgroundColor = [UIColor colorWithHexString:@"414141"];
//        self.backgroundColor = [UIColor colorWithHexString:@"#414141"];
        self.rowHeight = 65;
        
        self.backgroundColor = [UIColor clearColor];
		
    }
    return self;
}



@end
