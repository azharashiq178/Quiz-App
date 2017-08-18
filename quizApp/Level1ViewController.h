//
//  Level1ViewController.h
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Level1ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *questionNo;
@property (weak, nonatomic) IBOutlet UILabel *question;

- (IBAction)prevAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *optionA;
@property (weak, nonatomic) IBOutlet UILabel *optionB;
@property (weak, nonatomic) IBOutlet UILabel *optionC;
@property (weak, nonatomic) IBOutlet UILabel *optionD;
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *buttonB;
@property (weak, nonatomic) IBOutlet UIButton *buttonC;
@property (weak, nonatomic) IBOutlet UIButton *buttonD;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (assign) int myflag;
@property (weak,nonatomic) NSString *tableName;
@property (nonatomic,strong) NSArray *result;

- (IBAction)finishAction:(id)sender;
- (IBAction)pauseAction:(id)sender;
-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;


@end
