//
//  ViewController.m
//  Receipts++
//
//  Created by Aaron Johnson on 2017-10-26.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "ViewController.h"
#import "AddReceiptViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ViewController
- (IBAction)addReceipt:(UIButton *)sender {
    [self performSegueWithIdentifier:@"addReceipt" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AddReceiptViewController *aRVC = [segue destinationViewController];
    aRVC.managedObjectContext = self.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTags];
    [self loadReceipts];
    NSLog(@"tags: %@", self.tags);
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.myTableView reloadData];
}
-(void)loadReceipts{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    NSError *error = nil;
    self.receipts = [self.managedObjectContext executeFetchRequest:request error:&error].mutableCopy;
    if (self.receipts.count == 0) {
        NSLog(@"no receipts");
    }
}
-(void)loadTags{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [self.managedObjectContext executeFetchRequest:request error:nil].mutableCopy;
    if (self.tags.count == 0) {
        Tag *one = [[Tag alloc] initWithContext:self.managedObjectContext];
        one.tagName = @"Buisness";
        Tag *two = [[Tag alloc] initWithContext:self.managedObjectContext];
        two.tagName = @"Family";
        Tag *three = [[Tag alloc] initWithContext:self.managedObjectContext];
        three.tagName = @"Play";
        [self.managedObjectContext save:nil];
        NSLog(@"loadTag");
        [self loadTags];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    Tag *tempT = self.tags[indexPath.section];
    NSArray *receiptsForTag = [tempT.receipts array];
    Receipt *tempR = receiptsForTag[indexPath.row];
    cell.textLabel.text = tempR.note;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"numberOfRowsInSection: %lu", (unsigned long)[self.tags[section] count]);
    return [self.tags[section] receipts].count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(!self.tags){
        return @"Hello";
    }
    return [self.tags[section] tagName];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"numberOfSectionsInTableView: %lu", (unsigned long)self.tags.count);
    return self.tags.count;
}

//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
