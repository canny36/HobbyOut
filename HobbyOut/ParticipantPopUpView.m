//
//  ParticipantPopUpView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "ParticipantPopUpView.h"
#import "AppStyle.h"
#import "ParticipantCollectionCell.h"

@implementation ParticipantPopUpView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 314, 270)];
    
    if (self)
    {
        [self setBackgroundImage:@"participantPopUp.png"];
        
        self.closeButtonPopUp = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        [self.closeButtonPopUp setImage:[UIImage imageNamed:@"closePopUpButton.png"] forState:UIControlStateNormal];
        [self addSubview:self.closeButtonPopUp toTop:@10 right:@10 bottom:nil left:nil];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 20)];
        title.text = @"Liste des participants";
        [AppStyle popUpTitleLabel:title];
        [self addSubview:title];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setItemSize:CGSizeMake(62, 80)];
        [flowLayout setMinimumInteritemSpacing:5.f];
        [flowLayout setMinimumLineSpacing:5.f];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 45, 295, 205) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[ParticipantCollectionCell class] forCellWithReuseIdentifier:@"ParticipantCell"];
        
        [self addSubview:self.collectionView];
        
    }
    
    return self;
}


@end
