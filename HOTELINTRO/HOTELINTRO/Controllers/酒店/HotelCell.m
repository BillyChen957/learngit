//
//  InformationCell.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/3.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "HotelCell.h"
#import "SDWebImage-umbrella.h"
@interface HotelCell ()

@property (nonatomic, strong) UIImageView *imV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subroomAmoutLab;
@property (nonatomic, strong) UILabel *roomAmoutLab;
@property (nonatomic, strong) UILabel *subrateLab;
@property (nonatomic, strong) UILabel *rateLab;
@property (nonatomic, strong) UIButton *phoneBtn;
//@property (nonatomic, strong) UILabel *telephoneLab;
@property (nonatomic, strong) UILabel *subtelephoneLab;
//@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *collectBtn;
@end

@implementation HotelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.subroomAmoutLab];
        [self.contentView addSubview:self.roomAmoutLab];
        [self.contentView addSubview:self.subrateLab];
        [self.contentView addSubview:self.rateLab];
        [self.contentView addSubview:self.subtelephoneLab];
//        [self.contentView addSubview:self.telephoneLab];
        [self.contentView addSubview:self.phoneBtn];
//        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.collectBtn];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}


- (void)setModel:(HotelDataModel *)model{
    _model = model;
    self.titleLab.text = model.hotelName;
    self.roomAmoutLab.text = model.hotelsize;
    self.rateLab.text = model.satisrate;

    [self.phoneBtn setTitle:model.telephone forState:UIControlStateNormal];
    [self.imV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolderS"]];
    
    
}
- (void)setIsCollectionCell:(BOOL)isCollectionCell{
    _isCollectionCell = isCollectionCell;
    NSString *str = isCollectionCell ? local(@"取消收藏") : local(@"收藏");
    [self.collectBtn setTitle:str forState:UIControlStateNormal];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@120);
//        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imV.mas_right).offset(5);
        make.top.equalTo(self.imV);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    
    [self.subroomAmoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
    }];
    [self.roomAmoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subroomAmoutLab.mas_right).offset(2);
        make.centerY.equalTo(self.subroomAmoutLab);
    }];
    [self.subrateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.subroomAmoutLab.mas_bottom).offset(3);
    }];
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subrateLab.mas_right).offset(2);
        make.centerY.equalTo(self.subrateLab);
    }];
    
    [self.subtelephoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.rateLab.mas_bottom).offset(3);
    }];
//    [self.telephoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.subtelephoneLab.mas_right).offset(2);
//        make.centerY.equalTo(self.subtelephoneLab);
//    }];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subtelephoneLab.mas_right).offset(2);
        make.centerY.equalTo(self.subtelephoneLab);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imV.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@40);
        make.centerX.bottom.equalTo(self.contentView);
    }];
    
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@0.5);
//        make.width.equalTo(@(SCREEN_WIDTH));
//        make.left.bottom.equalTo(self.contentView);
//    }];
}
//- (UIView *)line{
//    if (!_line) {
//        _line = [[UIView alloc]init];
//        _line.backgroundColor = SCHEXCOLOR(0xe5e5e5);
//    }
//    return _line;
//}


- (void)callPhone{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelCellCallNumber:)]) {
        [self.delegate hotelCellCallNumber:self.model];
    }
    
}
- (void)collectAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelCellCollectModels:)]) {
        [self.delegate hotelCellCollectModels:self.model];
    }
}
- (UIButton *)collectBtn{
    if (!_collectBtn) {
        
        _collectBtn = [[UIButton alloc]init];
        [_collectBtn setTitle:local(@"收藏") forState:UIControlStateNormal];
        [_collectBtn setTitleColor:SCRGBAColor(0, 0, 0, 0.8) forState:UIControlStateNormal];
        [_collectBtn setTitleColor:SCRGBAColor(0, 0, 0, 0.3) forState:UIControlStateHighlighted];
        _collectBtn.titleLabel.font = AdaptedFontSize(12);
        _collectBtn.layer.borderColor = SCRGBAColor(0, 0, 0, 0.1).CGColor;
        _collectBtn.layer.borderWidth = 1;
        [_collectBtn setBackgroundImage:[UIImage imageWithColor:SCHEXCOLOR(0xffffff)] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc]init];
        [_phoneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = AdaptedFontSize(14);
        [_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (UILabel *)subtelephoneLab{
    if (!_subtelephoneLab) {
        _subtelephoneLab = [[UILabel alloc]init];
        _subtelephoneLab.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _subtelephoneLab.font = AdaptedFontSize(14);
        _subtelephoneLab.textAlignment = NSTextAlignmentLeft;
        _subtelephoneLab.text = @"联系电话:";
    }
    return _subtelephoneLab;
}
- (UILabel *)rateLab{
    if (!_rateLab) {
        _rateLab = [[UILabel alloc]init];
        _rateLab.textAlignment = NSTextAlignmentLeft;
        _rateLab.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _rateLab.font = AdaptedFontSize(14);
        
    }
    return _rateLab;
}
- (UILabel *)subrateLab{
    if (!_subrateLab) {
        _subrateLab = [[UILabel alloc]init];
        _subrateLab.textAlignment = NSTextAlignmentLeft;
        _subrateLab.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _subrateLab.font = AdaptedFontSize(14);
        _subrateLab.text = @"客户入住满意率:";
    }
    return _subrateLab;
}

- (UILabel *)roomAmoutLab{
    if (!_roomAmoutLab) {
        _roomAmoutLab = [[UILabel alloc]init];
        _roomAmoutLab.textAlignment = NSTextAlignmentLeft;
        _roomAmoutLab.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _roomAmoutLab.font = AdaptedFontSize(14);
        
    }
    
    return _roomAmoutLab;
}
- (UILabel *)subroomAmoutLab{
    if (!_subroomAmoutLab) {
        _subroomAmoutLab = [[UILabel alloc]init];
        _subroomAmoutLab.textAlignment = NSTextAlignmentLeft;
        _subroomAmoutLab.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _subroomAmoutLab.font = AdaptedFontSize(14);
        _subroomAmoutLab.text = @"客房总数量:";
        
    }
    
    return _subroomAmoutLab;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = SCRGBAColor(0, 0, 0, 0.9);
        _titleLab.font = AdaptedHelveticaFontSize(16);
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIImageView *)imV{
    if (!_imV) {
        _imV = [[UIImageView alloc]init];
        _imV.backgroundColor = [UIColor purpleColor];
        _imV.layer.cornerRadius = 5;
        _imV.layer.masksToBounds = YES;
        _imV.layer.borderWidth = 1;
        _imV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imV.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imV;
}
@end
