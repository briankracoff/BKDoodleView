// BKDoodleView.m
//
// Copyright (c) 2013 Brian Kracoff (http://www.kracoff.org)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "BKDoodleView.h"

@interface BKDoodleView ()

@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;
@property (nonatomic) CGFloat alpha;
@property (nonatomic) CGFloat brushSize;
@property (nonatomic) BOOL mouseSwiped;

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *tempDrawImageView;

- (void)setDefaults;

@end

@implementation BKDoodleView

+ (id)doodleView
{
    return [[BKDoodleView alloc] init];
}

+ (id)doodleViewWithFrame:(CGRect)frame
{
    return [[BKDoodleView alloc] initWithFrame:frame];
}

- (id)init
{
    if(self = [super init]){
        [self setDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setDefaults];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.backgroundImageView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.backgroundImageView];
    
    UIGraphicsBeginImageContext(self.backgroundImageView.frame.size);
    [self.tempDrawImageView.image drawInRect:CGRectMake(0, 0, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushSize );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImageView setAlpha:self.alpha];
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!self.mouseSwiped){
        UIGraphicsBeginImageContext(self.backgroundImageView.frame.size);
        [self.tempDrawImageView.image drawInRect:CGRectMake(0, 0, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushSize);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.alpha);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.backgroundImageView.frame.size);
    [self.backgroundImageView.image drawInRect:CGRectMake(0, 0, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImageView.image drawInRect:CGRectMake(0, 0, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height) blendMode:kCGBlendModeNormal alpha:self.alpha];
    self.backgroundImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImageView.image = nil;
    UIGraphicsEndImageContext();
}

- (void)setRed:(CGFloat)red blue:(CGFloat)blue green:(CGFloat)green alpha:(CGFloat)alpha
{
    _red = red;
    _blue = blue;
    _green = green;
    _alpha = alpha;
}

- (void)setBrushSize:(CGFloat)size
{
    _brushSize = size;
}

- (void)setBackgroundImage:(UIImage*)backgroundImage contentMode:(UIViewContentMode)contentMode
{
    _backgroundImageView.contentMode = contentMode;
    _backgroundImageView.image = backgroundImage;
}

#pragma mark - ()
- (void)setDefaults
{
    //Starts with a brush size of medium and black color
    _red = 0.0/255.0;
    _green = 0.0/255.0;
    _blue = 0.0/255.0;
    _alpha = 1.0;
    _brushSize = BKDoodleViewBrushSizeM;
    
    //Inits background image and tempdrawing image
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
    _backgroundImageView.backgroundColor = [UIColor whiteColor];
    _tempDrawImageView = [[UIImageView alloc] initWithFrame:self.frame];
    [self addSubview:_backgroundImageView];
    [self addSubview:_tempDrawImageView];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _backgroundImageView.frame = frame;
    _tempDrawImageView.frame = frame;
}

@end
