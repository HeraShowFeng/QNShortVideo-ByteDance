// Copyright (C) 2019 Beijing Bytedance Network Technology Co., Ltd.

#import "BEEffectDataManager.h"
#import <Mantle/EXTScope.h>
#import "BEMacro.h"

@interface BEEffectDataManager ()

@property (nonatomic, assign) BEEffectDataManagerType type;
@property (nonatomic, strong) dispatch_queue_t operationQueue;
@property (nonatomic, strong) BEEffectResponseModel *responseModel;

@end

static NSArray* stickersArray = nil;

@implementation BEEffectDataManager

- (void) initStickerDict{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        stickersArray = @[
           // @"控雨", @"icon_rain", @"rain",
//            NSLocalizedString(@"sticker_change_face", nil), @"icon_change_face", @"change_face",  NSLocalizedString(@"sticker_change_face_tip", nil),
//            @"京剧武旦", @"icon_wudan", @"wudan",
//            @"青衣", @"icon_qingyi", @"qingyi",
//            @"花脸", @"icon_hualian", @"hualian",
//            @"老生", @"icon_laosheng", @"laosheng",
//            @"丑角色", @"icon_choujue", @"choujuese",
//            NSLocalizedString(@"sticker_line_dance", nil), @"icon_line_dance", @"line_dance", @"",

//            @"羽毛", @"icon_yumao", @"a159dab11e52bc53fcbe5b496cbf0d0b",
             NSLocalizedString(@"sticker_xiyue", nil), @"icon_xiyue", @"739661e875e3086700024d34eb5ee92c", @"",
//            @"魔界妆", @"icon_mojie", @"3b4b645fcb557ba5e451037c81a21e60",
//            @"神龙", @"icon_shenlong", @"0c435f3a8187f61b394145575d151e48",
             NSLocalizedString(@"sticker_huaxianzi", nil), @"icon_huaxian", @"6bc53e0a429951da45d55f91f01a9403",  NSLocalizedString(@"sticker_huaxianzi_tip", nil),
            
            NSLocalizedString(@"sticker_caixiaomao", nil), @"icon_xiaomao", @"e31f163f969a35655b1953c4cdf49d77", NSLocalizedString(@"sticker_caixiaomao_tip", nil),
            
            NSLocalizedString(@"sticker_xiaoemo", nil), @"icon_emo", @"01dd809c056708f5ad97a1327ea2ae95",  @"",
            
            NSLocalizedString(@"sticker_shengrikuaile", nil), @"icon_happy_birthday", @"95a9aeb2c7f99d3d8f7931ea2cbe11ce",   NSLocalizedString(@"sticker_shengrikuaile_tip", nil),
            
            NSLocalizedString(@"sticker_maomao", nil), @"icon_maomao", @"12dc4ebc9802e812dea2a64ddb0e03d8", @"",
            
            NSLocalizedString(@"sticker_wumeiniang", nil), @"icon_wumeiniang", @"6eeefb66259e73e5b10090271a278d21", NSLocalizedString(@"sticker_wumeiniang_tip", nil),
            
            NSLocalizedString(@"sticker_liuxing", nil), @"icon_liuxing", @"d765b60b9c046618ccf95973212bcb52", NSLocalizedString(@"sticker_liuxing_tip", nil),
            
            NSLocalizedString(@"sticker_yinghua", nil), @"icon_yinghuazhuang", @"788130eaaa4093084d9683ff3d349a18", @"",
            NSLocalizedString(@"sticker_tujie", nil), @"icon_tujie", @"80c48bd4e99eb65cb2085029de50e7ca", @"",
            
            NSLocalizedString(@"sticker_dielianjin", nil), @"icon_dienianjin", @"14fc8ac081ffea4c797a30693906e604",  NSLocalizedString(@"sticker_dielianjin_tip", nil),
            
            NSLocalizedString(@"sticker_dielianfen", nil), @"icon_dienianfen", @"e8dc3a7dda4872dd3e87ba62a13da865", NSLocalizedString(@"sticker_dielianfen_tip", nil),

            //      @"萌小只", @"icon_mengxiaozhi", @"cd30943149315188f208c31064c6f0b8",
             NSLocalizedString(@"sticker_huahai", nil), @"icon_huahai", @"f24643fd56b51e1b73052b12e6228e4c",  NSLocalizedString(@"sticker_huahai_tip", nil),
            
             NSLocalizedString(@"sticker_miluzhuang", nil), @"icon_milu", @"ba8dd4129cfbdaa5d3fbc20f2440ed27",  @"",
            
            NSLocalizedString(@"sticker_nyekong", nil), @"icon_yekongyanhuo", @"d2158449000686c8387035d73194c16c",  NSLocalizedString(@"sticker_yekong_tip", nil),
            
            NSLocalizedString(@"sticker_haiwang", nil), @"icon_haiwang", @"b36de00c4a0159ee21026293284b4b3d",  NSLocalizedString(@"sticker_haiwang_tip", nil),
            
           NSLocalizedString(@"sticker_tanchizhu", nil), @"icon_zhubizi", @"c2babd85f326bd7606c306466fb8c68f",NSLocalizedString(@"sticker_tanchizhu_tip", nil),
            
            NSLocalizedString(@"sticker_xinxing", nil), @"icon_fashexinxin", @"959c694d54d12b7564e841cc414e9fce", NSLocalizedString(@"sticker_xinxing_tip", nil),
            
           NSLocalizedString(@"sticker_milutoushi", nil), @"icon_milutou", @"9142ffa02be322ec339ac7dc76f7d0f3", @"",
            //      @"跳舞", @"icon_tiaowu", @"25f92cfbd89e643f902632f3a0799e62",
//            @"女神面具", @"icon_nvshenmianju", @"229c8eb45ae6a16ed510b77df8f0b794",
            
            NSLocalizedString(@"sticker_chelianmao", nil), @"icon_chelianmao", @"47127c515e75a6198c17d9833403de06", @"",
            
            NSLocalizedString(@"sticker_chuipaopao", nil), @"icon_chuipaopao", @"3c9b2bd6b54272e61db451314b102eff", @"",

            NSLocalizedString(@"sticker_mengmengxiaolu", nil), @"icon_mengmengxiaolu", @"3465b8b40b1c45476d1570656a632bea", NSLocalizedString(@"sticker_mengmengxiaolu_tip", nil),

            NSLocalizedString(@"sticker_duiwohaqi", nil), @"icon_duiwohaqi", @"ca46adae688d22d885cbc5bd0b4ab595", NSLocalizedString(@"sticker_duiwohaqi_tip", nil),

            NSLocalizedString(@"sticker_tuaixin", nil), @"icon_chuiaixin", @"4d0ca76cbb4b967cc9f8b6447c6470d8",  NSLocalizedString(@"sticker_tuaixin_tip", nil),

            NSLocalizedString(@"sticker_xiaohuanggou", nil), @"icon_xiaohuanggou", @"7841f11c0ac01478044e3f4bea3ced9d", @"",
            
            NSLocalizedString(@"sticker_woshishui", nil), @"icon_woshishui", @"725b308b77aa3349a73d72a73f4cc786", NSLocalizedString(@"sticker_woshishui_tip", nil),

            NSLocalizedString(@"sticker_nvjingling", nil), @"icon_nvjingling", @"170283d9c2f6b7a282f843e88520b117", NSLocalizedString(@"sticker_nvjingling_tip", nil),

            NSLocalizedString(@"sticker_sanzhilanmao", nil), @"icon_sanzhilanmao", @"623a287f5dd0bc5e914716778edf5834", @"",
            
            NSLocalizedString(@"sticker_huaxin", nil), @"icon_aixinxin", @"2e500c659d4ca514ca144f619add02f7", @"",

            NSLocalizedString(@"sticker_yanzhisaomiao", nil), @"icon_saomiao", @"1ada96a8bdfe03333a8192b32163e7b2", NSLocalizedString(@"sticker_yanzhisaomiao_tip", nil),

            NSLocalizedString(@"sticker_tiezhi", nil), @"icon_tiezhizhuang", @"b6cc340e0e089e2fb96c4a9f9d6ee238", @"",

            NSLocalizedString(@"sticker_caomei", nil), @"icon_caomeizhuang", @"fd5bbc5eae69875246ddde4ebe107132", @"",

            NSLocalizedString(@"sticker_xinhua", nil), @"icon_xinhualufang", @"fe664d3d2cccf9acc524885508b0ea0a", NSLocalizedString(@"sticker_xinhua_tip", nil),

//            NSLocalizedString(@"sticker_wodeshenghao", nil), @"icon_wodeshengao", @"58fdea9d870c6608e0c49b72d77ef95b", NSLocalizedString(@"sticker_wodeshenghao_tip", nil),

            NSLocalizedString(@"sticker_wpikaqiu", nil), @"icon_pikaqiu", @"973855381b6e36fc862848be4eb2d209",NSLocalizedString(@"sticker_pikaqiu_tip", nil),

            NSLocalizedString(@"sticker_pangliang", nil), @"icon_shaonvlian", @"ec7672de92b66fdcca6a0755df0ed199",  NSLocalizedString(@"sticker_panglian_tip", nil),

//            NSLocalizedString(@"sticker_caomei", nil), @"icon_xuejiumao", @"55d13281ffb818ba409ba4185f49a04d", @"",
//            @"开心喵", @"icon_xuejiumao", @"55d13281ffb818ba409ba4185f49a04d", @"",

            NSLocalizedString(@"sticker_pikaqiu2", nil), @"icon_pikaqweiba", @"d8399c8dfcf73e829cd608e549de4d7d", NSLocalizedString(@"sticker_pikaqiu2_tip", nil),

            NSLocalizedString(@"sticker_bixintu", nil), @"icon_bixintu", @"752cb99a67bc396852e95d86e5da0d66", NSLocalizedString(@"sticker_bixintu_tip", nil),

            NSLocalizedString(@"sticker_xiaohuahua", nil), @"icon_fenhongxiaohua", @"c1b490a853b627a0e0b99f3f0638d89d", NSLocalizedString(@"sticker_xiaohuahua_tip", nil),

            NSLocalizedString(@"sticker_lentu", nil), @"icon_lentubaby", @"d679ae8fbb673d0133909a67faf1423b", NSLocalizedString(@"sticker_lengtu_tip", nil),

//            @"呀", @"icon_yayaya", @"fc1be604bcbfb5286980e2403088ceb4",
            NSLocalizedString(@"sticker_yanjingli", nil), @"icon_yanjlimdaidongxi", @"006baecf13b35f5f27d099b138383484", NSLocalizedString(@"sticker_yanjingli_tip", nil),

            //@"测试", @"icon_chaiquan", @"785d609238ce49d16a450f67bdc5f3fc",
        ];
    });
}


