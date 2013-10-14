//
//  NAParentalGateAlert.m
//
//  Created by Nathan Rowe on 9/28/13.
//  Copyright (c) 2013 Natrosoft LLC. All rights reserved.
//

#import "NAParentalGateAlert.h"

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or go to your target > build phases > compiler flags and add the flag -fobjc-arc to this class.
#endif

NSString * const NAPGA_STRINGS_BUNDLE_NAME      = @"NAParentalGateAlert.bundle";
NSString * const NAPGA_STRINGS_FILE_NAME        = @"Localizable";
NSInteger const NAPGA_NUMBER_OF_ANSWERS         = 3;


@implementation NAParentalGateAlert
/* Necessary to guarantee that the class will be alive long enough to receive delegate callbacks */
static NSMutableArray *retainSelfQueue;

- (id) initAlertWithAction:(NAParentalGateAlertBlock)actionBlock
{
    self = [super init];
    if (self) {
        _actionBlock = actionBlock;
        _titleString = NSLocalizedStringWithDefaultValue(@"Are you an adult?",
                                                         NAPGA_STRINGS_FILE_NAME,
                                                         [self getBundle],
                                                         @"Are you an adult?",
                                                         @"alert title");
        
        _cancelButtonString = NSLocalizedStringWithDefaultValue(@"Cancel",
                                                                NAPGA_STRINGS_FILE_NAME,
                                                                [self getBundle],
                                                                @"Cancel",
                                                                @"cancel button text");
        [self buildQuestionAndAnswers];
    }
    return self;
}


+ (NAParentalGateAlert *) alertWithAction:(NAParentalGateAlertBlock)actionBlock
{
    return [[NAParentalGateAlert alloc] initAlertWithAction:actionBlock];
}


- (void) show
{
    _alertView = [[UIAlertView alloc] init];
    [_alertView setTitle:_titleString];
    [_alertView setMessage:_questionString];
    for (NSString *aButtonTitle in _otherButtonTitles) {
        if (aButtonTitle) {
            [_alertView addButtonWithTitle:aButtonTitle];
        }
    }
    if (_cancelButtonString) {
        [_alertView addButtonWithTitle:_cancelButtonString];
    }
    
    //Add self to retain queue
    @synchronized ([self class]) {
        if (retainSelfQueue == nil) {
            retainSelfQueue = [NSMutableArray arrayWithCapacity:1];
        }
        [retainSelfQueue addObject:self];
    }
    
    _alertView.delegate = self;
    [_alertView show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Run the action if correct button was pressed
    if (buttonIndex == _correctButtonIndex && _actionBlock != nil) {
        _actionBlock();
    }

    //Remove self from queue; nil out queue of no other objects
    @synchronized ([self class]) {
        [retainSelfQueue removeObject:self];
        if ([retainSelfQueue count] == 0) {
            retainSelfQueue = nil;  //no need to keep queue alive if not currently needed
        }
    }
}


- (NSBundle *) getBundle
{
    static NSBundle* bundle = nil;
    if (!bundle) {
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:NAPGA_STRINGS_BUNDLE_NAME];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}



- (void) buildQuestionAndAnswers
{
    NSInteger leftNumber = ((arc4random() % 5) + 1) * 10;
    NSInteger rightNumber = ((arc4random() % 5) + 1) * 10;
    _questionString = [NSString stringWithFormat:@"%ld + %ld = ?", (long)leftNumber, (long)rightNumber];

    
    _correctButtonIndex = arc4random() % NAPGA_NUMBER_OF_ANSWERS;

    _otherButtonTitles = [NSMutableArray arrayWithCapacity:NAPGA_NUMBER_OF_ANSWERS];
    for (int i=0; i < NAPGA_NUMBER_OF_ANSWERS; i++)
    {
        if (i == _correctButtonIndex) {
            [_otherButtonTitles addObject:[NSString stringWithFormat:@"%ld", (long)(leftNumber+rightNumber)]];
        }
        else {
            NSInteger wrongAnswer = arc4random() % 100;
            if (wrongAnswer == leftNumber+rightNumber) {
                wrongAnswer += 3;
            }
            [_otherButtonTitles addObject:[NSString stringWithFormat:@"%ld", (long)wrongAnswer]];
        }
    }
}
                  


- (void) dealloc
{
    [retainSelfQueue removeObject:self];  //defensive measure if non-arc manually releases this object when it was alloc'd as autorelease
    _alertView.delegate = nil;
}

@end
