//
//  AnjinViewController.h
//  Anjin
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface AnjinViewController : UIViewController {
  MKMapView *_mapView;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction)importTapped:(id)sender;

@end
