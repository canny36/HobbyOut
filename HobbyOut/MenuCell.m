//
//  GHSidebarMenuCell.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "MenuCell.h"
#import "AppStyle.h"


#pragma mark -
#pragma mark Constants
NSString const *kSidebarCellTextKey = @"CellText";
NSString const *kSidebarCellImageKey = @"CellImage";

#pragma mark -
#pragma mark Implementation
@implementation MenuCell

#pragma mark Memory Management
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.clipsToBounds = YES;
//		self.selectionStyle = UITableViewCellSelectionStyleGray;
        
//        UIView *bgColorView = [[UIView alloc] init];
//        [bgColorView setBackgroundColor:[UIColor clearColor]];
//        [self setSelectedBackgroundView:bgColorView];
//		
		self.imageView.contentMode = UIViewContentModeCenter;
		
        [AppStyle menuItemLabel:self.textLabel];
        self.textLabel.highlightedTextColor = [UIColor orangeColor];
				
		UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuSeparatorLine.png"]];
        bottomLine.frame = CGRectMake(10, 63, 240, 2);
		[self addSubview:bottomLine];
	}
	return self;
}

#pragma mark UIView
- (void)layoutSubviews {
	[super layoutSubviews];
	self.textLabel.frame = CGRectMake(50, 0, 200, 65);
	self.imageView.frame = CGRectMake(0, 0, 50, 65);
}

@end
