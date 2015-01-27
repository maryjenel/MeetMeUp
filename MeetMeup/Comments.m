//
//  Comments.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "Comments.h"
@interface Comments()
@end
@implementation Comments





-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.time = dictionary[@"time"];
    self.comment = dictionary[@"comment"];

    return self;
}
+(void)retrieveComments:(NSString *)eventID WithCompletion:(void (^)(NSArray *comments))complete
{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=36553019493c24413411974397e650",eventID]];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:addressRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
     NSDictionary *commentsDict;
        commentsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSArray *jsonArray = commentsDict[@"results"];
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSDictionary *d in jsonArray)
        {
            Comments *comments = [[Comments alloc]initWithDictionary:d];
            Member *member = [[Member alloc]initWithCommentDictionary:d];
            comments.member = member;
            [tempArray addObject:comments];
        }
        complete(tempArray);
    }];


}


//     {
//         NSDictionary *commentDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]; // grabbing the dictionary
//         self.commentsDictionary = [commentDictionary objectForKey:@"results"]; //putting the dictionary into an array
//
//         for (NSDictionary *commentDict in self.commentsDictionary)
//         {
//             Comments *newComments = [Comments new];
//             //name
//             NSString *time = [commentDict objectForKey:@"time"];
//             newComments.time = time;
//             //address
//             NSString *comment = [commentDict objectForKey:@"comment"];
//             newComments.comment = comment;
//             //rsvp count
//             NSString *memberName =[commentDict objectForKey:@"member_name"];
//             newComments.memberName = memberName;
//             //group name
//             NSString *memberID = [commentDict objectForKey:@"member_id"];
//             newComments.memberID = memberID;
//
//
//             [self.commentsArray addObject:newComments]; // adding all the objects to the array
//         }
//         [self.commentTableView reloadData];
//     }];
//}
@end
