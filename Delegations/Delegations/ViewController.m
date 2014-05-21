//
//  ViewController.m
//  Delegations
//
//  Created by iC on 5/20/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "ViewController.h"
#import "WEBCall.h"

@interface ViewController () <WEBCallDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEBCall *webCall = [[WEBCall alloc]init];
    webCall.delegate = self;
    
    // This will always return nil because the process that "returns valid data" takes 2.5 seconds.
    // This is where delegation would be very usefull (delegation or better yet completion blocks (not yet covered)).
    // See WEBCall class for more info.
    NSString *dataString = [webCall webCallWithParameters:nil];
    NSLog(@"%@", dataString);
}

#pragma mark - WEBCallDelegate

// Delegate gets notified when we have valid data. Now you can process your JSON, populate arrays, set labels, reload tableView. Anything.
- (void)webCallDidFinish:(NSString *)string
{
    NSLog(@"%@", string);
}

@end
