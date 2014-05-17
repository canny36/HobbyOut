//
//  ParticipantPopUpViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "ParticipantPopUpViewController.h"
#import "ParticipantPopUpView.h"

#import "ParticipantCollectionCell.h"
#import "MemberViewController.h"

@interface ParticipantPopUpViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ParticipantPopUpViewController

- (void) loadView
{
    self.view = [[ParticipantPopUpView alloc] init];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self participantPopUpView].collectionView.delegate = self;
    [self participantPopUpView].collectionView.dataSource = self;
}

-(void) setView:(UIView *)view
{
    [super setView:view];
    [self participantPopUpView].collectionView.delegate = self;
    [self participantPopUpView].collectionView.dataSource = self;

}


-(ParticipantPopUpView *) participantPopUpView
{
    return (ParticipantPopUpView *) self.view;
}

- (void) refresh
{
    [[self participantPopUpView].collectionView reloadData];
}

#pragma mark UICollectionView Delagate Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.participants count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    
    ParticipantCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ParticipantCell" forIndexPath:indexPath];
    
    [cell displayParticipant:[self.participants objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Participant *participant = [self.participants objectAtIndex:[indexPath row]];
    
    if (self.delegate)
        [self.delegate didSelectParticipant:participant];
}

@end
