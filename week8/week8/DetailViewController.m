//
//  DetailViewController.m
//  week8
//
//  Created by 김창규 on 2015. 4. 22..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}


bool isParsing = false;
long imgLen;
id instance;
const char *ack = "ACK";

NSInteger getLength(uint8_t* arr){
    char lengthStr[9];
    memcpy(lengthStr, arr, sizeof(uint8_t)*8);
    lengthStr[8]='\0';
    isParsing = true;
    return [[NSString stringWithUTF8String:lengthStr] integerValue];
}

NSMutableData *data = nil;
long parse(uint8_t* arr, NSInteger imgLen, long length){
    if(data == nil)
        data = [[NSMutableData alloc]init];
    long llen = imgLen - data.length;
    if(llen > length)
        llen = length;
    [data appendBytes:arr length:llen];
    if(data.length >= imgLen){
        [instance imageReceived:data];
        isParsing = false;
        data = nil;
    }
    return length-llen;
}


- (void) stream_open {
    
    CFReadStreamRef read_stream;
    CFReadStreamRef write_stream;
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, CFSTR("10.73.38.204"), 8000, &read_stream, NULL);
    
    CFStreamClientContext readContext={0,NULL,NULL,NULL,NULL};
    CFReadStreamSetClient(read_stream, kCFStreamEventOpenCompleted|kCFStreamEventHasBytesAvailable|kCFStreamEventErrorOccurred|kCFStreamEventEndEncountered,
                          readCallback_Detail, &readContext);
    
    CFReadStreamScheduleWithRunLoop(read_stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    
    CFReadStreamOpen(read_stream);
    instance = self;
}



void readCallback_Detail(CFReadStreamRef stream, CFStreamEventType eventType, void *clientCallBackInfo ){
    switch (eventType) {
        case kCFStreamEventOpenCompleted:
            printf("opened\n");
            break;
        case kCFStreamEventHasBytesAvailable:
            printf("can reads!\n");
            long needs = 0;
            if(data == nil)
                needs = 1024;
            else{
                needs = imgLen - data.length;
                needs = needs>1024?1024:needs;
            }
            
            uint8_t arr[1025];
            CFIndex len = CFReadStreamRead(stream, (UInt8*)arr, needs);
            printf("%ld bytes read.\n",len);
            uint8_t *arrPtr = arr;
            if(!isParsing){
                if(len<8)
                    break;
                imgLen = getLength(arrPtr);
                arrPtr = &(arrPtr[8]);
                len -= 8;
                printf("%ld\n",imgLen);
            }
            
            if(isParsing){
                long llen = parse(arrPtr, imgLen, len);
                arrPtr = &(arrPtr[len-llen]);
                len = llen;
            }
            
            
            break;
        default:
            break;
    }
}

-(void) imageReceived:(NSData*)data{
    self.imgView.image = [UIImage imageWithData:data];
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self stream_open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
