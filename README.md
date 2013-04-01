# BKDoodleView

BKDoodleView is a drawing view for iOS applications. You can change the color, opacity, and size of the brush.

## Adding BKDoodleView to your project

You can directly add the `BKDoodleView.h` and `BKDoodleView.m` source files to your project.

1. Download the latest code version or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, than drag and drop `BKDoodleView.h` and `BKDoodleView.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include BKDoodleView wherever you need it with `#import "BKDoodleView.h"`.

## Using BKDoodleView

#### Creating a DoodleView

You can create a BKDoodleView in the following ways:

```objective-c
+ (id)doodleView;
+ (id)doodleViewWithFrame:(CGRect)frame;
```

#### Configuring a BKDoodleView

```objective-c
//Add a background image to draw on
- (void)setBackgroundImage:(UIImage*)backgroundImage contentMode:(UIViewContentMode)contentMode;
```

```objective-c
//Set RGBA values
- (void)setRed:(CGFloat)red blue:(CGFloat)blue green:(CGFloat)green alpha:(CGFloat)alpha;
```

```objective-c
//Set brush size
- (void)setBrushSize:(CGFloat)size;
```

```objective-c
//Set frame
- (void)setFrame:(CGRect)frame;
```
## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 

## Change-log

**Version 0.1** @ 4/1/13

- Initial release