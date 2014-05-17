//
//  HobbyOutAPIClient.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HobbyOutAPIClient : AFHTTPClient

+ (HobbyOutAPIClient *)sharedClient;

@end
