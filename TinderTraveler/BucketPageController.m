//
//  NameViewController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "BucketPageController.h"

@interface BucketPageController()
@end

@implementation BucketPageController

NSString *levelSelection;
int challengeLevel = 1;
int noOfQuestions = 0;
#define LEGAL	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

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

-(IBAction)validateTextFields:(id)sender
{
    // make sure all fields are have something in them
    }

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //NSLog(@"%i", noOfQuestions);
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation != UIDeviceOrientationLandscapeLeft) &&
	(orientation != UIDeviceOrientationLandscapeRight);
}

- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    /*if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        titleLabel.center = CGPointMake(230,20);
        nameLabel.center = CGPointMake(230,70);
        [nameText setFrame:CGRectMake(120, 90, 220, 40)];
        choicesLabel.center = CGPointMake(240, 160);
        self.levelPickerView.center = CGPointMake(230,210);
        nameOK.center = CGPointMake(230,270);
    }
    else
    {
        titleLabel.center = CGPointMake(160,43);
        nameLabel.center = CGPointMake(160,97);
        [nameText setFrame:CGRectMake(50, 120, 200, 40)];
        choicesLabel.center = CGPointMake(156, 200);
        self.levelPickerView.center = CGPointMake(160,250);
        nameOK.center = CGPointMake(154,328);
    }*/
}


@end
