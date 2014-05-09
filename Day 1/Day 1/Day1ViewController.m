//
//  ViewController.m
//  Day 1
//
//  Created by John Clem on 5/6/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Day1ViewController.h"

@interface Day1ViewController ()

@end

@implementation Day1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Root View";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logToConsole:(id)sender
{
    UIButton *theButton = sender;
    NSLog(@"Button Title Is: %@", theButton.titleLabel.text);
        
//    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)logFirstNameToConsole:(id)sender
{
    NSLog(@"John");
    
    UIColor *greenColor = [UIColor greenColor];
    
//    [[self view] setBackgroundColor:greenColor];
    
//    self.view.backgroundColor = greenColor;
}










@end
