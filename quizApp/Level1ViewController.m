//
//  Level1ViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "Level1ViewController.h"
#import "Level1Data.h"
#import "SCSQLite.h"
#import "ShowResultViewController.h"

@interface Level1ViewController ()
@property (nonatomic,strong) NSMutableArray *tmpData;
@property (nonatomic,strong) UISwipeGestureRecognizer *swipeLeftGreen;
@property (nonatomic,strong) UISwipeGestureRecognizer *swipeRight;
@end

@implementation Level1ViewController
-(void)viewDidAppear:(BOOL)animated{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self mySwipeLeft];
    
    [self mySwipeRight];
    
    
    
    [self.finishButton setHidden:YES];
    _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    
    [self.buttonA addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchDown];
    [self.buttonB addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchDown];
    [self.buttonC addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchDown];
    [self.buttonD addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchDown];
    _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
//    self.myflag = 0;
    self.questionNo.text = [NSString stringWithFormat:@"Question No. %d",self.myflag+1];
    
    if(self.myflag == 0)
        [self.prevButton setEnabled:NO];
    else
        [self.prevButton setEnabled:YES];
    if(self.myflag == [self.result count]-1){
        [self.nextButton setHidden:YES];
        [self.finishButton setHidden:NO];
    }
    self.progressBar.progress = (((self.myflag + 1) * 100.0)/[self.result count])/100.0;
    self.question.text = [[self.result objectAtIndex:self.myflag] valueForKey:@"question"];
    self.optionA.text = [[self.result objectAtIndex:self.myflag] valueForKey:@"option1"];
    self.optionB.text = [[self.result objectAtIndex:self.myflag] valueForKey:@"option2"];
    self.optionC.text = [[self.result objectAtIndex:self.myflag] valueForKey:@"option3"];
    self.optionD.text = [[self.result objectAtIndex:self.myflag] valueForKey:@"option4"];
    NSLog(@"My Result: %@",self.result);
    if(![[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]] && ![[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"]  isEqual:@"ab"]){
        NSLog(@"Good working");
        if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == [[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]){
            if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionA.text){
                [self.buttonA setBackgroundColor:[UIColor greenColor]];
            }
            else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionB.text){
                [self.buttonB setBackgroundColor:[UIColor greenColor]];
            }
            else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionC.text){
                [self.buttonC setBackgroundColor:[UIColor greenColor]];
            }
            else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionD.text){
                [self.buttonD setBackgroundColor:[UIColor greenColor]];
            }
        }
        else{
            if([[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] isEqualToString: self.optionA.text]){
                [self.buttonA setBackgroundColor:[UIColor greenColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] isEqualToString: self.optionB.text]){
                [self.buttonB setBackgroundColor:[UIColor greenColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] isEqualToString: self.optionC.text]){
                [self.buttonC setBackgroundColor:[UIColor greenColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] isEqualToString: self.optionD.text]){
                [self.buttonD setBackgroundColor:[UIColor greenColor]];
            }
            if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString: self.optionA.text]){
                [self.buttonA setBackgroundColor:[UIColor redColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString: self.optionB.text]){
                [self.buttonB setBackgroundColor:[UIColor redColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString: self.optionC.text]){
                [self.buttonC setBackgroundColor:[UIColor redColor]];
            }
            else if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString: self.optionD.text]){
                [self.buttonD setBackgroundColor:[UIColor redColor]];
            }
        }
        [self disableButtons];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"finish"]){
        ShowResultViewController *controller = segue.destinationViewController;
        controller.tableName = self.tableName;
    }
}


