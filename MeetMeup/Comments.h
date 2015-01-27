//
//  Comments.h
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"
@interface Comments : NSObject

@property NSString *time;
@property NSString *comment;
@property Member *member;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)retrieveComments:(NSString *)eventID WithCompletion:(void (^)(NSArray *comments))complete;

@end
