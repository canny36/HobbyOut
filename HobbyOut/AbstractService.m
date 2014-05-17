//
//  AbstractService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"
#import "HobbyOutAPIClient.h"

#import "MBProgressHUD.h"

@implementation AbstractService
{
    HobbyOutAPIClient *_hobbyOutAPIClient;

}

-(id) initWithPath:(NSString *) path
{
    self = [super init];
    
    if (self)
    {
        self.path = path;
        _hobbyOutAPIClient = [HobbyOutAPIClient sharedClient];
    }
    
    return self;
    
}

-(void) postWithParameters:(NSDictionary *)params
{
    [self postWithParameters:params forView:nil];
}

-(void) postWithParameters:(NSDictionary *)params forView:(UIView *) view
{
    if (view)
    {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
//    _hobbyOutAPIClient.parameterEncoding  =AFJSONParameterEncoding;
    [_hobbyOutAPIClient postPath:self.path
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             
                                    if (view)
                                    {
                                        [MBProgressHUD hideHUDForView:view animated:YES];
                                    }
                             NSLog(@"URL : %@", operation.request.description);
                                    NSError *e = nil;
                                    [self onSuccess:[NSJSONSerialization JSONObjectWithData:responseObject
                                                                                    options: NSJSONReadingMutableContainers error: &e]];
                                }
     
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                                    if (view)
                                    {
                                        [MBProgressHUD hideHUDForView:view animated:YES];
                                    }
                             
                                    [self onFail:error.localizedDescription];
                                }
     ];

}

-(void) getWithParameters:(NSDictionary *)params
{
    [self getWithParameters:params forView:nil];
}

-(void) getWithParameters:(NSDictionary *)params forView:(UIView *) view
{

    if (view)
    {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    [_hobbyOutAPIClient getPath:self.path
                      parameters:params
     
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSLog(@"URL : %@", operation.request.description);
                             if (view)
                             {
                                [MBProgressHUD hideAllHUDsForView:view animated:YES];
                             }
                             NSError *e = nil;
                             [self onSuccess:[NSJSONSerialization JSONObjectWithData:responseObject
                                                                             options: NSJSONReadingMutableContainers error: &e]];
                         }
     
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                             if (view)
                             {
                                 [MBProgressHUD hideAllHUDsForView:view animated:YES];
                             }
                             
                             [self onFail:error.localizedDescription];
                         }
     ];
    
}

-(void) onSuccess:(NSDictionary*)response
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void) onFail:(NSString*)message
{
    NSLog(@"ERROR : %@", message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oulala !"
                                                    message:@"Problème d'accès au serveur, veuillez réessayer plus tard."
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    
    [alert show];
}

@end
