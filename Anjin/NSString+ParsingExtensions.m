//
//  NSString+ParsingExtensions.m
//  Anjin
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "NSString+ParsingExtensions.h"

@implementation NSString (ParsingExtensions)

/*"    Build an array of dictionaries from a TSV (tab-separated
 values) string.  Blank lines and lines starting with "#" are
 ignored.  The first non-empty, non-comment line is assumed to be
 the keys.  Empty lines are not added to the array, so blank
 lines (or lines with just tabs) are safely ignored.  Missing
 items aren't added to the dictionary.  The string is assumed to
 be separated with UNIX newlines only.
 "*/

- (NSArray *) arrayWithSeparator:(NSString *)separator
{
  NSMutableArray *result = [NSMutableArray array];
  NSArray  *lines  = [self componentsSeparatedByString:@"\n"];
  NSEnumerator*theEnum = [lines objectEnumerator];
  NSArray  *keys  = nil;
  int  keyCount = 0;
  NSString *theLine;
  
  while (nil != (theLine = [theEnum nextObject]) )
  {
    if (![theLine isEqualToString:@""] && ![theLine
                                            hasPrefix:@"#"])    // ignore empty lines and lines that start with #
    {
      if (nil == keys) // Is keys not set yet? If so, process first real line as list of keys
      {
        keys = [theLine componentsSeparatedByString:separator];
        keyCount = [keys count];
      }
      else // A data line
      {
        NSMutableDictionary *lineDict = [NSMutableDictionary dictionary];
        NSArray    *values  = [theLine componentsSeparatedByString:separator];
        int    valueCount = [values count];
        int i;
        
        for ( i = 0 ; i < keyCount && i < valueCount ; i++ )
        {
          NSString *value = [values objectAtIndex:i];
          if (nil != value && ![value isEqualToString:@""])
          {
            [lineDict setObject:value forKey:[keys objectAtIndex:i]];
          }
        }
        if ([lineDict count]) // only add the line if there was any data
        {
          [result addObject:lineDict];
        }
      }
    }
  }
  return result;
}

@end
