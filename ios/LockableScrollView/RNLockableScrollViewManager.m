#import "RNLockableScrollViewManager.h"
#import "RNLockableScrollView.h"
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>

@implementation RNLockableScrollViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

- (UIView *)view
{
  return [[RNLockableScrollView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

@end
