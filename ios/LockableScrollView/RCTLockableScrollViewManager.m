#import "RCTLockableScrollViewManager.h"
#import "RCTLockableScrollView.h"
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>

@implementation RCTLockableScrollViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

- (UIView *)view
{
  return [[RCTLockableScrollView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

@end
