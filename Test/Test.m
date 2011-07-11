//
//  Test.m
//  Test
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "Test.h"
#import "CSVParser.h"


@implementation Test


- (void)testParsing {
  NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [thisBundle URLForResource:@"kunden" withExtension:@"csv"];
  STAssertNotNil(url, @"url must not be nil");
  
  NSError *error = nil;
  NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  STAssertNotNil(data, @"data must not be nil");
  
  CSVParser *parser = [[CSVParser alloc] initWithString:data separator:@";" hasHeader:YES fieldNames:nil];
  
  NSArray *objs = [parser arrayOfParsedRows];
  STAssertEquals(36u, [objs count], @"objs count");
  STAssertEqualObjects(@"Wadgassen", [[objs objectAtIndex:0] objectForKey:@"Ort"], @"value for 'Ort'");
}


- (void)testParsingWindowsLineEndings {
  NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [thisBundle URLForResource:@"kunden_win" withExtension:@"csv"];
  STAssertNotNil(url, @"url must not be nil");
  
  NSError *error = nil;
  NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  STAssertNotNil(data, @"data must not be nil");
  
  CSVParser *parser = [[CSVParser alloc] initWithString:data separator:@";" hasHeader:YES fieldNames:nil];
  
  NSArray *objs = [parser arrayOfParsedRows];
  STAssertEquals(36u, [objs count], @"objs count");
  STAssertEqualObjects(@"Wadgassen", [[objs objectAtIndex:0] objectForKey:@"Ort"], @"value for 'Ort'");
}


- (void)testParsingMacLineEndings {
  NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [thisBundle URLForResource:@"kunden_mac" withExtension:@"csv"];
  STAssertNotNil(url, @"url must not be nil");
  
  NSError *error = nil;
  NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  STAssertNotNil(data, @"data must not be nil");
  
  CSVParser *parser = [[CSVParser alloc] initWithString:data separator:@";" hasHeader:YES fieldNames:nil];
  
  NSArray *objs = [parser arrayOfParsedRows];
  STAssertEquals(36u, [objs count], @"objs count");
  STAssertEqualObjects(@"Wadgassen", [[objs objectAtIndex:0] objectForKey:@"Ort"], @"value for 'Ort'");
}


@end
