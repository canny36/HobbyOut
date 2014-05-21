//
//  OptionsViewControlerViewController.m
//  HobbyOut
//
//  Created by Srinivas on 17/05/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "OptionsViewController.h"
#import "AppStyle.h"
#import "IIViewDeckController.h"
#import "InviteYourFiendViewController.h"

@interface OptionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *itemArray;
@end

@implementation OptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
    [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
         forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.title = @"OPTIONS";
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _itemArray = @[@{@"image": [UIImage imageNamed:@"options-invite-amis.png"],@"text": @"INVITE TES AMIS"},
                   @{@"image": [UIImage imageNamed:@"options-note-app.png"],
                   @"text": @"NOTE L’APPLICATION"},
                 @{@"image": [UIImage imageNamed:@"options-suis-nous.png"],@"text": @"SUIS-NOUS"},
                 @{@"image": [UIImage imageNamed:@"options-publi-facebook.png"],
                   @"text": @"PUBLICATIONS FACEBOOK"},
                @{@"image": [UIImage imageNamed:@"options-envoi-feedback.PNG"],@"text": @"ENVOIE UN FEEDBACK"},
                @{@"image": [UIImage imageNamed:@"options-deco.png"],@"text": @"DECONNEXION"}
                   ];

    [_tableView setBackgroundColor:[AppStyle backgroundColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OptionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"options-fond-rubrique.png"]];
        cell.selectedBackgroundView =   [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"options-fond-deco.png"]];
    }
	NSDictionary *info= _itemArray[indexPath.row];
	cell.textLabel.text = info[@"text"];
    [AppStyle headerText:cell.textLabel];
	cell.imageView.image = info[@"image"];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            InviteYourFiendViewController *friendController = [[InviteYourFiendViewController alloc] init];
            [self.navigationController pushViewController:friendController animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
}


@end
