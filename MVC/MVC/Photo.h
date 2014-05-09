//
//  Photo.h
//  MVC
//
//  Created by John Clem on 5/8/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSDate *date;

@end
