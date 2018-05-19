//
//  ViewController.h
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
@property (weak, nonatomic) IBOutlet UILabel *moviesLabel;
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;


// all the labels
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *nickNameDetail;


@property (weak, nonatomic) IBOutlet UILabel *yearBorn;
@property (weak, nonatomic) IBOutlet UILabel *yearBornDetail;


@property (weak, nonatomic) IBOutlet UILabel *powers;
@property (weak, nonatomic) IBOutlet UILabel *powersDetail;


@property (weak, nonatomic) IBOutlet UILabel *originalActor;
@property (weak, nonatomic) IBOutlet UILabel *originalActorDetail;






@end

