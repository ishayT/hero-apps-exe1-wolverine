//
//  FullImageViewController.m
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/18/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import "FullImageViewController.h"

@interface FullImageViewController ()

@end

@implementation FullImageViewController

@synthesize fullSizeImageOutlet;
@synthesize fullSizeImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    fullSizeImageOutlet.image = fullSizeImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// method that handle the pinchgesture
- (IBAction)handlePinch:(UIGestureRecognizer *)sender {
    //NSLog(@"pinched");
    
    CGFloat lastScaleFactor = 1;
    CGFloat factor = [(UIPinchGestureRecognizer *) sender scale];
    
    if (factor > 1) {   //zooming in
        fullSizeImageOutlet.transform = CGAffineTransformMakeScale(lastScaleFactor + (factor -1), lastScaleFactor + (factor -1));
        
    } else {    //zooming out
        fullSizeImageOutlet.transform = CGAffineTransformMakeScale(lastScaleFactor * factor -1, lastScaleFactor * factor);
        
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (factor > 1) {
            
            lastScaleFactor += (factor -1);
            
        } else {
            
            lastScaleFactor *= factor;
        }
    }
}
@end
