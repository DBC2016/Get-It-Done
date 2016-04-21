//
//  DetailViewController.h
//  GetItDone
//
//  Created by Demond Childers on 4/20/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"


@interface DetailViewController : UIViewController

@property (nonatomic, strong) ToDoItem *currentItem;


@end
