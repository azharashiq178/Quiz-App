//
//  RateViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 05/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "RateViewController.h"
#import "HCSStarRatingView.h"
@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 40, 250, 30)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:@"rate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
