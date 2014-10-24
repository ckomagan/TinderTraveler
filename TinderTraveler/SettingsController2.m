//
//  SettingsController
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import "SettingsController.h"

@implementation SettingsController
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;

- (void) viewDidLoad {
    self.logoutView.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_location"];
    self.logoutView.delegate = self;
    self.responseData = [NSMutableData data];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)logoutView
                            user:(id<FBGraphUser>)user {
    self.fbId = user.objectID;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)logoutView{
    NSLog(@"User logged in");
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)logoutView {
    NSLog(@"User logged out");

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    for(NSDictionary *res1 in res) {
        NSString *id = [res1 objectForKey:@"result"];
        NSLog(@"%@", id);
    }
}

@end