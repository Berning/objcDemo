//
//  application.h
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

//application 小记  line 105~194

#ifndef application_h
#define application_h
NS_CLASS_AVAILABLE_IOS(2_0) @interface UIApplication : UIResponder

#if UIKIT_DEFINE_AS_PROPERTIES
@property(class, nonatomic, readonly) UIApplication *sharedApplication NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
#else
+ (UIApplication *)sharedApplication NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
#endif

@property(nullable, nonatomic, assign) id<UIApplicationDelegate> delegate;

- (void)beginIgnoringInteractionEvents NS_EXTENSION_UNAVAILABLE_IOS("");               // nested. set should be set during animations & transitions to ignore touch and other events
- (void)endIgnoringInteractionEvents NS_EXTENSION_UNAVAILABLE_IOS("");
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly, getter=isIgnoringInteractionEvents) BOOL ignoringInteractionEvents;                  // returns YES if we are at least one deep in ignoring events
#else
- (BOOL)isIgnoringInteractionEvents;                  // returns YES if we are at least one deep in ignoring events
#endif

@property(nonatomic,getter=isIdleTimerDisabled)       BOOL idleTimerDisabled;	  // default is NO

- (BOOL)openURL:(NSURL*)url NS_DEPRECATED_IOS(2_0, 10_0, "Please use openURL:options:completionHandler: instead") NS_EXTENSION_UNAVAILABLE_IOS("");
- (BOOL)canOpenURL:(NSURL *)url NS_AVAILABLE_IOS(3_0);

// Options are specified in the section below for openURL options. An empty options dictionary will result in the same
// behavior as the older openURL call, aside from the fact that this is asynchronous and calls the completion handler rather
// than returning a result.
// The completion handler is called on the main queue.
- (void)openURL:(NSURL*)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion NS_AVAILABLE_IOS(10_0) NS_EXTENSION_UNAVAILABLE_IOS("");

- (void)sendEvent:(UIEvent *)event;

@property(nullable, nonatomic,readonly) UIWindow *keyWindow;
@property(nonatomic,readonly) NSArray<__kindof UIWindow *>  *windows;

- (BOOL)sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event;

@property(nonatomic,getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible __TVOS_PROHIBITED; // showing network spinning gear in status bar. default is NO

@property(readonly, nonatomic) UIStatusBarStyle statusBarStyle __TVOS_PROHIBITED; // default is UIStatusBarStyleDefault

@property(readonly, nonatomic,getter=isStatusBarHidden) BOOL statusBarHidden __TVOS_PROHIBITED;

@property(readonly, nonatomic) UIInterfaceOrientation statusBarOrientation __TVOS_PROHIBITED;

// The system only calls this method if the application delegate has not
// implemented the delegate equivalent. It returns the orientations specified by
// the application's info.plist. If no supported interface orientations were
// specified it will return UIInterfaceOrientationMaskAll on an iPad and
// UIInterfaceOrientationMaskAllButUpsideDown on a phone.  The return value
// should be one of the UIInterfaceOrientationMask values which indicates the
// orientations supported by this application.
- (UIInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;

@property(nonatomic,readonly) NSTimeInterval statusBarOrientationAnimationDuration __TVOS_PROHIBITED; // Returns the animation duration for the status bar during a 90 degree orientation change.  It should be doubled for a 180 degree orientation change.
@property(nonatomic,readonly) CGRect statusBarFrame __TVOS_PROHIBITED; // returns CGRectZero if the status bar is hidden

@property(nonatomic) NSInteger applicationIconBadgeNumber;  // set to 0 to hide. default is 0. In iOS 8.0 and later, your application must register for user notifications using -[UIApplication registerUserNotificationSettings:] before being able to set the icon badge.

@property(nonatomic) BOOL applicationSupportsShakeToEdit NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

@property(nonatomic,readonly) UIApplicationState applicationState NS_AVAILABLE_IOS(4_0);
@property(nonatomic,readonly) NSTimeInterval backgroundTimeRemaining NS_AVAILABLE_IOS(4_0);

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void(^ __nullable)(void))handler  NS_AVAILABLE_IOS(4_0) NS_REQUIRES_SUPER;
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(nullable NSString *)taskName expirationHandler:(void(^ __nullable)(void))handler NS_AVAILABLE_IOS(7_0) NS_REQUIRES_SUPER;
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier NS_AVAILABLE_IOS(4_0) NS_REQUIRES_SUPER;

/*! The system guarantees that it will not wake up your application for a background fetch more
 frequently than the interval provided. Set to UIApplicationBackgroundFetchIntervalMinimum to be
 woken as frequently as the system desires, or to UIApplicationBackgroundFetchIntervalNever (the
 default) to never be woken for a background fetch.
 
 This setter will have no effect unless your application has the "fetch"
 UIBackgroundMode. See the UIApplicationDelegate method
 `application:performFetchWithCompletionHandler:` for more. */
- (void)setMinimumBackgroundFetchInterval:(NSTimeInterval)minimumBackgroundFetchInterval NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;

/*! When background refresh is available for an application, it may launched or resumed in the background to handle significant
 location changes, remote notifications, background fetches, etc. Observe UIApplicationBackgroundRefreshStatusDidChangeNotification to
 be notified of changes. */
@property (nonatomic, readonly) UIBackgroundRefreshStatus backgroundRefreshStatus NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;

@property(nonatomic,readonly,getter=isProtectedDataAvailable) BOOL protectedDataAvailable NS_AVAILABLE_IOS(4_0);

@property(nonatomic,readonly) UIUserInterfaceLayoutDirection userInterfaceLayoutDirection NS_AVAILABLE_IOS(5_0);

// Return the size category
@property(nonatomic,readonly) UIContentSizeCategory preferredContentSizeCategory NS_AVAILABLE_IOS(7_0);

@end


#endif /* application_h */
