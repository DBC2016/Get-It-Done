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

@property(nonatomic,weak) IBOutlet  UILabel                 *todoItemLabel;
@property(nonatomic, strong)        NSManagedObjectContext  *managedObjectContext;
@property(nonatomic, strong)        AppDelegate             *appDelegate;
@property(nonatomic, weak) IBOutlet UIDatePicker            *dueDatePicker;
@property(nonatomic, weak) IBOutlet UIDatePicker            *completeDatePicker;
@property(nonatomic, weak) IBOutlet UITextView              *descripTextView;
@property(nonatomic, weak) IBOutlet UISegmentedControl      *prioritySegControl;
@property(nonatomic, weak) IBOutlet UISwitch                *completeSwitch;




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
    
    -(IBAction)setCompleteSwitch:(UISwitch *)completeSwitch {
        NSString *compSwitch = @"";
        if (_completeSwitch.isOn) {
        compSwitch = @"Yes";
        } else{
        compSwitch = @"No";
}
//    
//        -NSLog(@"%@ for %@ Due Date: %ld, Priority: %ld, Completed: %@, Completion Date: %@, Description: %@",_todoItemLabel.text, _dueDatePicker.date, (long)_prioritySegControl.selectedSegmentIndex, _completeSwitch.isOn, _completeDatePicker, _descripTextView.text, [_prioritySegControl titleForSegmentAtIndex:_prioritySegControl.selectedSegmentIndex]);
//    }
}

//
//    - (IBAction)setSubmitButton:(UIButton *)submitButton {
//        NSString *recString = @"";
//        if (_recomSwitch.isOn) {
//            recString = @"Yes";
//        } else {
//            recString = @"No";
//        }
//        NSLog(@"%@ Results by %@ review: %@, Food Rating: %@, Service: %i, Overall: %i, Recommended: %@",_restLabel.text, _nameTextField.text, _reviewTextView.text, [_foodSegControl titleForSegmentAtIndex:_foodSegControl.selectedSegmentIndex], (int)_foodStepper.value, (int)_overallSlider.value, recString);



#pragma mark- Life Cycle Methods

    - (void)viewDidLoad {
        [super viewDidLoad];
        _appDelegate = [[UIApplication sharedApplication]delegate];
        _managedObjectContext = _appDelegate.managedObjectContext;
    
}

    -(void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];
        if (_currentItem == nil) {
        ToDoItem *newToDoItem = (ToDoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext ];
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