+ (instancetype)dataManagerWithType:(BEEffectDataManagerType)type {
    BEEffectDataManager *manager = [[self alloc] init];
    manager.type = type;
    return manager;
}

+ (NSArray<BEEffectCategoryModel *> *)effectCategoryModelArray {
    static NSArray *effectCategoryModelArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        effectCategoryModelArray = @[
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabBeauty title:NSLocalizedString(@"tab_face_beautification", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabMakeup title:NSLocalizedString(@"tab_face_makeup", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabFilter title:NSLocalizedString(@"tab_filter", nil)],
                               ];
    });
    return effectCategoryModelArray;
}

+ (NSArray<BEEffectCategoryModel *> *)recognizeCategoryModelArray {
    static NSArray *recognizeCategoryModelArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recognizeCategoryModelArray = @[
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabFace title:NSLocalizedString(@"tab_face", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabGesture title:NSLocalizedString(@"tab_hand", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabBody title:NSLocalizedString(@"tab_body", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabSegmentation title:NSLocalizedString(@"tab_body_cutout", nil)],
                               [BEEffectCategoryModel categoryWithType:BEEffectPanelTabFaceVerify title:NSLocalizedString(@"tab_face_verify", nil)],
                               //[BEEffectCategoryModel categoryWithType:BEEffectPanelTabHumanDistance title:@"距离估计"]
                               ];
    });
    return recognizeCategoryModelArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationQueue = dispatch_queue_create("com.effect.operation.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)fetchDataWithCompletion:(BEEffectDataFetchCompletion)completion {
    switch (self.type) {
        case BEEffectDataManagerTypeFilter:
            [self _fetchFilterDataWithCompletion:completion];
            break;
        case BEEffectDataManagerTypeMakeup:
            [self _fetchMakeupDataWithCompletion:completion];
            break;
        case BEEffectDataManagerTypeSticker:
            [self _fetchStickerDataWithCompletion:completion];
        default:
            break;
    }
}

#pragma mark - Private
- (void) _fetchStickerDataWithCompletion:(BEEffectDataFetchCompletion)completion{
    [self initStickerDict];
    @weakify(self);
    [self runAsync:^{
        @strongify(self);
        
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"StickerResource" ofType:@"bundle"];
        NSString *stickerPath = [resourcePath stringByAppendingPathComponent:@"stickers"];
        NSError *error = nil;
        NSMutableArray <BEEffectStickerGroup *> *stickersGroupArr = [NSMutableArray array];
        BEEffectResponseModel *responseModel = [BEEffectResponseModel new];
        
        NSMutableArray <BEEffectSticker*> * stickerArray = [NSMutableArray array];
        
        BEEffectSticker *clear = [BEEffectSticker new];
        clear.title = NSLocalizedString(@"filter_normal", nil);
        clear.filePath = @"";
        clear.imageName = @"icon_clear";
        clear.toastString = @"";
        
        [stickerArray addObject:clear];

        for (int i = 0; i < stickersArray.count; i += 4){
            BEEffectSticker *sticker = [BEEffectSticker new];
            sticker.title = stickersArray[i];
            sticker.filePath = [stickerPath stringByAppendingPathComponent: stickersArray[i + 2]];
            sticker.imageName = stickersArray[i + 1];
            sticker.toastString = stickersArray[i + 3];

            [stickerArray addObject:sticker];
        }
        
        BEEffectStickerGroup *group = [BEEffectStickerGroup new];
        group.title = @"sticker";
        group.stickers = stickerArray.copy;
        
        [stickersGroupArr addObject:group];
        responseModel.stickerGroup = stickersGroupArr;
        self.responseModel = responseModel;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            BEBLOCK_INVOKE(completion, self.responseModel, error);
        });
    }];
    
}

