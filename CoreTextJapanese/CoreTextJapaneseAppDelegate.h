//
//  CoreTextJapaneseAppDelegate.h
//  CoreTextJapanese
//
//  Created by ito on 平成23/06/29.
//  Copyright 23 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreTextJapaneseViewController;

@interface CoreTextJapaneseAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CoreTextJapaneseViewController *viewController;

@end
