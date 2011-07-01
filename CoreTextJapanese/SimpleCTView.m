//
//  SimpleCTView.m
//  CoreTextJapanese
//
//  Created by ito on 平成23/06/29.
//  Copyright 23 __MyCompanyName__. All rights reserved.
//

#import "SimpleCTView.h"


@implementation SimpleCTView

@synthesize text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setText:(NSString *)aText
{
	if (text != aText) {
		text = [aText retain];
	}
	
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	
	CTParagraphStyleSetting setting[10];
	CGFloat floatValue[10];
	
	floatValue[0] = 0.0; // Deprecated (see header file)
	floatValue[1] = 0.0;
	floatValue[2] = 0.0;
	floatValue[3] = 0.0;
	floatValue[4] = 5.0; // Line spacing (必要に応じて行間調整)
	floatValue[5] = floatValue[4]; // Same as kCTParagraphStyleSpecifierMinimumLineSpacing
	
	setting[0].spec = kCTParagraphStyleSpecifierLineSpacing; // Deprecated (see header file)
	setting[0].valueSize = sizeof(CGFloat);
	setting[0].value = &floatValue[0];
	
	setting[1].spec = kCTParagraphStyleSpecifierParagraphSpacing;
	setting[1].valueSize = sizeof(CGFloat);
	setting[1].value = &floatValue[1];
	
	setting[2].spec = kCTParagraphStyleSpecifierMaximumLineHeight;
	setting[2].valueSize = sizeof(CGFloat);
	setting[2].value = &floatValue[2];
	
	setting[3].spec = kCTParagraphStyleSpecifierMinimumLineHeight;
	setting[3].valueSize = sizeof(CGFloat);
	setting[3].value = &floatValue[3];
	
	setting[4].spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
	setting[4].valueSize = sizeof(CGFloat);
	setting[4].value = &floatValue[4];
	
	setting[5].spec = kCTParagraphStyleSpecifierMaximumLineSpacing;
	setting[5].valueSize = sizeof(CGFloat);
	setting[5].value = &floatValue[5];
	
	
	CTParagraphStyleRef para = CTParagraphStyleCreate(setting, 6);
	

	NSMutableDictionary* attr = [NSMutableDictionary dictionaryWithCapacity:5];
	
	CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 36.0f, NULL);
	[attr setObject:(id)font forKey:(id)kCTFontAttributeName];
	
	//
	[attr setObject:(id)para forKey:(id)kCTParagraphStyleAttributeName];
	//
	
	CFRelease(font);
	CFRelease(para);
	 
	CFAttributedStringRef attrString = CFAttributedStringCreate(NULL, (CFStringRef)self.text, (CFDictionaryRef)attr);
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
	
	CGPathRef framePath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
	CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, CFAttributedStringGetLength(attrString)), framePath, NULL);
	
	CGContextRef context = UIGraphicsGetCurrentContext();	
	
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGContextSaveGState(context);
	CTFrameDraw(frame, context);
	CGContextRestoreGState(context);
	
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextSetTextPosition(context, 0, 0);

#if 0
	// Draw line bounds
	NSArray* lines = (id)CTFrameGetLines(frame);
	NSUInteger lineIndex = 0;
	for (id obj in lines) {
		CTLineRef line = (CTLineRef)obj;
		[[UIColor blueColor] setStroke];
		
		
		CGContextSaveGState(context);
		CGPoint p;
		CTFrameGetLineOrigins(frame, CFRangeMake(lineIndex, 1), &p);
		CGContextTranslateCTM(context, p.x, p.y);
		CGRect lineBounds = CTLineGetImageBounds(line, context);
		//CGContextStrokeRect(context, lineBounds);
		float ascent = 0;
		float descent = 0;
		float leading = 0;
		float size = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
		
		CGContextTranslateCTM(context, lineBounds.origin.x, lineBounds.origin.y);
		
		NSLog(@"line: %@ - %@, a:%f, d:%f, l:%f, w:%f", CFStringCreateWithSubstring(NULL, self.text, CTLineGetStringRange(line)), NSStringFromCGRect(CTLineGetImageBounds(line, context)),
			  ascent, descent, leading, size);
		
		
		/*CGContextMoveToPoint(context, 0, 0);
		CGContextAddLineToPoint(context, size, 0);
		[[UIColor blackColor] setStroke];
		CGContextStrokePath(context);
		*/
		/*
		 // これ正しくないので注意
		CGContextMoveToPoint(context, 0, ascent);
		CGContextAddLineToPoint(context, size, ascent);
		[[UIColor redColor] setStroke];
		CGContextStrokePath(context);
		
		CGContextMoveToPoint(context, 0, descent);
		CGContextAddLineToPoint(context, size, descent);
		[[UIColor greenColor] setStroke];
		CGContextStrokePath(context);
		
		CGContextMoveToPoint(context, 0, -leading);
		CGContextAddLineToPoint(context, size, -leading);
		[[UIColor yellowColor] setStroke];
		CGContextStrokePath(context);
		 */ 
		
		CGContextRestoreGState(context);

		CGContextSaveGState(context);
		CGContextTranslateCTM(context, p.x, p.y);
		NSArray* runs = (id)CTLineGetGlyphRuns(line);
		for (id obj in runs) {
			CTRunRef run = obj;
			NSLog(@"\t+run:%@, %@, %@", CFStringCreateWithSubstring(NULL, self.text, CTRunGetStringRange(run)), NSStringFromCGRect(CTRunGetImageBounds(run, context, CFRangeMake(0, 0))),
				  NSStringFromCGAffineTransform(CTRunGetTextMatrix(run)) );
			[[UIColor blueColor] setStroke];
			CGContextStrokeRect(context, CTRunGetImageBounds(run, context, CFRangeMake(0, 0)) );
		}
		CGContextRestoreGState(context);
		
		lineIndex ++;
	}
	
#endif
	
	CFRelease(frame);
	CFRelease(framesetter);
	CFRelease(attrString);
}


@end