- (void)_fetchFilterDataWithCompletion:(BEEffectDataFetchCompletion)completion {
    @weakify(self);
    [self runAsync:^{
        @strongify(self);
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"FilterResource" ofType:@"bundle"];
        NSError *error = nil;
        NSArray *filterCategoryResourcePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:&error];
        NSMutableArray *filterGroupArr = [NSMutableArray array];
        BEEffectResponseModel *responseModel = [BEEffectResponseModel new];
        for (NSString *path in filterCategoryResourcePaths) {
            NSString *fullPath = [resourcePath stringByAppendingPathComponent:path];
            NSArray *filterResourcePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullPath error:&error];
            NSMutableArray <BEEffect *>*filterArray = [NSMutableArray array];
            filterResourcePaths = [filterResourcePaths sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
            for (NSString *filterPath in filterResourcePaths) {
                BEEffect *filter = [BEEffect new];
                filter.filePath = [fullPath stringByAppendingPathComponent:filterPath];
                [filterArray addObject:filter];
            }
            if ([path isEqualToString:@"Filter"]) {
                NSArray *filterNames = @[
                                         NSLocalizedString(@"filter_chalk", nil),
                                         NSLocalizedString(@"filter_cream", nil),
                                         NSLocalizedString(@"filter_oxgen", nil),
                                         NSLocalizedString(@"filter_campan", nil),
                                         NSLocalizedString(@"filter_lolita", nil),
                                         NSLocalizedString(@"filter_mitao", nil),
                                         NSLocalizedString(@"filter_makalong", nil),
                                         NSLocalizedString(@"filter_paomo", nil),
                                         NSLocalizedString(@"filter_yinhua", nil),
                                         NSLocalizedString(@"filter_musi", nil),
                                         NSLocalizedString(@"filter_wuyu", nil),
                                         NSLocalizedString(@"filter_beihaidao", nil),
                                         NSLocalizedString(@"filter_riza", nil),
                                         NSLocalizedString(@"filter_xiyatu", nil),
                                         NSLocalizedString(@"filter_jingmi", nil),
                                         NSLocalizedString(@"filter_jiaopian", nil),
                                         NSLocalizedString(@"filter_nuanyang", nil),
                                         NSLocalizedString(@"filter_jiuri", nil),
                                         NSLocalizedString(@"filter_hongchun", nil),
                                         NSLocalizedString(@"filter_julandiao", nil),
                                         NSLocalizedString(@"filter_tuise", nil),
                                         NSLocalizedString(@"filter_heibai", nil),
                                         ];
                NSArray *filterCNName = @[
          @"柔白",@"奶油",@"氧气",@"桔梗",@"洛丽塔",@"蜜桃",@"马卡龙",@"泡沫",@"樱花",@"浅暖",@"物语",
          @"北海道",@"日杂",@"西雅图",@"静谧",@"胶片",@"暖阳",@"旧日",@"红唇",@"橘蓝调",@"褪色",@"黑白"];
                [filterArray enumerateObjectsUsingBlock:^(BEEffect * filter, NSUInteger idx, BOOL * _Nonnull stop) {
                    filter.title = idx < filterNames.count ? filterNames[idx] : @"";
                    filter.imageName = idx < filterCNName.count ? filterCNName[idx] : @"";
                }];
                BEEffect *normal = [BEEffect new];
                normal.title =  NSLocalizedString(@"filter_normal", nil);
                normal.imageName = @"正常";
                normal.filePath = @"";
                [filterArray insertObject:normal atIndex:0];
            }
            BEEffectGroup *group = [BEEffectGroup new];
            group.title = path;
            group.filters = filterArray.copy;
            [filterGroupArr addObject:group];
        }
        responseModel.filterGroups = filterGroupArr;
        self.responseModel = responseModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            BEBLOCK_INVOKE(completion, self.responseModel, error);
        });
    }];
}

