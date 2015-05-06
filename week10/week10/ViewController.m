//
//  ViewController.m
//  week10
//
//  Created by 김창규 on 2015. 5. 4..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "ViewController.h"
#import "CKJsonParser.h"
#import "concurrentOperation.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property CGRect originRect;
@property UIColor *originColor;
@property NSString *originTitle;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UITextField *word;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.originColor = self.btn.backgroundColor;
    self.originRect = self.btn.frame;
    self.originTitle = self.btn.titleLabel.text;

    
}
- (IBAction)clicked:(id)sender {
    
    [UIView animateWithDuration:3
                     animations:^{
                         self.btn.backgroundColor = [UIColor redColor];
                         [self.btn setFrame:CGRectMake(50,200, 300, 300)];
                         
                         [self.btn setTitle:@"goodBoy" forState:UIControlStateNormal];
                     }
                     completion:^(BOOL fin){
                         if(fin){
                             [self goback];
                         }
                     }
     ];
}

-(void)goback{
    [UIView animateWithDuration:3
                     animations:^{
                         self.btn.backgroundColor = self.originColor;
                         [self.btn setFrame:self.originRect];
                         
                         [self.btn setTitle:self.originTitle forState:UIControlStateNormal];
                     }
                     completion:^(BOOL fin){
                         if(fin){
                             
                         }
                     }
     ];

    
}

- (IBAction)bookButtonClicked:(id)sender {
    _progressBar.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    for (int nLoop=0; nLoop<length; nLoop++) {
        [NSThread sleepForTimeInterval:0.00001f];
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        dispatch_async(mainQ, ^{
            _progressBar.progress = progress;
        });
    }
    
    dispatch_async(mainQ, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)countClicked:(id)sender {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    
    NSInteger cnt = [self countOfSubstr:self.word.text atContent:bookfile];
    [[[UIAlertView alloc] initWithTitle:@"완료"
                                message:[NSString stringWithFormat:@"찾았다 %ld개",(long)cnt]
                               delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

}


-(NSInteger)countOfSubstr:(NSString*)substring atContent:(NSString*)text{
    substring = [substring stringByReplacingOccurrencesOfString:@"." withString:@"\\."];
    substring = [substring stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    substring = [substring stringByReplacingOccurrencesOfString:@"?" withString:@"\\?"];
    substring = [substring stringByReplacingOccurrencesOfString:@"+" withString:@"\\+"];
    substring = [substring stringByReplacingOccurrencesOfString:@"[" withString:@"\\["];
    substring = [substring stringByReplacingOccurrencesOfString:@"]" withString:@"\\]"];
    substring = [substring stringByReplacingOccurrencesOfString:@"*" withString:@"\\*"];
    substring = [substring stringByReplacingOccurrencesOfString:@"^" withString:@"\\^"];
    substring = [substring stringByReplacingOccurrencesOfString:@"(" withString:@"\\("];
    substring = [substring stringByReplacingOccurrencesOfString:@")" withString:@"\\)"];
    substring = [substring stringByReplacingOccurrencesOfString:@"{" withString:@"\\{"];
    substring = [substring stringByReplacingOccurrencesOfString:@"}" withString:@"\\}"];
    substring = [substring stringByReplacingOccurrencesOfString:@"=" withString:@"\\="];
    substring = [substring stringByReplacingOccurrencesOfString:@"!" withString:@"\\!"];
    substring = [substring stringByReplacingOccurrencesOfString:@"|" withString:@"\\|"];
    substring = [substring stringByReplacingOccurrencesOfString:@":" withString:@"\\:"];
    substring = [substring stringByReplacingOccurrencesOfString:@"-" withString:@"\\-"];
    
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:substring options:0 error:NULL];
    NSInteger cnt = [regex numberOfMatchesInString:text options:0 range:(NSRange){0,text.length}];
    return cnt;
}

int cnt ;
NSString *minStr ;
NSString *maxStr ;
long minCnt ;
long maxCnt ;
double sleepCnt=10.0;

- (IBAction)wordListCount:(id)sender {
    [NSURLConnection
     sendAsynchronousRequest:[NSURLRequest requestWithURL:
                                              [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"]]
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *connectionError){
         NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                  pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
         
         NSArray* arr = [CKJsonParser parseJson:[NSString stringWithUTF8String:data.bytes]];
         cnt = (int)arr.count;
         minStr = @"";
         maxStr = @"";
         minCnt = LONG_MAX;
         maxCnt = LONG_MIN;
         NSOperationQueue *queue =  [[NSOperationQueue alloc] init];
         queue.maxConcurrentOperationCount = 4;
         for(NSString *str in arr){
             NSBlockOperation *oper =[concurrentOperation blockOperationWithBlock:^{
                 sleepCnt = sleepCnt/2;
                 [NSThread sleepForTimeInterval:sleepCnt];
                 long strcnt = [self countOfSubstr:str atContent:bookfile];
                 
                 NSLog(@"%@ -> %ld",str,strcnt);
                 
                 if(strcnt < minCnt){
                     minCnt = strcnt;
                     minStr = str;
                 }
                 if(strcnt > maxCnt){
                     maxCnt = strcnt;
                     maxStr = str;
                 }
                 
                 if(--cnt <=0){
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"완료"
                                                     message:[NSString stringWithFormat:@"최대단어 %@, %ld개.\n 최소단어 %@, %ld개.",maxStr,maxCnt,minStr,minCnt]
                                                    delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                     });
                 }
             }];
             NSLog(@"%d", oper.isConcurrent);
             [queue addOperation:oper];
         }
         
         
     }];
}

@end
