//
//  Events.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "Events.h"

@implementation Events


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.name = dictionary[@"name"];
    self.address = dictionary[@"venue"][@"address_1"];
    self.rsvpCount = dictionary[@"yes_rsvp_count"];
    self.groupInfo = dictionary[@"group"][@"name"];
    self.eventDescription = dictionary[@"description"];
    self.link = dictionary[@"event_url"];
    self.eventsID = dictionary[@"id"];
    return self;

}
+(void)retrieveEventsWithCompletion:(void (^)(NSArray *events))complete
{
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=36553019493c24413411974397e650"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary *events;
         events = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
         NSArray *jsonArray = events[@"results"];
         NSMutableArray *tempArray = [NSMutableArray new];
         for (NSDictionary *dict in jsonArray)
         {
             Events *events = [[Events alloc]initWithDictionary:dict];
             [tempArray addObject:events];
         }
         complete(tempArray);

     }];


}




@end
