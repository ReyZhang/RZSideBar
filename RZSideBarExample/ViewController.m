//
//  ViewController.m
//  RZSideBarExample
//
//  Created by Zhang Rey on 6/19/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import "ViewController.h"
#import "RZSideBar.h"


@interface ViewController () <RZSideBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) RZSideBar *sideBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.sideBar = [[RZSideBar alloc] initWithDirection:SideBarDirectionLeft];
    
    self.sideBar.textLabel.text = @"点击显示结果面板<-";
    self.sideBar.textLabel.font= [UIFont systemFontOfSize:15];
//    self.sideBar.barViewColor = [UIColor]
    
    /////set content view
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];

    
    [self.sideBar setContentViewInSideBar:tableView];
    self.sideBar.delegate = self;
    
    [self.sideBar addInView:self.view];

}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.sideBar layoutWhenRotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark --SideBarDelegate
-(void)sideBar:(RZSideBar *)sideBar didAppear:(BOOL)animated {
    sideBar.textLabel.text = @"点击隐藏结果面板->";
    
}

-(void)sideBar:(RZSideBar *)sideBar didDisappear:(BOOL)animated {
    sideBar.textLabel.text = @"点击显示结果面板<-";
}


#pragma mark --UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark --UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sideBar dismiss];
}


@end
