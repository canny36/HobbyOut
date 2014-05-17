
/**	
 *	@brief UIColor additions
 **/

@interface UIColor (UIColor_category)

/**	@brief color with hex string
 *	@param stringToConvert hex value 
 *	@return color objet
 **/

+ (UIColor*) colorWithHexString:(NSString*)stringToConvert;

-(UIColor*) darkerShade;

@end