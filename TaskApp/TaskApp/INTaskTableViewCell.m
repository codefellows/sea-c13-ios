//
//  INTaskTableViewCell.m
//  TaskApp
//
//  Created by iC on 5/13/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "INTaskTableViewCell.h"
#import "INTask.h"

@implementation INTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTask:(INTask *)task
{
    _task = task;
    
    self.contentLabel.text = task.title;
}

@end
