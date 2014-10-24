//
//  SignInController.c
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import "SignInController.h"
#import "MatchPageController.h"

@implementation SignInController
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;

- (void) viewDidLoad {
 
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_location"];
    self.loginView.delegate = self;
    self.responseData = [NSMutableData data];
}

// This method will be called when the user information has been fetched after login
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    
    id<FBGraphPlace> fbPlace = [user location];
    id<FBGraphLocation> fbLocation = [fbPlace location];
    self.fbId = user.objectID;
    self.emailId = [user objectForKey:@"email"];
    self.userLocation = [user objectForKey:@"location"][@"name"];
    NSString *userCity = [fbLocation city];
    NSString *userCountry = [fbLocation country];
    NSString *userZip = [fbLocation zip];
    
    self.userAge = user.birthday;
    self.userGender = [user objectForKey:@"gender"];
    self.userZip = [user objectForKey:@"zipcode"];
    
   // NSLog(@"%@", user.objectID);
    [self performSegueWithIdentifier:@"MatchPage" sender:nil];

    self.nameLabel.text = user.objectID;
    [self createUser];
}

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    NSLog(@"User logged in");
    self.statusLabel.text = @"You're logged in";
    //[self performSegueWithIdentifier:@"HomePage" sender:self];
}

// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"User logged out");
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text = @"You're not logged in!";
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MatchPage"]) {

    MatchPageController *matchPageView = segue.destinationViewController;
    matchPageView.fbId = self.fbId;
    matchPageView.emailId = self.emailId;
    matchPageView.userLocation = self.userLocation;
    matchPageView.userAge = self.userAge;
    matchPageView.userGender = self.userGender;
    matchPageView.userZip = self.userZip;
    }
}

-(void)createUser
{
    //NSString *post = [NSString stringWithFormat:@"&fbId=%@&emailId=%@&location=%@&zip=%@&age=%@&gender=%@&mainphoto=%@&authtoken=%@", self.fbId, self.emailId, self.userLocation, self.userZip, self.userAge, self.userGender, NULL, NULL ];
    
    
    self.nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=checkUser";
    //NSString *post = [NSString stringWithFormat:@"&fbId=%@&emailId=%@&location=%@&zip=%@&age=%@&gender=%@&mainphoto=%@&authtoken=%@", self.fbId, self.emailId, self.userLocation, self.userZip, self.userAge, self.userGender, NULL, NULL ];
    NSString *post = [NSString stringWithFormat:@"&fbId=%@&emailId=%@", self.fbId, self.emailId];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    
    self.nsURL = [self.nsURL stringByAppendingString:post];

    //NSLog(@"URL=%@",self.nsURL);
    
    self.responseData = [NSMutableData data];
    
    NSMutableURLRequest *aRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: self.nsURL]];
    
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [aRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
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

@end