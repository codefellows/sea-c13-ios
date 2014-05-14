//
//  INViewController.m
//  TaskApp
//
//  Created by iC on 5/13/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "INViewController.h"
#import "INTask.h"
#import "INTaskTableViewCell.h"

static NSString * const INTaskCellIdentifier = @"TaskCell";

@interface INViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *posts;

@end

@implementation INViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSMutableArray *posts = [NSMutableArray new];
    
    for (int i = 0; i < 10; i++) {
        INTask *post = [[INTask alloc]initWithUsername:@"Michael"
                                                 title:@"Cool"
                                               content:@"Do something." timeStamp:[NSDate date]];
        [posts addObject:post];
    }
    
    self.posts = posts;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INTaskTableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:INTaskCellIdentifier
                                                                    forIndexPath:indexPath];
    
    INTask *task = [self.posts objectAtIndex:indexPath.row];
    [taskCell setTask:task];
    
    return taskCell;
}

@end
