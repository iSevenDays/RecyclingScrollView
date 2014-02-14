#import <UIKit/UIKit.h>
@interface TopScrollView : UIScrollView<UIScrollViewDelegate>
{
}
@property (weak) IBOutlet UILabel *lblLeftLeft;
@property (weak) IBOutlet UILabel *lblLeft;
@property (weak) IBOutlet UILabel *lblCenter;
@property (weak) IBOutlet UILabel *lblRight;
@property (weak) IBOutlet UILabel *lblRightRight;

@end
