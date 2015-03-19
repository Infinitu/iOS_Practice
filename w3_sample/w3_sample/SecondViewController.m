//
//  SecondViewController.m
//  w3_sample
//
//  Created by 김창규 on 2015. 3. 16..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation SecondViewController
static NSArray *_people;
- (SecondViewController*)init{
    self = [super init];
    if(self == nil)
        return nil;
    _people = @[
                @{@"name":@"이진우",@"number":@131056},
                @{@"name":@"김창규",@"number":@131020},
                @{@"name":@"박태준",@"number":@141037},
                @{@"name":@"심보희",@"number":@141051},
                @{@"name":@"고형진",@"number":@141004},
                @{@"name":@"조영대",@"number":@141083},
                @{@"name":@"신윤서",@"number":@141049},
                ];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _people = @[
                @{@"name":@"이진우",@"number":@131056},
                @{@"name":@"김창규",@"number":@131020},
                @{@"name":@"박태준",@"number":@141037},
                @{@"name":@"심보희",@"number":@141051},
                @{@"name":@"고형진",@"number":@141004},
                @{@"name":@"조영대",@"number":@141083},
                @{@"name":@"신윤서",@"number":@141049},
                ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *queryStr = self.inputText.text;
    NSNumber *result = [self findPersonNumberByName:queryStr];
    self.resultLabel.text = [result stringValue];
}
- (IBAction)showAllStudentNames:(id)sender {
    NSMutableString *message = [NSMutableString stringWithString:@"학생목록:"];
    for (NSDictionary *person in _people) {
        [message appendString: [person objectForKey:@"name"]];
        [message appendString: @", "];
    }
    [self alert:message];

}

- (NSNumber*) findPersonNumberByName:(NSString*)name{
    for (NSDictionary *person in _people) {
        if([[person objectForKey:@"name"] isEqualToString: name])
            return [person objectForKey:@"number"];
    }
    return nil;
}

- (void) alert:(NSString*)content{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:content
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
