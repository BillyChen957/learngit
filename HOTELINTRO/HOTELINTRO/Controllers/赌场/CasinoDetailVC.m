//
//  CasinoDetailVC.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/3.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "CasinoDetailVC.h"
#import "CasinosModel.h"
@interface CasinoDetailVC ()
@property (nonatomic, strong) CasinosModel *model;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation CasinoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SCHEXCOLOR(0xf0f0f0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.title = self.model.name;
    [self.view addSubview:self.textView];
    //    self.textView.text = self.model.descStr;
    NSMutableParagraphStyle *paragra = [[NSMutableParagraphStyle alloc]init];
    paragra.lineSpacing = 10;
    paragra.paragraphSpacing = 10;
    paragra.alignment = NSTextAlignmentLeft;
    paragra.firstLineHeadIndent = 20;
    paragra.headIndent = 10;
    paragra.tailIndent = SCREEN_WIDTH - 10;
    paragra.minimumLineHeight = 2;
    paragra.maximumLineHeight = 10;
    paragra.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSString *str = [NSString stringWithFormat:@"\n%@\n\n",self.model.descStr];
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:AdaptedFontSize(16),NSForegroundColorAttributeName:SCRGBAColor(0, 0, 0, 0.8),NSParagraphStyleAttributeName:paragra,NSKernAttributeName:@2}];
    self.textView.attributedText = attributeStr;
    
    
    // Do any additional setup after loading the view.
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _textView.editable = NO;
        _textView.backgroundColor = SCHEXCOLOR(0xf0f0f0);
    }
    return _textView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
