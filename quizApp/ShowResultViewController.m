//
//  ShowResultViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 04/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ShowResultViewController.h"
#import "SCSQLite.h"
#import "ShowResultTableViewCell.h"

@interface ShowResultViewController ()
@property (nonatomic,strong) NSArray *result;
@end

@implementation ShowResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    _result = [[NSArray alloc] init];
    _result = [SCSQLite selectRowSQL:@"SELECT * FROM %@",self.tableName];
    NSLog(@"%@",_result);
    int j = 0;
    for(int i =0 ;i< [_result count];i++){
        if(![[[self.result objectAtIndex:i] valueForKey:@"useranswer"] isKindOfClass:[NSNull class]]){
            if([[[self.result objectAtIndex:i] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:i] valueForKey:@"trueAnswer"]]){
                j++;
            }
        }
    }
//    NSLog(@"Your Score is %d",j);
    self.scoreLabel.text = [NSString stringWithFormat:@"Your Score is %d",j];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_result count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"cell"];
    ShowResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[ShowResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.questionNo.text = [NSString stringWithFormat:@"Question No. %ld",indexPath.row + 1];
    cell.question.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"question"];
    cell.option1.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"option1"];
    cell.option2.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"option2"];
    cell.option3.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"option3"];
    cell.option4.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"option4"];
    [cell.option1 setBackgroundColor:[UIColor whiteColor]];
    [cell.option2 setBackgroundColor:[UIColor whiteColor]];
    [cell.option3 setBackgroundColor:[UIColor whiteColor]];
    [cell.option4 setBackgroundColor:[UIColor whiteColor]];
    if([[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"] isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"trueAnswer"]]){
        if([cell.option1.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option1 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option2.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option2 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option3.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option3 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option4.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option4 setBackgroundColor:[UIColor greenColor]];
        }
    }
    else{
        if([cell.option1.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"trueAnswer"]]){
            [cell.option1 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option2.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"trueAnswer"]]){
            [cell.option2 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option3.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"trueAnswer"]]){
            [cell.option3 setBackgroundColor:[UIColor greenColor]];
        }
        else if([cell.option4.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"trueAnswer"]]){
            [cell.option4 setBackgroundColor:[UIColor greenColor]];
        }
        if([cell.option1.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option1 setBackgroundColor:[UIColor redColor]];
        }
        else if([cell.option2.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option2 setBackgroundColor:[UIColor redColor]];
        }
        else if([cell.option3.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option3 setBackgroundColor:[UIColor redColor]];
        }
        else if([cell.option4.text isEqualToString:[[self.result objectAtIndex:indexPath.row] valueForKey:@"useranswer"]]){
            [cell.option4 setBackgroundColor:[UIColor redColor]];
        }
        
    }
    return cell;
}
- (IBAction)popToMain:(id)sender {
    NSString *tmpStr = self.scoreLabel.text;
    NSArray *tmpFoo = [tmpStr componentsSeparatedByString:@" "];
    int a = [[tmpFoo objectAtIndex:3] intValue];
    NSLog(@"%d",a);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",string);
    
    [SCSQLite executeSQL:@"INSERT INTO score (score,scorreddate) VALUES('%d','%@')",a,string];
//    NSArray *tmp = [SCSQLite selectRowSQL:@"SELECT * FROM score"];
    [SCSQLite executeSQL:@"UPDATE %@ SET useranswer = 'ab'",self.tableName];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"pausedState"];
    [[NSUserDefaults standardUserDefaults] setObject:NULL forKey:@"pausedTableName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