- (IBAction)prevAction:(id)sender {
    if(_myflag>0){
        [self performRightAnimation];
        [self clearColor];
        [self disableButtons];
        self.questionNo.text = [NSString stringWithFormat:@"Question No. %d",self.myflag];
        self.progressBar.progress = (((self.myflag ) * 100.0)/[self.result count])/100.0;
        self.myflag--;
        self.optionA.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option1"];
        self.optionB.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option2"];
        self.optionC.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option3"];
        self.optionD.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option4"];
        
        if(self.myflag == 0){
            [self.prevButton setEnabled:NO];
            self.swipeRight.enabled = NO;
        }
        else{
            self.swipeRight.enabled = YES;
            [self.prevButton setEnabled:YES];
        }
        [self.nextButton setEnabled:YES];
        [self.finishButton setHidden:YES];
        [self.nextButton setHidden:NO];
        self.question.text = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
        NSLog(@"%@",[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"]);
        if(![[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]]){
            if( [[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] && [[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"option1"]]){
                if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                    [self.buttonA setBackgroundColor:[UIColor greenColor]];
                }
                else{
                    [self.buttonA setBackgroundColor:[UIColor redColor]];
                    if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonB setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonC setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonD setBackgroundColor:[UIColor greenColor]];
                    }
                }
                
            }
            if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"option2"]]){
                //            [self.buttonB setBackgroundColor:[UIColor redColor]];
                if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                    [self.buttonA setBackgroundColor:[UIColor greenColor]];
                }
                else{
                    [self.buttonB setBackgroundColor:[UIColor redColor]];
                    if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonA setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonC setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonD setBackgroundColor:[UIColor greenColor]];
                    }
                }
                
            }
            if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"option3"]]){
                //            [self.buttonC setBackgroundColor:[UIColor redColor]];
                if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                    [self.buttonC setBackgroundColor:[UIColor greenColor]];
                }
                else{
                    [self.buttonC setBackgroundColor:[UIColor redColor]];
                    if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonB setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonA setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonD setBackgroundColor:[UIColor greenColor]];
                    }
                }
                
                
            }
            if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"option4"]]){
                //            [self.buttonD setBackgroundColor:[UIColor redColor]];
                if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                    [self.buttonD setBackgroundColor:[UIColor greenColor]];
                }
                else{
                    [self.buttonD setBackgroundColor:[UIColor redColor]];
                    if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonB setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonC setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                        [self.buttonA setBackgroundColor:[UIColor greenColor]];
                    }
                }
                
            }
        }

    }
}

