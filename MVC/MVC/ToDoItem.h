//
//  ToDoItem.h
//  MVC
//
//  Created by John Clem on 5/8/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *task;
@property (nonatomic) BOOL isCompleted;

@end
