//
//  Dict.h
//  RecyclingScrollView
//
//  Created by seven on 2/13/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dict : NSObject

- (void)addView:(UIView *)view withName:(NSString *)name;

@property NSMutableArray *strings;
@property NSMutableArray *views;

@end