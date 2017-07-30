//
//  GlobalSelector.m
//  VolumeControl
//
//  Created by Pradeep on 30/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import "GlobalSelector.h"

@implementation GlobalSelector

@synthesize documentPath = _documentPath;

static GlobalSelector *sharedInstance = nil;

+ (GlobalSelector *)sharedInstance {
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[GlobalSelector alloc] init];
    });
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
    }
    
    return self;
}


// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}


@end
