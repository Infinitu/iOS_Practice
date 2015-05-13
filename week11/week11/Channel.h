//
//  Channel.h
//  week11
//
//  Created by 김창규 on 2015. 5. 13..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import <Realm/Realm.h>

@interface Channel : RLMObject
@property NSString *channelNum;
@property NSString *title;
@property NSString *quality;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Channel>
RLM_ARRAY_TYPE(Channel)
