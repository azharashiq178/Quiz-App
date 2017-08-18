//
//  MasterViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 05/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "MasterViewController.h"
#import "Level1ViewController.h"
#import "SCSQLite.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Level1ViewController *controller = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"beginner"]){
        controller.tableName = @"quiz";
        [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = 'ab'",controller.tableName];
    }
    else if ([segue.identifier isEqualToString:@"intermediate"]){
        controller.tableName = @"intermediate";
        [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = 'ab'",controller.tableName];
    }
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return YES;
}
@end
