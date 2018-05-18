//
//  FullImageViewController.h
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/18/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullImageViewController : UIViewController

@property (weak, nonatomic) UIImage *fullSizeImage;

@property (weak, nonatomic) IBOutlet UIImageView *fullSizeImageOutlet;


- (IBAction)handlePinch:(UIGestureRecognizer *)sender;

@end
