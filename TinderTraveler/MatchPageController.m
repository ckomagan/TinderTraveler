//
//  MatchPController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "MatchPageController.h"
#import "HomePageController.h"

@implementation MatchPageController
@synthesize fbId;
@synthesize nsURL;
@synthesize urlPrefix;
@synthesize responseData;
@synthesize profilePictureView;
NSDictionary *res;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *post = [NSString stringWithFormat:@"&fbId=%@", self.fbId];
  
    self.nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=match";
    self.nsURL = [self.nsURL stringByAppendingString:post];

    //NSLog(@"URL=%@",self.nsURL);
    
    self.responseData = [NSMutableData data];
    
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: self.nsURL]];
   
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{

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
        NSString *id = [res1 objectForKey:@"id"];
        
        NSString *name = [res1 objectForKey:@"name"];
        NSString *age = [res1 objectForKey:@"age"];
        NSString *gender = [res1 objectForKey:@"gender"];
        NSString *location = [res1 objectForKey:@"location"];

        NSString *photo = [res1 objectForKey:@"mainphoto"];
        NSURL *imageUrl = [NSURL URLWithString: [@"http://komagan.com/TinderTraveler/" stringByAppendingString:photo]];
        
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:data];
        [profilePictureView setImage:image];
        name = [name stringByAppendingString:@", "];
        self.nameLabel.text = [name stringByAppendingString:age];
        self.locationLabel.text = location;
    }
}

-(IBAction)settingsBtn:(id)sender {
    [self performSegueWithIdentifier:@"HomePage" sender:self];    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HomePage"]) {
        
        HomePageController *homePageView = segue.destinationViewController;
    }
}

@end
