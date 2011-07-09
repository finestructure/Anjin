//
//  AnjinViewController.m
//  Anjin
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "AnjinViewController.h"
#import "Annotation.h"
#import "NSString+ParsingExtensions.h"

@implementation AnjinViewController
@synthesize mapView = _mapView;

#pragma mark - Helpers


- (void)pinForAddress:(NSString *)address withTitle:(NSString *)title subtitle:(NSString *)subtitle {
  NSLog(@"address: %@", address);
  CLGeocoder *coder = [[CLGeocoder alloc] init];
  [coder geocodeAddressString:address completionHandler:^(NSArray *__strong placemarks, NSError *__strong error) {
    if (error != nil) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Geocoding Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
      //[alert show];
    } else if ([placemarks count] > 0) {
      CLPlacemark *best = [placemarks objectAtIndex:0];
      NSLog(@"Best placemark: %@", best);
      Annotation *a = [[Annotation alloc] init];
      a.title = title;
      a.subtitle = subtitle;
      a.coordinate = best.location.coordinate;
      [self.mapView addAnnotation:a];
    }
  }];
}


#pragma mark - IB Actions

- (IBAction)importTapped:(id)sender {
  NSLog(@"Import tapped");
//  [self pinForAddress:@"An der Grüngesweide 8, Eschborn, Germany" withTitle:@"Nadia" subtitle:@"Die Süße"];
//  [self pinForAddress:@"Obere Kirchstr 7, Martinsthal, Germany" withTitle:@"Sven" subtitle:@"Hase"];
  
  NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [thisBundle URLForResource:@"kunden" withExtension:@"csv"];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSError *error = nil;
    NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSArray *objs = [data arrayWithSeparator:@";"];
    NSLog(@"count: %d", [objs count]);
    [objs enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
      NSMutableString *address = [NSMutableString stringWithString:[obj objectForKey:@"Adresse"]];
      [address appendString:@", "];
      [address appendString:[obj objectForKey:@"PLZ"]];
      [address appendString:@" "];
      [address appendString:[obj objectForKey:@"Ort"]];
      [address appendString:@", Germany"];
      [self pinForAddress:address withTitle:[obj objectForKey:@"Name"] subtitle:[obj objectForKey:@"Ansprechpartner"]];
    }];
  });
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return YES;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

@end
