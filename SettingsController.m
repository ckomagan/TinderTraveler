//
//  SettingsController.m
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import "SettingsController.h"
#import "SignInController.h"

@implementation SettingsController
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;

- (void) viewDidLoad {
    
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_location"];
    self.loginView.delegate = self;
    self.responseData = [NSMutableData data];
    [self.view addSubview:self.loginView];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    self.loggedInUser=user;

    self.fbId = user.objectID;

    }

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    NSLog(@"User logged in");
 
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"User logged out");
    [self performSegueWithIdentifier:@"SignInPage" sender:nil];
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

}

- (void)fbDidLogout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    //        Finding the Facebook Cookies and deleting them
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* facebookCookies = [cookies cookiesForURL:
                                [NSURL URLWithString:@"http://login.facebook.com"]];
    for (NSHTTPCookie* cookie in facebookCookies) {
        [cookies deleteCookie:cookie];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SignInPage"]) {
        
        SignInController *signInPageView = segue.destinationViewController;
     }
}

@end