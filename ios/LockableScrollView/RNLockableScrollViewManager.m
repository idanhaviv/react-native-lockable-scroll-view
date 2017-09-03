#import "RNLockableScrollViewManager.h"
#import "RNLockableScrollView.h"
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>

@implementation RNLockableScrollViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[RNLockableScrollView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

@end
