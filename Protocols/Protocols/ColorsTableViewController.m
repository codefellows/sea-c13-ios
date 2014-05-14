//
//  ColorsTableViewController.m
//  Protocols
//
//  Created by John Clem on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ColorsTableViewController.h"
#import "UIColor+RandomColor.h"

@interface ColorsTableViewController ()

@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation ColorsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _colors = [NSMutableArray new];
    [_colors addObject:[UIColor randomColor]];
    [_colors addObject:[UIColor randomColor]];
    
    [self.tableView reloadData];
}

- (IBAction)newColor:(id)sender
{
    [_colors addObject:[UIColor randomColor]];
    [self.tableView reloadData];
}

- (IBAction)toggleEditing:(id)sender
{
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [(UIBarButtonItem *)sender setTitle:@"Edit"];
    } else {
        [self.tableView setEditing:YES animated:YES];
        [(UIBarButtonItem *)sender setTitle:@"Done"];
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [_colors objectAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_colors removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.tableView beginUpdates];
    
    // move object in array, then reload
    UIColor *fromColor = [_colors objectAtIndex:fromIndexPath.row];
    UIColor *toColor = [_colors objectAtIndex:toIndexPath.row];
    
    [_colors replaceObjectAtIndex:fromIndexPath.row withObject:toColor];
    [_colors replaceObjectAtIndex:toIndexPath.row withObject:fromColor];
    
    [self.tableView reloadRowsAtIndexPaths:@[fromIndexPath, toIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView endUpdates];
}

@end
