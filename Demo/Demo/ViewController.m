//
//  ViewController.m
//  Demo
//
//  Created by Ayukey on 2022/10/24.
//

#import "ViewController.h"
#import <NTPrinterSDK/NTPrinterSDK-Swift.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *printerState;
@property (nonatomic)  NTPrinterConnectState ntState;
@end

@implementation ViewController
- (IBAction)send:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)initSDK:(id)sender {
    [[NTPrinter shared] initWithAppIDWithAppID:@"UnderArmour" appSecret:@"e5v42yzolq" completion:^(NTError * _Nullable error) {
        if (error == nil) {
            NSLog(@"初始化SDK成功");
        }
    }];
}

- (IBAction)connectPrint:(id)sender {
    [[NTPrinter shared] connectNTPrinterWithIp:@"192.168.3.222" port:9100 completion:^(enum NTPrinterConnectState state) {
        self.ntState = state;
        switch (state) {
            case NTPrinterConnectStateNotFound:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateNotFound";
                break;
            case NTPrinterConnectStateDisconnect:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateDisconnect";
                break;
            case NTPrinterConnectStateConnecting:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateConnecting";
                break;
            case NTPrinterConnectStateConnected:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateConnected";
                break;
            case NTPrinterConnectStateTimeOut:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateTimeOut";
                break;
            case NTPrinterConnectStateFailt:
                self.printerState.text = @"打印机连接状态: NTPrinterConnectStateFailt";
                break;
            default:
                break;
        }
    }];
}

- (IBAction)doPrint:(id)sender {
    if (self.ntState != NTPrinterConnectStateConnected) {
        NSLog(@"未连接打印机");
        return;
    }
    
    NSDictionary *data = @{
        @"SNumber":@"SNumber1",
        @"MNumber":@"P110",
        @"Name":@"张三",
        @"STime":@"2022-10-21",
        @"DTime":@"2022-10-25",
        @"PayList":@[
            @[@"付款方式1", @"1000", @"2000"],
            @[@"付款方式2", @"2000", @"4000"],
            @[@"付款方式3", @"3000", @"6000"],
        ],
        @"TotalMoney":@"100000",
        @"TotalCount":@"100000",
        @"SaleCount":@"100000",
        @"SaleMoney":@"100000",
        @"ReturnCount":@"100000",
        @"ReturnMoney":@"100000",
    };
    
    [[NTPrinter shared] printTemplateWithName:@"GPC08180_T1"  templateData:data completion:^(NTError * _Nullable  error) {
        if (error == nil) {
            NSLog(@"发送打印指令成功");
        }
    }];
}

@end
