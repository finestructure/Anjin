//
//  AnjinViewController.m
//  Anjin
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "AnjinViewController.h"
#import "Annotation.h"

@implementation AnjinViewController
@synthesize mapView = _mapView;
@synthesize geocoder = _geocoder;

#pragma mark - Helpers


- (void)pinForAddress:(NSString *)address withTitle:(NSString *)title subtitle:(NSString *)subtitle {
  [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *__strong placemarks, NSError *__strong error) {
    NSLog(@"Placemarks: %d", [placemarks count]);
    if (error != nil) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Geocoding Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [alert show];
    } else if ([placemarks count] > 0) {
      CLPlacemark *best = [placemarks objectAtIndex:0];
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
  [self pinForAddress:@"An der Grüngesweide 8, Eschborn, Germany" withTitle:@"Nadia" subtitle:@"Die Süße"];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.geocoder = [[CLGeocoder alloc] init];
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
