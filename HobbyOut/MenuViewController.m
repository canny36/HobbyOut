//
//  MenuViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 22/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"

#import "MenuCell.h"
#import "UIVView.h"

#import "AppStyle.h"

#import "IIViewDeckController.h"

#import "TvViewController.h"
#import "EventListViewController.h"
#import "MemberViewController.h"
#import "FeedViewController.h"

#import "UserDefaultManager.h"
#import "PleaseRegisterViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_headers;
    NSArray *_items;
}

@end

@implementation MenuViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        _headers = @[@"MENU"];
        _items = @[@[@{@"image": [UIImage imageNamed:@"tv.png"],
                       @"imageSelected": [UIImage imageNamed:@"tv_selected.png"],
                       @"text": @"AGENDA TV"},
                     
                      @{@"image": [UIImage imageNamed:@"feed.png"],
                         @"imageSelected": [UIImage imageNamed:@"feed_selected.png"],
                        @"text": @"ACTUALITES"},
                      
                      @{@"image": [UIImage imageNamed:@"event.png"],
                        @"imageSelected": [UIImage imageNamed:@"event_selected.png"],
                        @"text": @"EVENEMENTS"},
                     
                      @{@"image": [UIImage imageNamed:@"user_profile.png"],
                         @"imageSelected": [UIImage imageNamed:@"user_profile_selected.png"],
                        @"text": @"PROFIL"}]];
        
        
    }
    return self;
}

-(void) loadView
{
    self.view = [[MenuView alloc] init];
    [self menuView].delegate = self;
    [self menuView].dataSource = self;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [[self menuView] selectRowAtIndexPath:indexPath
                           animated:NO
                     scrollPosition:UITableViewScrollPositionTop];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_items[section]).count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GHMenuCell";
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
	NSDictionary *info= _items[indexPath.section][indexPath.row];
	cell.textLabel.text = info[@"text"];
	cell.imageView.image = info[@"image"];
    cell.imageView.highlightedImage = info[@"imageSelected"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSObject *headerText = _headers[section];
	UIVView *headerView = nil;
    
	if (headerText != [NSNull null])
    {
		headerView = [[UIVView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 50)];
        [headerView setBackgroundImage:@"menuHeaderBackground.png"];
        headerView.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 25)];
        [AppStyle menuTitleLabel:textLabel];
		textLabel.text = (NSString *) headerText;
		[headerView layoutSubview:textLabel];
    }
	return headerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller)
    {
        UIViewController *newViewController;
        
        switch (indexPath.row) {
            case 0:
                newViewController = [[TvViewController alloc]init];
                break;
            
            case 1:
                if ([UserDefaultManager getSessionToken])
                    newViewController = [[FeedViewController alloc]init];
                else
                    newViewController = [[PleaseRegisterViewController alloc] init];
                break;
                
            case 2:
                newViewController = [[EventListViewController alloc]init];
                break;
                
            case 3:
                if ([UserDefaultManager getSessionToken])
                    newViewController = [[MemberViewController alloc]init];
                else
                    newViewController = [[PleaseRegisterViewController alloc] init];
                break;
                
            default:
                newViewController = [[TvViewController alloc]init];
                break;
        }
        
        [((UINavigationController *)controller.centerController) setViewControllers:[NSArray arrayWithObject:newViewController]  animated:NO];
    }];
}

-(MenuView *) menuView
{
    return (MenuView *) self.view;
}


@end
