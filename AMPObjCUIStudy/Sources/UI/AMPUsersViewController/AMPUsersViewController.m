//
//  AMPUsersViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersViewController.h"

#import "AMPUsersModel.h"
#import "AMPUser.h"

@interface AMPUsersViewController ()

@end

@implementation AMPUsersViewController

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier =  @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.users userAtIndex:indexPath.row].fullName;
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