- (IBAction)nextAction:(id)sender {
    if(_myflag < [self.result count] - 1){
        [self mySwipeRight];
        
        
//        CGRect myview = self.view.frame;
//        myview.origin.x = - myview.size.width;
        
        
        if([[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]] || [[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"]  isEqual: @"ab"]){
            NSLog(@"Please Select an option");
            [self showAlert];
            self.swipeLeftGreen.enabled = NO;
        }
        else{
            [self performAnimation];
            self.swipeLeftGreen.enabled = YES;
            [self enableButtons];
            [self.buttonA setBackgroundColor:[UIColor whiteColor]];
            [self.buttonB setBackgroundColor:[UIColor whiteColor]];
            [self.buttonC setBackgroundColor:[UIColor whiteColor]];
            [self.buttonD setBackgroundColor:[UIColor whiteColor]];
            
            self.myflag++;
            self.optionA.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option1"];
            self.optionB.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option2"];
            self.optionC.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option3"];
            self.optionD.text = [[self.result objectAtIndex:_myflag] valueForKey:@"option4"];
            
            self.questionNo.text = [NSString stringWithFormat:@"Question No. %d",self.myflag+1];
            if(self.myflag == [self.result count]-1){
                [self.nextButton setEnabled:NO];
                [self.finishButton setHidden:NO];
                [self.nextButton setHidden:YES];
            }
            [self.prevButton setEnabled:YES];
            self.question.text = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
            self.progressBar.progress = (((self.myflag +1) * 100.0)/[self.result count])/100.0;
            
            
            if(![[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]] && ![[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"]  isEqual:@"ab"]){
                NSLog(@"Good working");
                if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == [[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]){
                    if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionA.text){
                        [self.buttonA setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionB.text){
                        [self.buttonB setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionC.text){
                        [self.buttonC setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionD.text){
                        [self.buttonD setBackgroundColor:[UIColor greenColor]];
                    }
                }
                else{
                    if([[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] == self.optionA.text){
                        [self.buttonA setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] == self.optionB.text){
                        [self.buttonB setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] == self.optionC.text){
                        [self.buttonC setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"] == self.optionD.text){
                        [self.buttonD setBackgroundColor:[UIColor greenColor]];
                    }
                    if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionA.text){
                        [self.buttonA setBackgroundColor:[UIColor redColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionB.text){
                        [self.buttonB setBackgroundColor:[UIColor redColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionC.text){
                        [self.buttonC setBackgroundColor:[UIColor redColor]];
                    }
                    else if([[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] == self.optionD.text){
                        [self.buttonD setBackgroundColor:[UIColor redColor]];
                    }
                }
                [self disableButtons];
            }
            
            
        }
    }
    else{
        _swipeLeftGreen = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(finishAction:)];
        _swipeLeftGreen.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:_swipeLeftGreen];
    }
}
-(void)myAction:(UIButton *)sender{
    [self clearColor];
    [self disableButtons];
    [self.swipeLeftGreen setEnabled:YES];
    NSLog(@"%@",sender.titleLabel.text);
    if([sender.titleLabel.text isEqualToString:@"A"]){
        [sender setBackgroundColor:[UIColor redColor]];
        //    NSLog(@"You are at index %d",self.myflag);
        if([[[self.result objectAtIndex:_myflag] valueForKey:@"option1"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
            [sender setBackgroundColor:[UIColor greenColor]];
        }
        else{
//            NSLog(@"%@",self.optionA.titleLabel.text);
            [sender setBackgroundColor:[UIColor redColor]];
            if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonB setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonC setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonD setBackgroundColor:[UIColor greenColor]];
            }
        }
        NSString *tmpStr = [[self.result objectAtIndex:_myflag] valueForKey:@"option1"];
        NSString *tmpQuestion = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
        BOOL success = [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = '%@' WHERE question = '%@'",self.tableName,tmpStr,tmpQuestion];
        if(success){
            NSLog(@"Check DB");
        }
        _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    }
    else if([sender.titleLabel.text isEqualToString:@"B"]){
        [sender setBackgroundColor:[UIColor redColor]];
        
        if([[[self.result objectAtIndex:_myflag] valueForKey:@"option2"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
            [sender setBackgroundColor:[UIColor greenColor]];
        }
        else{
            //            NSLog(@"%@",self.optionA.titleLabel.text);
            [sender setBackgroundColor:[UIColor redColor]];
            if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonA setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonC setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonD setBackgroundColor:[UIColor greenColor]];
            }
        }
        
        //    NSLog(@"You are at index %d",self.myflag);
        NSString *tmpStr = [[self.result objectAtIndex:_myflag] valueForKey:@"option2"];
        NSString *tmpQuestion = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
        BOOL success = [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = '%@' WHERE question = '%@'",self.tableName,tmpStr,tmpQuestion];
        if(success){
            NSLog(@"Check DB");
        }
        _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    }
    else if([sender.titleLabel.text isEqualToString:@"C"]){
        [sender setBackgroundColor:[UIColor redColor]];
        
        if([[[self.result objectAtIndex:_myflag] valueForKey:@"option3"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
            [sender setBackgroundColor:[UIColor greenColor]];
        }
        else{
            //            NSLog(@"%@",self.optionA.titleLabel.text);
            [sender setBackgroundColor:[UIColor redColor]];
            if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonA setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonB setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionD.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonD setBackgroundColor:[UIColor greenColor]];
            }
        }
        
        //    NSLog(@"You are at index %d",self.myflag);
        NSString *tmpStr = [[self.result objectAtIndex:_myflag] valueForKey:@"option3"];
        NSString *tmpQuestion = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
        BOOL success = [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = '%@' WHERE question = '%@'",self.tableName,tmpStr,tmpQuestion];
        if(success){
            NSLog(@"Check DB");
        }
        _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    }
    else if([sender.titleLabel.text isEqualToString:@"D"]){
        [sender setBackgroundColor:[UIColor redColor]];
        if([[[self.result objectAtIndex:_myflag] valueForKey:@"option4"] isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
            [sender setBackgroundColor:[UIColor greenColor]];
        }
        else{
            //            NSLog(@"%@",self.optionA.titleLabel.text);
            [sender setBackgroundColor:[UIColor redColor]];
            if([self.optionA.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonA setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionC.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonC setBackgroundColor:[UIColor greenColor]];
            }
            if([self.optionB.text isEqualToString:[[self.result objectAtIndex:_myflag] valueForKey:@"trueAnswer"]]){
                [self.buttonB setBackgroundColor:[UIColor greenColor]];
            }
        }
        //    NSLog(@"You are at index %d",self.myflag);
        NSString *tmpStr = [[self.result objectAtIndex:_myflag] valueForKey:@"option4"];
        NSString *tmpQuestion = [[self.result objectAtIndex:_myflag] valueForKey:@"question"];
        BOOL success = [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = '%@' WHERE question = '%@'",self.tableName,tmpStr,tmpQuestion];
        if(success){
            NSLog(@"Check DB");
        }
        _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    }
}
-(void)clearColor{
    [self.buttonA setBackgroundColor:[UIColor whiteColor]];
    [self.buttonB setBackgroundColor:[UIColor whiteColor]];
    [self.buttonC setBackgroundColor:[UIColor whiteColor]];
    [self.buttonD setBackgroundColor:[UIColor whiteColor]];
}
-(void)disableButtons{
    [self.buttonA setEnabled:NO];
    [self.buttonB setEnabled:NO];
    [self.buttonC setEnabled:NO];
    [self.buttonD setEnabled:NO];
}
-(void)enableButtons{
    [self.buttonA setEnabled:YES];
    [self.buttonB setEnabled:YES];
    [self.buttonC setEnabled:YES];
    [self.buttonD setEnabled:YES];
}

- (IBAction)finishAction:(id)sender {
    if([[[self.result objectAtIndex:[_result count]-1] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]] || [[[self.result objectAtIndex:_myflag] valueForKey:@"useranswer"] isEqualToString:@"ab"]){
        [self showAlert];
    }
    else{
        [self performSegueWithIdentifier:@"finish" sender:self];
    }
}

- (IBAction)pauseAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:self.myflag] forKey:@"pausedState"];
    [[NSUserDefaults standardUserDefaults] setObject:self.tableName forKey:@"pausedTableName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSInteger ab = [[NSUserDefaults standardUserDefaults] integerForKey:@"pausedState"];
//    NSLog(@"%ld",(long)ab);
//    self.myflag = (int)ab;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}
-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please select an option" message:@"Questions can't be leave empty" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)mySwipeRight{
    _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(prevAction:)];
    _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipeRight];
}
-(void)mySwipeLeft{
    _swipeLeftGreen = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction:)];
    _swipeLeftGreen.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_swipeLeftGreen];
//    self.swipeLeftGreen.enabled = NO;
}
-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"Working");
    }];
}
-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"Working");
    }];
}
-(void)performAnimation{
    self.swipeLeftGreen.enabled = NO;
    CGRect questionNoFrame = self.questionNo.frame;
    questionNoFrame.origin.x = - questionNoFrame.size.width;
    
    CGRect questionFrame = self.question.frame;
    questionFrame.origin.x = - questionFrame.size.width;
    
    CGRect optionAFrame = self.optionA.frame;
    optionAFrame.origin.x = - optionAFrame.size.width;
    CGRect optionBFrame = self.optionB.frame;
    optionBFrame.origin.x = - optionBFrame.size.width;
    CGRect optionCFrame = self.optionC.frame;
    optionCFrame.origin.x = - optionCFrame.size.width;
    CGRect optionDFrame = self.optionD.frame;
    optionDFrame.origin.x = - optionDFrame.size.width;
    
    
    
    CGRect buttonAFrame = self.buttonA.frame;
    buttonAFrame.origin.x = - buttonAFrame.size.width - 200;
    
    CGRect buttonBFrame = self.buttonB.frame;
    buttonBFrame.origin.x = - buttonBFrame.size.width - 200;
    CGRect buttonCFrame = self.buttonC.frame;
    buttonCFrame.origin.x = - buttonCFrame.size.width - 200;
    CGRect buttonDFrame = self.buttonD.frame;
    buttonDFrame.origin.x = - buttonDFrame.size.width - 200;
    
    CGRect prevFrame = self.prevButton.frame;
    prevFrame.origin.x = -prevFrame.size.width;
    
    CGRect nextFrame = self.nextButton.frame;
    nextFrame.origin.x = - nextFrame.size.width;
    
    CGRect finishFrame = self.finishButton.frame;
    finishFrame.origin.x = -finishFrame.size.width;
    CGRect progressBarFrame = self.progressBar.frame;
    progressBarFrame.origin.x = - progressBarFrame.size.width;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //        self.view.frame = myview;
    //        self.question.frame = basketTopFrame;
    self.questionNo.frame = questionNoFrame;
    self.question.frame = questionFrame;
    self.optionA.frame = optionAFrame;
    self.optionB.frame = optionBFrame;
    self.optionC.frame = optionCFrame;
    self.optionD.frame = optionDFrame;
    self.buttonA.frame = buttonAFrame;
    self.buttonB.frame = buttonBFrame;
    self.buttonC.frame = buttonCFrame;
    self.buttonD.frame = buttonDFrame;
//    self.progressBar.frame = progressBarFrame;
    
    //        self.basketBottom.frame = basketBottomFrame;
    
    [UIView commitAnimations];
}
-(void)performRightAnimation{
    CGRect questionNoFrame = self.questionNo.frame;
    questionNoFrame.origin.x = + questionNoFrame.size.width;
    
    CGRect questionFrame = self.question.frame;
    questionFrame.origin.x = + questionFrame.size.width;
    
    CGRect optionAFrame = self.optionA.frame;
    optionAFrame.origin.x = +optionAFrame.size.width;
    CGRect optionBFrame = self.optionB.frame;
    optionBFrame.origin.x = + optionBFrame.size.width;
    CGRect optionCFrame = self.optionC.frame;
    optionCFrame.origin.x = + optionCFrame.size.width;
    CGRect optionDFrame = self.optionD.frame;
    optionDFrame.origin.x = + optionDFrame.size.width;
    
    
    
    CGRect buttonAFrame = self.buttonA.frame;
    buttonAFrame.origin.x = + buttonAFrame.size.width + 200;
    
    CGRect buttonBFrame = self.buttonB.frame;
    buttonBFrame.origin.x = + buttonBFrame.size.width + 200;
    CGRect buttonCFrame = self.buttonC.frame;
    buttonCFrame.origin.x = + buttonCFrame.size.width + 200;
    CGRect buttonDFrame = self.buttonD.frame;
    buttonDFrame.origin.x = + buttonDFrame.size.width + 200;
    
    CGRect prevFrame = self.prevButton.frame;
    prevFrame.origin.x = +prevFrame.size.width;
    
    CGRect nextFrame = self.nextButton.frame;
    nextFrame.origin.x = + nextFrame.size.width;
    
    CGRect finishFrame = self.finishButton.frame;
    finishFrame.origin.x = +finishFrame.size.width;
    CGRect progressBarFrame = self.progressBar.frame;
    progressBarFrame.origin.x = + progressBarFrame.size.width;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //        self.view.frame = myview;
    //        self.question.frame = basketTopFrame;
    self.questionNo.frame = questionNoFrame;
    self.question.frame = questionFrame;
    self.optionA.frame = optionAFrame;
    self.optionB.frame = optionBFrame;
    self.optionC.frame = optionCFrame;
    self.optionD.frame = optionDFrame;
    self.buttonA.frame = buttonAFrame;
    self.buttonB.frame = buttonBFrame;
    self.buttonC.frame = buttonCFrame;
    self.buttonD.frame = buttonDFrame;
//    self.prevButton.frame = prevFrame;
    //    self.progressBar.frame = progressBarFrame;
    
    //        self.basketBottom.frame = basketBottomFrame;
    
    [UIView commitAnimations];

}
@end
