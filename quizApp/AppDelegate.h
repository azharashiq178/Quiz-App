//
//  AppDelegate.h
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

