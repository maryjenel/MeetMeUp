//
//  Topic.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "Topic.h"

@implementation Topic

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.name = dictionary[@"name"];
    return self;
}

@end
