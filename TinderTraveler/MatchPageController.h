//
//  BucketList Page
//  <App name>
//
//  Created by Chan Komagan on 10/15/14.
//  Copyright (c) 2015 TinderTraveler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MatchPageController : UIViewController
{
    NSMutableData *responseData;
}

     @property (strong, nonatomic) IBOutlet UILabel *nameLabel;
     @property (strong, nonatomic) IBOutlet UILabel *ageLabel;
     @property (strong, nonatomic) IBOutlet UILabel *locationLabel;
     @property (strong, nonatomic) IBOutlet UIImageView *profilePictureView;
     @property (nonatomic) NSString *fbId;
     @property (strong, nonatomic) IBOutlet UIButton *settingsBtn;
     @property (strong, nonatomic) IBOutlet UIButton *chatBtn;
     @property (nonatomic) NSString *emailId;
     @property (nonatomic) NSString *userName;
     @property (nonatomic) NSString *userLocation;
     @property (nonatomic) NSString *userAge;
     @property (nonatomic) NSString *userGender;
     @property (nonatomic) NSString *userZip;
     @property (nonatomic, strong) NSString *nsURL;
     @property (nonatomic, strong) NSString *urlPrefix;
     @property (nonatomic, retain) NSMutableData *responseData;

@end