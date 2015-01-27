//
//  MemberViewController.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "MemberViewController.h"
#import "Member.h"
#import "Topic.h"


@interface MemberViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UITableView *topicsTableView;
@property (nonatomic)  NSArray *topicsArray;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [Member retrieveMember:self.member.memberID WithCompletion:^(Member *member)
     {
         self.member = member;
         self.name.text = self.member.memberName;
         self.city.text = self.member.city;

         [member getImageWithCompletion:^(NSData *imageData) {
             self.imageView.image = [UIImage imageWithData:imageData];

         }];
         [self.topicsTableView reloadData];
     }];
}

- (void)setTopicsArray:(NSArray *)topicsArray
{
    _topicsArray = topicsArray;
    [self.topicsTableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
    Topic *topic = [self.member.topicsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = topic.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.member.topicsArray.count;
}
@end
