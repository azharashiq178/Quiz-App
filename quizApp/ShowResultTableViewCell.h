//
//  ShowResultTableViewCell.h
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionNo;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UILabel *option1;
@property (weak, nonatomic) IBOutlet UILabel *option2;
@property (weak, nonatomic) IBOutlet UILabel *option3;
@property (weak, nonatomic) IBOutlet UILabel *option4;

@end
