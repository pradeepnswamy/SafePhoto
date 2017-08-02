//
//  GlobalSelector.h
//  VolumeControl
//
//  Created by Pradeep on 30/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalSelector : NSObject
{

}
@property(nonatomic, strong) NSString *documentPath;
@property(nonatomic, strong) NSString *selectedFolder;

+ (id) sharedInstance;

@end
