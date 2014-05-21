//
//  WEBCall.m
//  Delegations
//
//  Created by iC on 5/20/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "WEBCall.h"

@implementation WEBCall

- (NSString *)webCallWithParameters:(NSDictionary *)parameters
{
    __block NSString *dataString = nil;
    
    dispatch_queue_t waitQ = dispatch_queue_create("waitQ", NULL);
    dispatch_async(waitQ, ^{
        
        NSLog(@"Starting network request... taking sweet time.");
        
        usleep(2500000);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            dataString = @"This is the data you've been waiting for...";
            
            [self.delegate webCallDidFinish:dataString];
            
        });
    });
    
    return dataString; // This will always be nil in this case because this method return right away but it takes 2.5 second to "get" the value.
}

@end
