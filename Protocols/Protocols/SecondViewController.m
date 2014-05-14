//
//  SecondViewController.m
//  Protocols
//
//  Created by John Clem on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, weak) IBOutlet UILabel *numberLabel;

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"Current Number: %@", _currentNumber);
    _numberLabel.text = _currentNumber;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)incrementCurrentNumber:(id)sender
{
    _numberLabel.text = [NSString stringWithFormat:@"%d", [_numberLabel.text integerValue] +1 ];
    
    [self.delegate updatedNumberString:_numberLabel.text];
}










/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
