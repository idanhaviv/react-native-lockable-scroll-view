#import <React/RCTScrollView.h>

@interface RNLockedScrollView : RCTScrollView

@property (nonatomic, readonly) UIScrollView *scrollView;
- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated;

@end
