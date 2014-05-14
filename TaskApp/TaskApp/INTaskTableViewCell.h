//
//  INTaskTableViewCell.h
//  TaskApp
//
//  Created by iC on 5/13/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INTask;

@interface INTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) INTask *task;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
