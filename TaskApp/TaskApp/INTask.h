//
//  INTask.h
//  TaskApp
//
//  Created by iC on 5/13/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INTask : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSDate *timeStamp;

- (instancetype)initWithUsername:(NSString *)username
                           title:(NSString *)title
                         content:(NSString *)content
                       timeStamp:(NSDate *)timeStamp;

@end
