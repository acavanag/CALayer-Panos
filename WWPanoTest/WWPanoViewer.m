//
//  WWPanoViewer.m
//  WWPanoTest
//
//  Created by Andrew Cavanagh on 3/6/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "WWPanoViewer.h"

@interface WWPanoViewer()
{
    UIImageView *c0;
    UIImageView *c1;
    UIImageView *c2;
    UIImageView *c3;
    UIImageView *c4;
    UIImageView *c5;
    CGFloat sideSize;
    CGFloat hAngle;
    CGFloat vAngle;
    CGFloat zoomFactor;
    UIPanGestureRecognizer *panSensor;
    
    NSTimer *timer;
}
@end

@implementation WWPanoViewer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildCube];
    }
    return self;
}

- (void)loop
{
    hAngle = hAngle-(0.5/(zoomFactor/1.5));
    vAngle = 0.35;

    [self render];
}

- (void)buildCube
{
    sideSize = 320;

	CGRect rect = CGRectMake(0, 0, sideSize*2, sideSize*2);
    CGPoint centerPoint = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    
    c0 = [[UIImageView alloc] initWithFrame:rect];
    c1 = [[UIImageView alloc] initWithFrame:rect];
    c2 = [[UIImageView alloc] initWithFrame:rect];
    c3 = [[UIImageView alloc] initWithFrame:rect];
    c4 = [[UIImageView alloc] initWithFrame:rect];
    c5 = [[UIImageView alloc] initWithFrame:rect];
    
    [c0 setCenter:centerPoint];
    [c1 setCenter:centerPoint];
    [c2 setCenter:centerPoint];
    [c3 setCenter:centerPoint];
    [c4 setCenter:centerPoint];
    [c5 setCenter:centerPoint];
    
    [c0 setImage:[UIImage imageNamed:@"TowerHousepano_f.jpg"]];
    [c1 setImage:[UIImage imageNamed:@"TowerHousepano_r.jpg"]];
    [c2 setImage:[UIImage imageNamed:@"TowerHousepano_b.jpg"]];
    [c3 setImage:[UIImage imageNamed:@"TowerHousepano_l.jpg"]];
    [c4 setImage:[UIImage imageNamed:@"TowerHousepano_u.jpg"]];
    [c5 setImage:[UIImage imageNamed:@"Down_fixed.jpg"]];
    
    [self addSubview:c0];
    [self addSubview:c1];
    [self addSubview:c2];
    [self addSubview:c3];
    [self addSubview:c4];
    [self addSubview:c5];
    
    panSensor = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panSensor];
    
    hAngle = 0;
    vAngle = 0;
    zoomFactor = sideSize;
    
    [self render];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(loop) userInfo:nil repeats:YES];
}

#pragma mark - Rendering

- (void)render
{
    CATransform3D transform = CATransform3DIdentity;
    
    CGFloat currentHAngle = hAngle;
    CGFloat currentVAngle = vAngle;
    CGFloat mThirtyFourFactor = 1 / -zoomFactor;

    
    transform.m34 = mThirtyFourFactor;
    transform = CATransform3DTranslate(transform,
									   sideSize*sinf(-currentHAngle),
									   -sideSize*cosf(-currentHAngle)*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentHAngle)*cosf(-currentVAngle)-zoomFactor)
									   );
	transform=CATransform3DRotate(transform, currentHAngle, 0, 1, 0);
	c0.layer.transform=CATransform3DRotate(transform, currentVAngle, cosf(currentHAngle), 0, sinf(currentHAngle));
    
	currentHAngle = hAngle-(M_PI/2);
	currentVAngle = vAngle;
	transform = CATransform3DIdentity;
    transform.m34 = mThirtyFourFactor;
	transform = CATransform3DTranslate(transform,
									   sideSize*sinf(-currentHAngle),
									   -sideSize*cosf(-currentHAngle)*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentHAngle)*cosf(-currentVAngle)-zoomFactor)
									   );
	transform=CATransform3DRotate(transform, currentHAngle, 0, 1, 0);
	c1.layer.transform=CATransform3DRotate(transform, currentVAngle, cosf(currentHAngle), 0, sinf(currentHAngle));
	
	currentHAngle = hAngle-(M_PI);
	currentVAngle = vAngle;
	transform = CATransform3DIdentity;
    transform.m34 = mThirtyFourFactor;
	transform = CATransform3DTranslate(transform,
									   sideSize*sinf(-currentHAngle),
									   -sideSize*cosf(-currentHAngle)*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentHAngle)*cosf(-currentVAngle)-zoomFactor)
									   );
	transform = CATransform3DRotate(transform, currentHAngle, 0, 1, 0);
	c2.layer.transform = CATransform3DRotate(transform, currentVAngle, cosf(currentHAngle), 0, sinf(currentHAngle));
	
	currentHAngle=hAngle-(3*M_PI/2);
	currentVAngle=vAngle;
	transform = CATransform3DIdentity;
    transform.m34 = mThirtyFourFactor;
	transform = CATransform3DTranslate(transform,
									   sideSize*sinf(-currentHAngle),
									   -sideSize*cosf(-currentHAngle)*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentHAngle)*cosf(-currentVAngle)-zoomFactor)
									   );
	transform = CATransform3DRotate(transform, currentHAngle, 0, 1, 0);
	c3.layer.transform=CATransform3DRotate(transform, currentVAngle, cosf(currentHAngle), 0, sinf(currentHAngle));
	
	currentHAngle = hAngle;
	currentVAngle = vAngle-(M_PI/2);
	transform = CATransform3DIdentity;
    transform.m34 = mThirtyFourFactor;
	transform = CATransform3DTranslate(transform,
									   0,
									   -sideSize*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentVAngle)-zoomFactor)
									   );
	
	transform=CATransform3DRotate(transform, currentVAngle, 1,0,0);
	c4.layer.transform=CATransform3DRotate(transform, currentHAngle, 0, 0, 1);
	
	currentHAngle=hAngle;
	currentVAngle=vAngle+(M_PI/2);
	transform = CATransform3DIdentity;
    transform.m34 = mThirtyFourFactor;
	transform = CATransform3DTranslate(transform,
									   0,
									   -sideSize*sinf(-currentVAngle),
									   -(sideSize*cosf(-currentVAngle)-zoomFactor)
									   );
	
	transform = CATransform3DRotate(transform, currentVAngle, 1,0,0);
	c5.layer.transform=CATransform3DRotate(transform, -currentHAngle, 0, 0, 1);
}

#pragma mark - Touch Handling

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged || gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint translation=[gestureRecognizer translationInView:self];
		hAngle = hAngle-(translation.x/(zoomFactor/1.5));
		vAngle = vAngle+(translation.y/(zoomFactor/1.5));
        
        [self render];
        
        [gestureRecognizer setTranslation:CGPointZero inView:self];
    }
}


@end
