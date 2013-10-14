//
//  NAParentalGateAlert.h
//
//  Created by Nathan Rowe on 9/28/13.
//  Copyright (c) 2013 Natrosoft LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>


typedef void (^NAParentalGateAlertBlock)(void);

/**
 This is a simple class that provides a "parental gate" useful for kids apps
 that prompts the user to answer a simple math question before proceeding.  It 
 uses a UIAlert for the prompt and a block for the action.  If the user answers
 correctly, your action is run.  If user presses cancel or answers incorrectly, 
 the alert simply dismisses.

 Example usage:
    NAParentalGateAlert myAlert = [NAParentalGateAlert alertWithAction:^{ //push my gated view }];
    [myAlert show];
 
 @discussion
 Built for ARC.  You can also use in a non-ARC project, just go to
 your target > build phases > compiler flags and add the flag -fobjc-arc for this class.
 
 */
@interface NAParentalGateAlert : NSObject <UIAlertViewDelegate>
{
    NSInteger _correctButtonIndex;
}
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *questionString;
@property (nonatomic, strong) NSString *cancelButtonString;
@property (nonatomic, strong) NAParentalGateAlertBlock actionBlock;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) NSMutableArray *otherButtonTitles;



+ (NAParentalGateAlert *) alertWithAction:(NAParentalGateAlertBlock)actionBlock;
- (id) initAlertWithAction:(NAParentalGateAlertBlock)actionBlock;
- (void) show;


@end
