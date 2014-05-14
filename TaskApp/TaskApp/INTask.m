//
//  INTask.m
//  TaskApp
//
//  Created by iC on 5/13/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "INTask.h"

@implementation INTask

- (instancetype)init
{
    return [self initWithUsername:@"New Name" title:@"Title" content:@"New task." timeStamp:[NSDate date]];
}

- (instancetype)initWithUsername:(NSString *)username title:(NSString *)title content:(NSString *)content timeStamp:(NSDate *)timeStamp
{
    self = [super init];
    if (self) {
        
        _userName = username;
        _title = title;
        _content = content;
        _timeStamp = timeStamp;
        
    }
    return self;
}

@end
