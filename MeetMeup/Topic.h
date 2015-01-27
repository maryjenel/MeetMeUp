//
//  Topic.h
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property NSString *name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
