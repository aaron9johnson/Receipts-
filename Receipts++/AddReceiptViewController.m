//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Aaron Johnson on 2017-10-27.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "AddReceiptViewController.h"

@interface AddReceiptViewController ()
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;

@end

@implementation AddReceiptViewController
- (IBAction)tagButton:(UIButton *)sender {
    sender.backgroundColor = [UIColor greenColor];
    for(Tag *any in self.tags){
        if([any.tagName isEqualToString:sender.titleLabel.text]){
            [self.tagSet addObject:any];
        }
    }
}
- (IBAction)saveReceipt:(UIButton *)sender {
    Receipt *newReceipt = [[Receipt alloc] initWithContext:self.managedObjectContext];
    newReceipt.note = self.noteTextField.text;
    newReceipt.tags = self.tagSet.copy;
    for(Tag *any in self.tagSet){
        NSMutableOrderedSet<Receipt *> *receiptSet = any.receipts.mutableCopy;
        [receiptSet addObject:newReceipt];
        any.receipts = receiptSet;
    }
    [self.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.tagSet = [NSMutableOrderedSet new];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [self.managedObjectContext executeFetchRequest:request error:nil].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
