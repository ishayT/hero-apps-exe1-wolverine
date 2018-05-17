//
//  Hero.h
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSNumber *yearBorn;
@property (strong, nonatomic) NSMutableString *powersArr;
@property (strong, nonatomic) NSString *actorName;
@property (strong, nonatomic) NSMutableArray *moviesArr;

@end
