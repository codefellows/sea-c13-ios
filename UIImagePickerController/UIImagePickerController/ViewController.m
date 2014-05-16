//
//  ViewController.m
//  UIImagePickerController
//
//  Created by John Clem on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation ViewController

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (IBAction)showImagePicker:(id)sender
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Source Type"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Photo Library", @"Camera", nil];
        [actionSheet showFromBarButtonItem:sender animated:YES];
    } else {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }

}

- (void)saveImageToLibrary:(UIImage *)editedImage
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage
                                    orientation:ALAssetOrientationUp
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    NSLog(@"Asset URL: %@", assetURL);
                                }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        editedImage = [editedImage applyTintEffectWithColor:[UIColor lightGrayColor]];

        _imageView.image = editedImage;
        _imageView.layer.cornerRadius = _imageView.frame.size.width / 2.0;
        [_imageView setClipsToBounds:YES];
        
        [self saveImageToLibrary:editedImage];
        

        
    }];
}

- (IBAction)showShareSheet:(id)sender
{
    if (_imageView.image) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image, @"Creepy Circle Puppy"] applicationActivities:nil];
        
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
}






@end
