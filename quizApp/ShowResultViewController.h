//
//  ShowResultViewController.h
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowResultViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)popToMain:(id)sender;
@property (nonatomic,weak) NSString *tableName;
@end
