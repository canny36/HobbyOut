//
//  HobbyOutAPIClient.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "HobbyOutAPIClient.h"

#import "UserDefaultManager.h"

#define API_KEY @"/?key=1dbd868e8b82abc24a8c0d40b544004a"
#define BASE_URL @"http://www.hobbyout.com/api/"

@implementation HobbyOutAPIClient

static HobbyOutAPIClient *_sharedInstance = nil;

+ (HobbyOutAPIClient *)sharedClient
{
    if (nil != _sharedInstance)
    {
        return _sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        _sharedInstance = [[HobbyOutAPIClient alloc] init];
    });
    
    return _sharedInstance;
}

-(id) init
{
    self = [super initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    
    if (self)
    {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    
    return self;
}

-(void) postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *, id))success
         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure

{
    [super postPath:[self _correctPath:path] parameters:parameters success:success failure:failure];
}

-(void) getPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *, id))success
         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure

{
    [super getPath:[self _correctPath:path] parameters:parameters success:success failure:failure];
}

-(NSString *) _correctPath:(NSString *)path
{
    NSString *correctPath = [path stringByAppendingString:API_KEY];
    
    if ([UserDefaultManager getSessionToken])
    {
        NSString *tokeParam = [@"&token=" stringByAppendingString:[UserDefaultManager getSessionToken]];
        correctPath = [correctPath stringByAppendingString:tokeParam];
    }
    
    return correctPath;
}

@end
