//
//  ViewsForRecyclingScrollController.h
//  RecyclingScrollView
//
//  Created by seven on 1/20/14.
//  Copyright (c) 2014 none. All rights reserved.
//

@import Foundation;
#import "RecyclingScrollView.h"
@interface TestViewController : UIViewController<RecyclingScrollViewDelegate>
@property (weak) IBOutlet RecyclingScrollView *recyclingScrollView;
@end
