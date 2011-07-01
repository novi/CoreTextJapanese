//
//  CoreTextJapaneseViewController.m
//  CoreTextJapanese
//
//  Created by ito on 平成23/06/29.
//  Copyright 23 __MyCompanyName__. All rights reserved.
//

#import "CoreTextJapaneseViewController.h"
#import "SimpleCTView.h"

@implementation CoreTextJapaneseViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	SimpleCTView* view = [[SimpleCTView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:view];
	[view release];
	
	view.text = @"Hello\nWorld g\n漢字123\n感じ\nabcdefg\nHelloWorld g漢字123感じabcdefg";
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
