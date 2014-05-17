//
//  AbstractService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractService : NSObject


@property(nonatomic) NSString *path;

-(id) initWithPath:(NSString *) path;

-(void) postWithParameters:(NSDictionary *)params;
-(void) postWithParameters:(NSDictionary *)params forView:(UIView *) view;

-(void) getWithParameters:(NSDictionary *)params;
-(void) getWithParameters:(NSDictionary *)params forView:(UIView *) view;

-(void) onSuccess:(NSDictionary*)response;
-(void) onFail:(NSString*)message;


@end