- (void)_fetchMakeupDataWithCompletion:(BEEffectDataFetchCompletion)completion {
    @weakify(self);
    [self runAsync:^{
        @strongify(self);
        BEEffectResponseModel *responseModel = [BEEffectResponseModel new];
        NSMutableArray *makeUpModels = [NSMutableArray array];
        
        {//腮红
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpBlushArray()] copy];
            group.title = NSLocalizedString(@"makeup_blusher", nil);
            [makeUpModels addObject:group];
        }
        
        {//口红
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpLipArray()] copy];
            group.title = NSLocalizedString(@"makeup_lip", nil);
            [makeUpModels addObject:group];
        }
        
        {//睫毛
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpEyelashArray()] copy];
            group.title = NSLocalizedString(@"makeup_eyelash", nil);
            [makeUpModels addObject:group];
        }
        
        {//美瞳
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpPupilArray()] copy];
            group.title = NSLocalizedString(@"makeup_pupil", nil);
            [makeUpModels addObject:group];
        }
        
        {//头发
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpHairArray()] copy];
            group.title = NSLocalizedString(@"makeup_hair", nil);
            [makeUpModels addObject:group];
        }
        
        {//眼影
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpEyeshadowArray()] copy];
            group.title = NSLocalizedString(@"makeup_eye", nil);
            [makeUpModels addObject:group];
        }
        
        {//眉毛
            BEEffectFaceMakeUpGroup *group = [BEEffectFaceMakeUpGroup new];
            group.faceMakeUps = [[self _makeUpObjectFromArray:faceMakeUpEyeBrowArray()] copy];
            group.title = NSLocalizedString(@"makeup_eyebrow", nil);
            [makeUpModels addObject:group];
        }
        responseModel.makeUpGroup = [makeUpModels copy];
        self.responseModel = responseModel;
        
        NSError *error = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            BEBLOCK_INVOKE(completion, self.responseModel, error);
        });
    }];
}

