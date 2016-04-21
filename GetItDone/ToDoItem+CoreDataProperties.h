//
//  ToDoItem+CoreDataProperties.h
//  GetItDone
//
//  Created by Demond Childers on 4/19/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *todoDueDate;
@property (nullable, nonatomic, retain) NSNumber *todoPriority;
@property (nullable, nonatomic, retain) NSDate *todoCompletionDate;
@property (nullable, nonatomic, retain) NSString *todoDescription;

@end

NS_ASSUME_NONNULL_END
