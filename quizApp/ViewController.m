//
//  ViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ViewController.h"
#import "Level1ViewController.h"
#import "HCSStarRatingView.h"
@interface ViewController ()

@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated{
    
    NSString *tmp = [[NSUserDefaults standardUserDefaults] valueForKey:@"pausedTableName"];
    if(tmp == NULL){
        [self.resumeButton setEnabled:NO];
    }
    else{
        [self.resumeButton setEnabled:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"resumedState"]){
        Level1ViewController *controller = segue.destinationViewController;
            NSInteger ab = [[NSUserDefaults standardUserDefaults] integerForKey:@"pausedState"];
//            NSLog(@"%ld",(long)ab);
            controller.myflag = (int)ab;
        NSString *tmp = [[NSUserDefaults standardUserDefaults] valueForKey:@"pausedTableName"];
        NSLog(@"%@",tmp);
        controller.tableName = tmp;
//        controller.myflag = 2;
    }
}
- (IBAction)showRating:(id)sender {
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 40, 250, 30)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    //    starRatingView.value = 5;
    starRatingView.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"rate"];
    starRatingView.tintColor = [UIColor redColor];
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Rate us" message:@"Kindly Rate us" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelButton];
    [alert.view addSubview:starRatingView];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:@"rate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
