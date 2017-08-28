#import <UIKit/UIKit.h>

@interface RCScrollView : UIScrollView

@property BOOL enabled;
- (void)didAddSubview:(UIView *)subview;
- (void)willRemoveSubview:(UIView *)subview;

@end