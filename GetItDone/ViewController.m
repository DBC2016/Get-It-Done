//
//  ViewController.m
//  GetItDone
//
//  Created by Demond Childers on 4/19/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "toDoItem.h"
#import "DetailViewController.h"


@interface ViewController ()

@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray                *toDoItemArray;
@property (nonatomic, weak)   IBOutlet UITableView   *itemTableView;




@end

@implementation ViewController


#pragma - Table View Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoItemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *itemCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ToDoItem *currentItem = _toDoItemArray[indexPath.row];
    itemCell.textLabel.text = [currentItem todoDescription];
    itemCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", currentItem.todoPriority];
    return itemCell;

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"editToDoSegue"]) {
    NSIndexPath *indexPath = [_itemTableView indexPathForSelectedRow];
    ToDoItem *selectedItem = _toDoItemArray [indexPath.row];
    destController.currentItem = selectedItem;
    } else if ([[segue identifier] isEqualToString:@"addToDoSegue"]) {
        destController.currentItem = nil;
        

}
    
    
    
//    //BLOCK AREA (JUST FYI)
//    - (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//            NSLog(@"Delete");
//            Person *personToDelete = _personsArray[indexPath.row];
//            [_manageObjectContext deleteObject:personToDelete];
//            [_appDelegate saveContext];
//            [self refreshDataAndTAble];
//        }];
//        return @[deleteAction];
//        
//    }
//    
//    -(void)refreshDataAndTAble {
//        _personsArray = [self fetchPersons];
//        [_personTableView reloadData];
//    }

}
#pragma - Core Data Methods

    -(void)tempAddRecords {
    
//    //Add One Item
    ToDoItem *newItem =(ToDoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    
    [newItem setTodoDescription:@"Do the Laundry"];
    [newItem setTodoPriority:[NSNumber numberWithInteger:2]];
    [newItem setTodoDueDate:[NSDate date]];
    [newItem setTodoCompletionDate:[NSDate date]];

    //Add 2nd Item
    ToDoItem *newItem2 =(ToDoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    
    [newItem2 setTodoDescription:@"Mow the lawn"];
    [newItem2 setTodoPriority:[NSNumber numberWithInteger:1]];
    [newItem2 setTodoDueDate:[NSDate date]];
    [newItem2 setTodoCompletionDate:[NSDate date]];
    [_appDelegate saveContext];
    
    
}
   //Fetch Items

-(NSArray *)fetchItems {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;

}


#pragma - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    [self tempAddRecords]; 
    _toDoItemArray =[self fetchItems];
    NSLog(@"Count: %li",_toDoItemArray.count);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


    @end


