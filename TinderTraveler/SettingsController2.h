//
//  SettingsController.h
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SettingsController : UIViewController <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBLoginView *logoutView;
@property (strong, nonatomic) NSString *objectID;
@property (nonatomic) NSString *fbId;
@property (nonatomic) NSString *emailId;
@property (nonatomic, strong) NSString *nsURL;
@property (nonatomic, retain) NSMutableData *responseData;

@end
