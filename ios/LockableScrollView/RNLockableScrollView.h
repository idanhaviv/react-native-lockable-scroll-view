#import <React/RCTScrollView.h>

@interface RNLockableScrollView : RCTScrollView

//@property (nonatomic, readonly) UIScrollView *scrollView;
//@dynamic scrollView;
- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated;

@end
