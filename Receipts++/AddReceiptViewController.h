//
//  AddReceiptViewController.h
//  Receipts++
//
//  Created by Aaron Johnson on 2017-10-27.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"

@interface AddReceiptViewController : UIViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableOrderedSet<Tag *> *tagSet;
@property NSMutableArray *tags;
@end
