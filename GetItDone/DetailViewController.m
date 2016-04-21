//
//  DetailViewController.m
//  GetItDone
//
//  Created by Demond Childers on 4/20/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()


@property(nonatomic, strong)        NSManagedObjectContext  *managedObjectContext;
@property(nonatomic, strong)        AppDelegate             *appDelegate;
@property(nonatomic, weak) IBOutlet UIDatePicker            *dueDatePicker;
@property(nonatomic, weak) IBOutlet UIDatePicker            *completeDatePicker;
@property(nonatomic, weak) IBOutlet UITextView              *descripTextView;
@property(nonatomic, weak) IBOutlet UISegmentedControl      *prioritySegControl;



//#pragma mark - Date Picker methods
//
//-(IBAction)datePickerChanged:(UIDatePicker *)picker {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"M/dd/yy"];
//    NSLog(@"Date: %@", [formatter stringFromDate: picker.date]);
//}


@end

@implementation DetailViewController


#pragma mark- Interactivity Methods


-(void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
    
}

-(IBAction)saveButtonPressed:(id)sender {
    NSLog(@"Save");
    _currentItem.todoDueDate = _dueDatePicker.date;
    _currentItem.todoCompletionDate= _completeDatePicker.date;
    _currentItem.todoDescription = _descripTextView.text;
    _currentItem.todoPriority = [NSNumber numberWithInteger:_prioritySegControl.selectedSegmentIndex];
    [self saveAndPop];
}

-(IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete");

    
    
    
    [_managedObjectContext deleteObject:_currentItem];
    [self saveAndPop];


}

#pragma mark- Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication]delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_currentItem == nil) {
        ToDoItem *newToDoItem = (ToDoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_managedObjectContext ];
        _currentItem = newToDoItem;
        _dueDatePicker.date = [NSDate date];
        _prioritySegControl.selectedSegmentIndex = 0;
        _descripTextView.text = @"";
    } else {
        _dueDatePicker.date = _currentItem.todoDueDate;
        _prioritySegControl.selectedSegmentIndex = [_currentItem.todoPriority integerValue];
        _descripTextView.text = _currentItem.todoDescription;
    }
    
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_managedObjectContext hasChanges]) {
        [_managedObjectContext rollback];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
