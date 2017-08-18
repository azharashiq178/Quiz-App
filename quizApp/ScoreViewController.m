//
//  ScoreViewController.m
//  quizApp
//
//  Created by Muhammad Azher on 05/07/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ScoreViewController.h"
#import "SCSQLite.h"

@interface ScoreViewController ()
@property (nonatomic,strong) NSArray *result;
@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _result = [[NSArray alloc] init];
    _result = [SCSQLite selectRowSQL:@"SELECT * FROM score"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"score"];
    cell.detailTextLabel.text = [[self.result objectAtIndex:indexPath.row] valueForKey:@"scorreddate"];
    [cell.detailTextLabel setTextColor:[UIColor redColor]];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Score";
}
@end
