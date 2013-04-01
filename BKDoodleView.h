// BKDoodleView.h
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

#import <Foundation/Foundation.h>

//Possibly helpful constants for brush size
#define BKDoodleViewBrushSizeS 5
#define BKDoodleViewBrushSizeM 11
#define BKDoodleViewBrushSizeL 25
#define BKDoodleViewBrushSizeXL 49

@interface BKDoodleView : UIView

+ (id)doodleView;
+ (id)doodleViewWithFrame:(CGRect)frame;

//Set the rgba value of the brush
//red, blue and green must be between 0 and 255
//alpha must be between 0 and 1
- (void)setRed:(CGFloat)red blue:(CGFloat)blue green:(CGFloat)green alpha:(CGFloat)alpha;

//Set the size of the brush
- (void)setBrushSize:(CGFloat)size;

//Set the background image for the drawing
- (void)setBackgroundImage:(UIImage*)backgroundImage contentMode:(UIViewContentMode)contentMode;

@end
