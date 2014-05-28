//
//  ViewController.m
//  CollectionView Demo
//
//  Created by John Clem on 5/27/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) BOOL flipped;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation ViewController

- (UIImage *)imageForURL:(NSURL *)puppyURL
{
    NSData *puppyData = [NSData dataWithContentsOfURL:puppyURL];
    UIImage *puppyImage = [UIImage imageWithData:puppyData];
    return puppyImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _photos = [NSMutableArray new];
    
    NSURL *puppy0URL = [NSURL URLWithString:@"http://w.mawebcenters.com/static/ecommerce/59/59335/media/catalog/product/cache/1/image/5e06319eda06f020e43594a9c230972d/b/o/boxer_001.jpg"];
    NSURL *puppy1URL = [NSURL URLWithString:@"http://www.bullytree.com/wp-content/uploads/2014/04/Fawn-Boxer-Dog.jpg"];
    
    for (int i=0; i<10; i++) {
        NSURL *puppyURL = i % 2 ? puppy0URL : puppy1URL;
        [_photos addObject:puppyURL];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSURL *puppyURL = _photos[indexPath.row];
    cell.puppyView.image = [self imageForURL:puppyURL];

    cell.layer.borderWidth = 2.f;
    cell.layer.borderColor = [UIColor colorWithRed:0.267 green:0.522 blue:0.965 alpha:1].CGColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row % 2) {
//        return CGSizeMake(80, 80);
//    } else {
//        return CGSizeMake(80, 220);
//    }
    if (_flipped) {
        return indexPath.row % 2 ? CGSizeMake(80, 80) : CGSizeMake(80, 220);
    } else {
        return indexPath.row % 2 ? CGSizeMake(80, 220) : CGSizeMake(80, 80);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView performBatchUpdates:^{
        _flipped = !_flipped;
        [collectionView reloadData];
    } completion:^(BOOL finished) {
        
    }];
}
@end
