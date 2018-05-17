//
//  AppDelegate.h
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

