//
//  SportTableViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SportTableViewController.h"
#import "SportCell.h"
@interface SportTableViewController ()

@end

@implementation SportTableViewController


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.sportArray count] == 0)
        return 1;
    
    return [self.sportArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"sport_cell";
    SportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[SportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([self.sportArray count] == 0)
    {
        [cell displaySport:[Sport allSport]];
    }
    else
    {
        Sport *sport = [self.sportArray objectAtIndex:[indexPath row]];
        
        [cell displaySport:sport];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sportArray count] == 0)
    {
        return NO;
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.sportArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

@end
