//
//  DetailViewController.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "DetailViewController.h"
#import "DestinationViewController.h"
#import "Comments.h"
#import "Events.h"
#import "MemberViewController.h"
#import "Member.h"



@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;


@property (nonatomic)  NSArray *commentsArray;


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.events.name;
    self.groupInfoLabel.text = self.events.address;
    self.rsvpLabel.text = [NSString stringWithFormat:@"RSVP Count: %@", self.events.rsvpCount]; //must add stringwithFormat b/c rsvp count is int.
dispatch_async(dispatch_get_main_queue(), ^ // multithreading.. running different threads at the same time.
    {
    NSAttributedString *formatedHtml = [[NSAttributedString alloc] initWithData:[self.events.eventDescription dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    self.descriptionLabel.attributedText = formatedHtml;

});
    [Comments retrieveComments: self.events.eventsID WithCompletion:^(NSArray *comments) {
        self.commentsArray = comments;
    }];

}


-(void)setCommentsArray:(NSArray *)commentsArray
{
    _commentsArray = commentsArray;
    [self.commentTableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
     {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];

         Comments *currentComments = [self.commentsArray objectAtIndex:indexPath.row];
         cell.textLabel.text = currentComments.member.memberName;
         cell.detailTextLabel.text = currentComments.comment;
         cell.detailTextLabel.numberOfLines = 5;
         return cell;
     }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
     {
         return self.commentsArray.count;
     }


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"webSegue"])
    {
    DestinationViewController *vc = segue.destinationViewController;
    vc.eventWeb = self.events.link;
    }
    else
    {
    MemberViewController *vc = segue.destinationViewController;
    vc.member = [[Member alloc]init];
        NSIndexPath *indexPath = [self.commentTableView indexPathForSelectedRow];
        Comments *comment = [self.commentsArray objectAtIndex:indexPath.row];
        vc.member = comment.member;
    }

}


@end
