//
//  WEBCall.h
//  Delegations
//
//  Created by iC on 5/20/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WEBCallDelegate <NSObject>

- (void)webCallDidFinish:(NSString *)string;

@end

@interface WEBCall : NSObject

@property (unsafe_unretained, nonatomic) id <WEBCallDelegate> delegate;

- (NSString *)webCallWithParameters:(NSDictionary *)parameters;

@end
