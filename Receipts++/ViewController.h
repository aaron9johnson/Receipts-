//
//  ViewController.h
//  Receipts++
//
//  Created by Aaron Johnson on 2017-10-26.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipts__+CoreDataModel.h"

@interface ViewController : UIViewController <UITableViewDataSource>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property NSMutableArray *receipts;
@property NSMutableArray *tags;

@end

