//
//  Dict.m
//  RecyclingScrollView
//
//  Created by seven on 2/13/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "Dict.h"

@implementation Dict
- (void)addView:(UIView *)view withName:(NSString *)name;
{
  [self.strings addObject:name];
  [self.views addObject:view];
}

- (id)init
{
  self = [super init];
  if(self)
  {
    _strings = [[NSMutableArray alloc] init];
    _views   = [[NSMutableArray alloc] init];
  }
  return self;
}

@end