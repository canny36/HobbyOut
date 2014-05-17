
#import "UIColor+category.h"


@implementation UIColor (UIColor_category) 


+ (UIColor*) colorWithHexString:(NSString*)stringToConvert {
    
    UIColor *color;
    
    // Color doesn't exist, compute it
    NSScanner *scanner = [[NSScanner alloc] initWithString:stringToConvert];
    unsigned hexNum;
    if ([scanner scanHexInt:&hexNum]) {
        int r = (hexNum >> 16) & 0xFF;
        int g = (hexNum >> 8) & 0xFF;
        int b = (hexNum) & 0xFF;
        
        color = [UIColor colorWithRed:r / 255.0f
                                      green:g / 255.0f
                                       blue:b / 255.0f
                                      alpha:1.0f];
    }
    
	return color;
}

-(UIColor*) darkerShade
{
    
    float red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    double multiplier = 0.8f;
    return [UIColor colorWithRed:red * multiplier green:green * multiplier blue:blue*multiplier alpha:alpha];
}

@end