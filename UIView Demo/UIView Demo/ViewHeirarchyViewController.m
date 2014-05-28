//
//  ViewHeirarchyViewController.m
//  UIView Demo
//
//  Created by John Clem on 5/22/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewHeirarchyViewController.h"

@interface ViewHeirarchyViewController ()

@property (nonatomic, strong) UIView *redSquare, *greenSquare;
@property (nonatomic, weak) IBOutlet UIView *blueDropZone;
@property (nonatomic) BOOL animateDropZone;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) UICollisionBehavior *collision;
@end

@implementation ViewHeirarchyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add a red sqaure to the screen
    CGRect redSquareFrame = CGRectMake(120, 240, 80, 80);
    _redSquare = [[UIView alloc] initWithFrame:redSquareFrame];
    _redSquare.backgroundColor = [UIColor greenColor];
    _redSquare.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _redSquare.layer.borderWidth = 4.f;
    [self.view addSubview:_redSquare];
    
    CGRect greenSquareFrame = CGRectMake(160, 320, 40, 40);
    _greenSquare = [[UIView alloc] initWithFrame:greenSquareFrame];
    _greenSquare.backgroundColor = [UIColor greenColor];
    _greenSquare.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _greenSquare.layer.borderWidth = 4.f;
    [self.view addSubview:_greenSquare];

    // Behaviors
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_greenSquare, _redSquare]];
    
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc]initWithItems:@[_greenSquare, _redSquare]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;

    [_animator addBehavior:_collision];
}

- (CAAnimation *)glowAnimation
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1.0);
    animation.toValue = @(0.5);
    animation.repeatCount = 0;
    animation.duration = 0.5;
    animation.autoreverses = YES;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    return animation;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if ([touch.view isEqual:_redSquare]) {
            [UIView animateWithDuration:0.2 animations:^{
                _redSquare.transform = CGAffineTransformScale(_redSquare.transform, 1.25, 1.25);
            }];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if ([touch.view isEqual:_redSquare]) {
            CGPoint touchPoint = [touch locationInView:_redSquare.superview];
            _redSquare.center = touchPoint;
            
            if ([_blueDropZone pointInside:touchPoint withEvent:nil]) {
                NSLog(@"Animate It");
                [self animateDropZone:_blueDropZone];
            } else {
                NSLog(@"Don't Drop");
                [self stopAnimatingDropZone:_blueDropZone];
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopAnimatingDropZone:_blueDropZone];
    
    for (UITouch *touch in touches) {
        if ([touch.view isEqual:_redSquare]) {
            [UIView animateWithDuration:0.2 animations:^{
                _redSquare.transform = CGAffineTransformScale(_redSquare.transform, .8, .8);
            }];
            
            CGPoint touchPoint = [touch locationInView:self.view];
            if ([_blueDropZone pointInside:touchPoint withEvent:nil]) {
                NSLog(@"Drop It");
                [self dropView:_redSquare ontoView:_blueDropZone];
            } else {
                NSLog(@"Don't Drop");
                [self dropView:_redSquare ontoView:self.view];
            }
        }
    }
}

- (void)startOsmosisForView:(UIView *)view onTopOfView:(UIView *)topView
{
    UIColor *fromColor = view.backgroundColor;
    UIColor *toColor = topView.backgroundColor;
    
    if (![fromColor isEqual:toColor]) {
        [UIView animateWithDuration:0.5 animations:^{
            view.backgroundColor = toColor;
        }];
    }
}

- (void)dropView:(UIView *)droppedView ontoView:(UIView *)receivingView
{
    [droppedView removeFromSuperview];
    [receivingView addSubview:droppedView];
    [self startOsmosisForView:droppedView onTopOfView:receivingView];
}

- (void)animateDropZone:(UIView *)dropZone
{
    if (!_animateDropZone) {
        _animateDropZone = YES;
        [self animationDidStop:nil finished:YES];
    }
}

- (void)stopAnimatingDropZone:(UIView *)dropZone
{
    if (_animateDropZone) {
        _animateDropZone = NO;
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_animateDropZone) {
        [_blueDropZone.layer addAnimation:[self glowAnimation] forKey:@"glow"];
    } else {
        [_blueDropZone.layer removeAnimationForKey:@"glow"];
    }
}
@end
