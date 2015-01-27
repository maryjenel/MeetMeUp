//
//  Events.h
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Events : NSObject

@property NSString *name;
@property NSString *address;
@property NSString *rsvpCount;
@property NSString *groupInfo;
@property NSString *link;
@property NSString *eventsID;
@property NSString *eventDescription;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)retrieveEventsWithCompletion:(void (^)(NSArray *events))complete;
@end
