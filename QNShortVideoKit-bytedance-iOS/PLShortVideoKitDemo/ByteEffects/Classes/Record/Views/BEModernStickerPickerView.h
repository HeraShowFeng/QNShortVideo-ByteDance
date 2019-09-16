// Copyright (C) 2019 Beijing Bytedance Network Technology Co., Ltd.

#import <UIKit/UIKit.h>

@class BEEffectSticker, BEModernStickerPickerView;
@protocol BEModernStickerPickerViewDelegate <NSObject>

- (void)stickerPicker:(BEModernStickerPickerView*)pickerView didSelectStickerPath:(NSString *)path toastString:(NSString*) toast;

@end

@interface BEModernStickerPickerView : UIView

@property (nonatomic, weak) id<BEModernStickerPickerViewDelegate> delegate;

- (void)refreshWithStickers:(NSArray <BEEffectSticker *>*) stickers;
- (void)setAllCellUnSelected;
@end
