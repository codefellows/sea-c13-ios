//
//  SecondViewController.h
//  Protocols
//
//  Created by John Clem on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondViewControllerDelegate <NSObject>

- (void)updatedNumberString:(NSString *)numberString;

@end

@interface SecondViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SecondViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *currentNumber;

@end
