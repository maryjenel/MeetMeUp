//
//  ViewController.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "ViewController.h"
#import "Events.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@property (nonatomic)  NSArray *eventsArray;
@property NSArray *resultsArray; //array of dictionaries from the data
@property NSIndexPath *selectedIndexPath;
@property NSString *urlString;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   [Events retrieveEventsWithCompletion:^(NSArray *events)
    {
        self.eventsArray = events;
    }];

}
-(void)setEventsArray:(NSArray *)eventsArray
{
    _eventsArray = eventsArray; //overriding the self.events array
    [self.eventsTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];

    Events *currentEvents = [self.eventsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentEvents.name;
    cell.detailTextLabel.text = currentEvents.address;
    cell.imageView.image = [UIImage imageNamed:@"meetup"];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventsArray.count;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=36553019493c24413411974397e650",searchBar.text];
    self.eventsArray = [NSMutableArray new];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *vc = segue.destinationViewController;
    self.selectedIndexPath = [self.eventsTableView indexPathForSelectedRow];
    vc.events = [self.eventsArray objectAtIndex:self.selectedIndexPath.row];
}

@end