- (NSMutableArray*)_makeUpObjectFromArray:(NSArray*) arrays{
    int count = arrays.count;
    NSMutableArray *retArray = [NSMutableArray array];

    for (int i = 0; i < count; i ++){
        NSArray* array = arrays[i];
        BEEffectFaceMakeUp* makeup = [BEEffectFaceMakeUp new];
        
        {
            makeup.title = array[0];
            makeup.filePath = array[1];
            makeup.normalImageName = array[2];
            makeup.selectedImageName = array[3];
            makeup.intensity = 0.0;
        }
        [retArray addObject:makeup];
    }
    return retArray;
    
}
#pragma mark -

- (void)runAsync:(void(^)(void))block {
    dispatch_async(self.operationQueue, ^{
        block ? block() : 0;
    });
}


#pragma mark - faceMakeUpArray
static NSArray *faceMakeUpBlushArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
        @[NSLocalizedString(@"close", nil), @"blush", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
        @[ NSLocalizedString(@"blusher_shaishanghong", nil), @"blush/shaishanghong", @"iconFaceMakeUpBlusherNormal", @"iconFaceMakeUpBlusherSelected"],
        @[NSLocalizedString(@"blusher_weixunfen", nil), @"blush/weixunfen", @"iconFaceMakeUpBlusherNormal", @"iconFaceMakeUpBlusherSelected"],
        @[NSLocalizedString(@"blusher_yuanqiju", nil), @"blush/yuanqiju", @"iconFaceMakeUpBlusherNormal", @"iconFaceMakeUpBlusherSelected"],
        ];
    });
    return array;
}


static NSArray *faceMakeUpEyeBrowArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[NSLocalizedString(@"close", nil), @"eyebrow", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[ NSLocalizedString(@"eyebrow_chunhei", nil), @"eyebrow/chunhei", @"iconFaceMakeUpEyebrowNormal", @"iconFaceMakeUpEyeBrowSelected"],
                  @[NSLocalizedString(@"eyebrow_danhui", nil), @"eyebrow/danhui", @"iconFaceMakeUpEyebrowNormal", @"iconFaceMakeUpEyeBrowSelected"],
                  @[NSLocalizedString(@"eyebrow_ziranhei", nil), @"eyebrow/ziranhei", @"iconFaceMakeUpEyebrowNormal", @"iconFaceMakeUpEyeBrowSelected"],
                  ];
    });
    return array;
}

static NSArray *faceMakeUpEyelashArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[NSLocalizedString(@"close", nil), @"eyelash", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[NSLocalizedString(@"eyelash_nongmi", nil), @"eyelash/nongmi", @"iconFaceMakeUpEyelashNormal", @"iconFaceMakeUpEyelashSelected"],
                  @[NSLocalizedString(@"eyelash_shanxing", nil), @"eyelash/shanxing", @"iconFaceMakeUpEyelashNormal", @"iconFaceMakeUpEyelashSelected"],
                  @[NSLocalizedString(@"eyelash_wumei", nil), @"eyelash/wumei", @"iconFaceMakeUpEyelashNormal", @"iconFaceMakeUpEyelashSelected"],
                  ];
    });
    return array;
}

static NSArray *faceMakeUpEyeshadowArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[NSLocalizedString(@"close", nil), @"eyeshadow", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[NSLocalizedString(@"eye_shaonvfen", nil), @"eyeshadow/shaonvfen", @"iconFaceMakeUpEyeshadowNormal", @"iconFaceMakeUpEyeshadowSelected"],
                  @[NSLocalizedString(@"eye_yanxunzong", nil), @"eyeshadow/yanxunzong", @"iconFaceMakeUpEyeshadowNormal", @"iconFaceMakeUpEyeshadownSelected"],
                  @[NSLocalizedString(@"eye_ziranlan", nil), @"eyeshadow/ziranlan", @"iconFaceMakeUpEyeshadowNormal", @"iconFaceMakeUpEyeshadownSelected"],
                  ];
    });
    return array;
}

static NSArray *faceMakeUpHairArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[NSLocalizedString(@"close", nil), @"hair", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[NSLocalizedString(@"hair_anlan", nil), @"hair/anlan", @"iconHairNormal", @"iconHairSelected"],
                  @[NSLocalizedString(@"hair_molv", nil), @"hair/molv", @"iconHairNormal", @"iconHairSelected"],
                  @[NSLocalizedString(@"hair_shenzong", nil), @"hair/shenzong", @"iconHairNormal", @"iconHairSelected"],
                  ];
    });
    return array;
}


static NSArray *faceMakeUpLipArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[ NSLocalizedString(@"close", nil), @"lip", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[ NSLocalizedString(@"lip_huluopohong", nil), @"lip/huluobohong", @"iconFaceMakeUpLipsNormal", @"iconFaceMakeUpLipsSelected"],
                  @[NSLocalizedString(@"lip_huoliju", nil), @"lip/huoliju", @"iconFaceMakeUpLipsNormal", @"iconFaceMakeUpLipsSelected"],
                  @[NSLocalizedString(@"lip_yingsuhong", nil), @"lip/yingsuhong", @"iconFaceMakeUpLipsNormal", @"iconFaceMakeUpLipsSelected"],
                  ];
    });
    return array;
}

static NSArray *faceMakeUpPupilArray(){
    static NSArray* array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[
                  @[NSLocalizedString(@"close", nil), @"pupil", @"iconCloseButtonNormal", @"iconCloseButtonSelected"],
                  @[ NSLocalizedString(@"pupil_babizi", nil), @"pupil/babizi", @"iconFaceMakeUpPupilNormal", @"iconFaceMakeUpPupilSelected"],
                  @[NSLocalizedString(@"pupil_hunxuelan", nil), @"pupil/hunxuelan", @"iconFaceMakeUpPupilNormal", @"iconFaceMakeUpPupilSelected"],
                  @[ NSLocalizedString(@"pupil_hunxuelv", nil), @"pupil/hunxuelv", @"iconFaceMakeUpPupilNormal", @"iconFaceMakeUpPupilSelected"],
                  ];
    });
    return array;
}

@end
