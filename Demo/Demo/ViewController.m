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

- (IBAction)printTicket:(id)sender {
    NSDictionary *data = @{
        @"SName":@"西湖小店",
        @"SAddress":@"中国浙江省杭州市余杭区西子湖街道 西湖路3999号",
        @"SPhone":@"1380013800",
        @"Code":@"asdasdasdasdasdasdasd",
        @"STime":@"2022-10-21",
        @"PTime":@"2022-10-25",
        @"RePrint":@YES,
        @"DType":@"正常/退货./换货",
        @"SNumber":@"S123123123",
        @"DNumber":@"P123123123",
        @"PName":@"张三",
        @"PCard":@"AE_71827381923_KJ",
        @"PPoint":@"2590",
        @"PayList":@[
            @[@"L1212-98 001-4", @"1190.00", @"100", @"1", @"1190.00"],
            @[@"L1212-98 001-5", @"1190.00", @"100", @"1", @"1190.00"],
            @[@"L1212-98 001-6", @"1190.00", @"100", @"1", @"1190.00"],
            @[@"L1212-98 001-7", @"1190.00", @"100", @"1", @"1190.00"],
            @[@"L1212-98 001-8", @"1190.00", @"100", @"1", @"1190.00"],
        ],
        @"TotalCount":@"4",
        @"WXPay":@"2000.00",
        @"TotalMoney":@"4760.00",
        @"CardPay":@"2000.00",
        @"TotalPay":@"4760.00",
        @"CashPay":@"760.00",
        @"Change":@"0.00",
        @"Writing":@"阿贾克斯队将阿克琉斯经典款辣椒",
        @"WCode":@"https://nsev.inecm.cn/lacoste/print-template/logo.jpg",
        @"PWriting":@"佳卡拉斯京的考拉就是快乐的",
        @"PCode":@"https://nsev.inecm.cn/lacoste/print-template/logo.jpg",
        @"MWriting":@"阿就是看鹿鼎记阿克琉斯几点开链接",
        @"MCode":@"https://nsev.inecm.cn/lacoste/print-template/logo.jpg",
    };
    
    [[NTPrinter shared] printTemplateWithName:@"GPC08180_T2"  templateData:data completion:^(NTError * _Nullable  error) {
        if (error == nil) {
            NSLog(@"发送打印指令成功");
        }
    }];
}

@end
