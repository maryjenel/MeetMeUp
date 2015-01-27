//
//  Member.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "Member.h"
#import "Topic.h"
@interface Member()
@property NSURL *imageURL;
@end
@implementation Member

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.memberName = dictionary[@"name"];
    self.city = dictionary[@"city"];
    self.memberID = dictionary[@"id"];
    self.imageURL = [NSURL URLWithString:dictionary[@"photo"][@"highres_link"]];
    return self;
}

-(instancetype)initWithCommentDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.memberName = dictionary[@"member_name"];
    self.memberID = dictionary[@"member_id"];
    return self;
}
+(void)retrieveMember:(NSString *)memberID WithCompletion:(void (^)(Member *member))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=36553019493c24413411974397e650",memberID]];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:addressRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *memberDict;
        memberDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSMutableArray *tempArray = [NSMutableArray new];
        Member *member = [[Member alloc]initWithDictionary:memberDict];
        member.topicsArray = [NSMutableArray new];
        NSArray *topicArray = memberDict[@"topics"];
        for (NSDictionary *d in topicArray)
        {
            Topic *topic = [[Topic alloc]initWithDictionary:d];
            [member.topicsArray addObject:topic];
        }

        [tempArray addObject:member];
        complete(member);
    }];
}
-(void)getImageWithCompletion:(void (^)(NSData *imageData))complete //method not a class method
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.imageURL]queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        complete(data);
    }];

}
@end
