//
//  AddSportViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 17/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AddSportViewController.h"
#import "AddSportView.h"

#import "Sport.h"
#import "AppStyle.h"

@interface AddSportViewController ()<SportServiceDelegate>
{
    NSArray *_sports;
}

@end

@implementation AddSportViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.sportService = [[SportService alloc] initWithDelegate:self];
    }
    return self;
}

- (void) loadView
{
    self.view = [[AddSportView alloc] init];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Ajouter un sport";
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 27)];
    [rightButton setImage:[UIImage imageNamed:@"cancelAddSport"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(_cancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    [self addSportView].tableView.delegate = self;
    [self addSportView].tableView.dataSource = self;
    
    [self.sportService getWithParameters:nil forView:self.view];
    
    
}

- (AddSportView *) addSportView
{
    return (AddSportView *) self.view;
}
#pragma mark Action

-(void) _cancel
{
    [self.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark SportService Delegate

-(void) sportRetrieved:(NSArray *)sports
{
    NSMutableArray *filteredArray = [NSMutableArray array];
    [filteredArray addObject:[Sport allSport]];
    
    for (Sport *sport in sports)
    {
        BOOL found = false;
        for (Sport *userSport in self.sportToFilter)
        {
            if ([userSport.name isEqualToString:sport.name])
                found = true;
        }
        
        if (!found)
            [filteredArray addObject:sport];
    }
    
    _sports = [filteredArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        NSString *first = [(Sport*)a name];
        NSString *second = [(Sport*)b name];
        
        if ([first isEqualToString:@"Tous les sports"])
            return -1;
        
        return [first compare:second];
    }];
    
    
    [[self addSportView].tableView reloadData];
}

#pragma mark UItableView Delegte & datasource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sports count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"sportCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]init];
        [AppStyle headerText:cell.textLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    Sport *sport = [_sports objectAtIndex:[indexPath row]];
    cell.textLabel.text = sport.name;
    cell.imageView.image = sport.icone;

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Sport *sport = [_sports objectAtIndex:[indexPath row]];
   
    if (self.delegate)
        [self.delegate sportSelected:sport];
    
    [self _cancel];
    
}

@end
