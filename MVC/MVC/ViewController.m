//
//  ViewController.m
//  MVC
//
//  Created by John Clem on 5/8/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "ToDoItem.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *toDoItems;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toDoItems = [NSMutableArray new];
    for (int i=0; i<500; i++) {
        ToDoItem *item = [[ToDoItem alloc] init];
        item.task = [NSString stringWithFormat:@"Task #%d", i];
        if (i % 3 == 0) {
            item.isCompleted = YES;
        }
        [self.toDoItems addObject:item];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];

    ToDoItem *item = [self.toDoItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.task;
    
    if (item.isCompleted) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}
@end
