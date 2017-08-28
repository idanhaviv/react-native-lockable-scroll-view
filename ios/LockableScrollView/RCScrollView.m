#import "RCScrollView.h"

@implementation RCScrollView

- (void)didAddSubview:(UIView *)subview {
//   CGFloat verticalOffset = [self requiredScrollUpdateForAddedSubview:subview];
//   if (verticalOffset > 0) {
//     [self setContentOffset: CGPointMake(self.contentOffset.x, self.contentOffset.y + verticalOffset)];
//   }
}

- (CGFloat)requiredScrollUpdateForAddedSubview:(UIView *)addedView {
  BOOL viewExceedsTopViewPort = addedView.frame.origin.y < self.contentOffset.y;
  BOOL viewIsAddedToTopOfNonScrolledList = self.subviews.count > 3 && addedView.frame.origin.y == 0; //2 subviews are the scrolling indicators
  if  (viewExceedsTopViewPort || viewIsAddedToTopOfNonScrolledList) {
    return addedView.frame.size.height;
  }
  
  return 0;
}

- (void)willRemoveSubview:(UIView *)subview {
//   if (subview.frame.origin.y < self.contentOffset.y - 0.0001) {
//     [self setContentOffset: CGPointMake(self.contentOffset.x, self.contentOffset.y - subview.frame.size.height)];
//   }
}

@end