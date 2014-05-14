//
//  ViewController.m
//  Protocols
//
//  Created by John Clem on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "UIColor+RandomColor.h"

@interface ViewController () <SecondViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *numberButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor randomColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SecondViewController *secondVC = segue.destinationViewController;
    secondVC.currentNumber = [[_numberButton titleLabel] text];
    secondVC.delegate = self;
}

- (void)updatedNumberString:(NSString *)numberString
{
    NSLog(@"Number String From 1st View Controller: %@", numberString);
    _numberButton.titleLabel.text = numberString;
}

@end
