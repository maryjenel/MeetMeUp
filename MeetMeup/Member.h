//
//  Member.h
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property NSString *memberName;
@property NSString *city;
@property NSString *topics;
@property NSNumber *memberID;
@property NSMutableArray *topicsArray;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithCommentDictionary:(NSDictionary *)dictionary;

+(void)retrieveMember:(NSString *)memberName WithCompletion:(void (^)(Member *member))complete;
-(void)getImageWithCompletion:(void (^)(NSData *imageData))complete;
@end
