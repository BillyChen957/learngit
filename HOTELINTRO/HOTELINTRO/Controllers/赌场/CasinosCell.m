//
//  CasinosCell.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/3.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "CasinosCell.h"
#import "SDWebImage-umbrella.h"
@interface CasinosCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *subaddresslabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *subphoneLabel;
@property (nonatomic, strong) UILabel *deskLabel;
@property (nonatomic, strong) UILabel *subdeskLabel;
@property (nonatomic, strong) UILabel *macLabel;
@property (nonatomic, strong) UILabel *submacLabel;
@property (nonatomic, strong) UILabel *betLowLabel;
@property (nonatomic, strong) UILabel *subbetLowLabel;
@property (nonatomic, strong) UILabel *memberLabel;
@property (nonatomic, strong) UILabel *submemberLabel;
@property (nonatomic, strong) UIView *background;

@end

@implementation CasinosCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.background];
        [self.background addSubview:self.imageV];
        [self.background addSubview:self.nameLabel];
        [self.background addSubview:self.addressLabel];
        [self.background addSubview:self.subaddresslabel];
        [self.background addSubview:self.phoneLabel];
        [self.background addSubview:self.subphoneLabel];
        [self.background addSubview:self.deskLabel];
        [self.background addSubview:self.subdeskLabel];
        [self.background addSubview:self.macLabel];
        [self.background addSubview:self.submacLabel];
        [self.background addSubview:self.betLowLabel];
        [self.background addSubview:self.subbetLowLabel];
        [self.background addSubview:self.memberLabel];
        [self.background addSubview:self.submemberLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
  
    }
    
    return self;
}


- (void)setModel:(CasinosModel *)model{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
    self.phoneLabel.text = model.phoneNum;
    self.deskLabel.text = model.deskStr;
    self.macLabel.text = model.macStr;
    self.betLowLabel.text = model.betlowStr;
    self.memberLabel.text = model.memberStr;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(AdaptedHeight(280)-20));
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH-30));
        make.height.equalTo(@((SCREEN_WIDTH-30)*0.75*0.5));
        make.left.equalTo(self.background.mas_left);
        make.top.equalTo(self.background.mas_top);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV).offset(5);
        make.top.equalTo(self.imageV.mas_bottom).offset(5);
    }];
    [self.subaddresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subaddresslabel.mas_right).offset(2);
        make.centerY.equalTo(self.subaddresslabel);
    }];
    [self.subphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subphoneLabel.mas_right).offset(2);
        make.centerY.equalTo(self.subphoneLabel);
    }];
    [self.subdeskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.subphoneLabel.mas_bottom).offset(5);
    }];
    [self.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subdeskLabel.mas_right).offset(2);
        make.centerY.equalTo(self.subdeskLabel);
    }];
    [self.submacLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.subdeskLabel.mas_bottom).offset(5);
    }];
    [self.macLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.submacLabel.mas_right).offset(2);
        make.centerY.equalTo(self.submacLabel);
    }];
    [self.subbetLowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.macLabel.mas_bottom).offset(5);
    }];
    [self.betLowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subbetLowLabel.mas_right).offset(2);
        make.centerY.equalTo(self.subbetLowLabel);
    }];
    [self.submemberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.betLowLabel.mas_bottom).offset(5);
    }];
    [self.memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.submemberLabel.mas_right).offset(2);
        make.centerY.equalTo(self.submemberLabel);
    }];
    
    
    
}

- (UIView *)background{
    if (!_background) {
        _background = [[UIView alloc]init];
        _background.backgroundColor = SCHEXCOLOR(0xf0f0f0);
        _background.layer.cornerRadius = 5;
        _background.layer.masksToBounds = YES;
    }
    return _background;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.masksToBounds = YES;
        
    }
    return _imageV;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = SCRGBColor(0, 0, 0);
        _nameLabel.font = AdaptedFontSize(16);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _addressLabel.font = AdaptedFontSize(14);
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLabel;
}
- (UILabel *)subaddresslabel{
    if (!_subaddresslabel) {
        _subaddresslabel = [[UILabel alloc]init];
        _subaddresslabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _subaddresslabel.font = AdaptedFontSize(14);
        _subaddresslabel.numberOfLines = 0;
        _subaddresslabel.textAlignment = NSTextAlignmentLeft;
        _subaddresslabel.text = @"地址:";
    }
    return _subaddresslabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _phoneLabel.font = AdaptedFontSize(14);
        _phoneLabel.numberOfLines = 0;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}
- (UILabel *)subphoneLabel{
    if (!_subphoneLabel) {
        _subphoneLabel = [[UILabel alloc]init];
        _subphoneLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _subphoneLabel.font = AdaptedFontSize(14);
        _subphoneLabel.numberOfLines = 0;
        _subphoneLabel.textAlignment = NSTextAlignmentLeft;
        _subphoneLabel.text = @"电话:";
    }
    return _subphoneLabel;
}

- (UILabel *)deskLabel{
    if (!_deskLabel) {
        _deskLabel = [[UILabel alloc]init];
        _deskLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _deskLabel.font = AdaptedFontSize(14);
        _deskLabel.numberOfLines = 0;
        _deskLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _deskLabel;
}

- (UILabel *)subdeskLabel{
    if (!_subdeskLabel) {
        _subdeskLabel = [[UILabel alloc]init];
        _subdeskLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _subdeskLabel.font = AdaptedFontSize(14);
        _subdeskLabel.numberOfLines = 0;
        _subdeskLabel.textAlignment = NSTextAlignmentLeft;
        _subdeskLabel.text = @"賭桌數目:";
    }
    return _subdeskLabel;
}
- (UILabel *)macLabel{
    if (!_macLabel) {
        _macLabel = [[UILabel alloc]init];
        _macLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _macLabel.font = AdaptedFontSize(14);
        _macLabel.numberOfLines = 0;
        _macLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _macLabel;
}

- (UILabel *)submacLabel{
    if (!_submacLabel) {
        _submacLabel = [[UILabel alloc]init];
        _submacLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _submacLabel.font = AdaptedFontSize(14);
        _submacLabel.numberOfLines = 0;
        _submacLabel.textAlignment = NSTextAlignmentLeft;
        _submacLabel.text = @"角子機數:";
    }
    return _submacLabel;
}

- (UILabel *)betLowLabel{
    if (!_betLowLabel) {
        _betLowLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _betLowLabel.font = AdaptedFontSize(14);
        _betLowLabel.numberOfLines = 0;
        _betLowLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _betLowLabel;
}
- (UILabel *)subbetLowLabel{
    if (!_subbetLowLabel) {
        _subbetLowLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _subbetLowLabel.font = AdaptedFontSize(14);
        _subbetLowLabel.numberOfLines = 0;
        _subbetLowLabel.textAlignment = NSTextAlignmentLeft;
        _subbetLowLabel.text = @"最低下注:";
    }
    return _subbetLowLabel;
}

- (UILabel *)memberLabel{
    if (!_memberLabel) {
        _memberLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _memberLabel.font = AdaptedFontSize(14);
        _memberLabel.numberOfLines = 0;
        _memberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _memberLabel;
}
- (UILabel *)submemberLabel{
    if (!_submemberLabel) {
        _submemberLabel.textColor = SCRGBAColor(0, 0, 0, 0.8);
        _submemberLabel.font = AdaptedFontSize(14);
        _submemberLabel.numberOfLines = 0;
        _submemberLabel.textAlignment = NSTextAlignmentLeft;
        _submemberLabel.text = @"貴賓會藉:";
    }
    return _submemberLabel;
}
@end
