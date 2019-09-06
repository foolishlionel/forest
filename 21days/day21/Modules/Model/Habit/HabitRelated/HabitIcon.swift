//
//  HabitIcon.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

enum HabitIcon: Int {
    
    // life habits
    case baby = 100
    case bath = 101
    case car = 102
    case cat = 103
    case clean = 104
    case coffee = 105
    case cook = 106
    case cup = 107
    case dog = 108
    case facialCleanser = 109
    case hangClose = 110
    case highBoot = 111
    case lipstick = 112
    case mask = 113
    case moive = 114
    case refuel = 115
    case shoes = 116
    case shop = 117
    case shopcart = 118
    case sleep = 119
    case taobao = 120
    case target = 121
    case toothbrush = 122
    case tv = 123
    case unbrella = 124
    case wakeup = 125
    case washCar = 126
    case wash = 127
    case weather = 128
    
    // health habits
    case apple = 200
    case beat = 201
    case dinner = 202
    case fruit = 203
    case medecine = 204
    case milk = 205
    case moon = 206
    case noCigarette = 207
    case noPlane = 208
    case phone = 209
    case rice = 210
    case salad = 211
    case smokeFree = 212
    case sugarFree = 213
    case suit = 214
    case sun = 215
    case vegetables = 216
    case water = 217
    case weight = 218
    
    // sport habits
    case treadmil = 300
    case badminton = 301
    case basketball = 302
    case bhchcle = 303
    case boxing = 304
    case climb = 305
    case dumbbell = 306
    case football = 307
    case golf = 308
    case manDance = 309
    case womanDance = 310
    case muscle = 311
    case pingpang = 312
    case pushUpDevice = 313
    case pushUp = 314
    case ropeSkip = 315
    case run = 316
    case swim = 317
    case tenis = 318
    case walk = 319
    case yoga = 320
    
    // learn habits
    case music = 400
    case book = 401
    case barChart = 402
    case pieChart = 403
    case bitCoin = 404
    case cashCard = 405
    case dollor = 406
    case draw = 407
    case excel = 408
    case word = 409
    case github = 410
    case guitar = 411
    case news = 412
    case photography = 413
    case ppt = 414
    case ps = 415
    case rmb = 416
    case takeAccount = 417
    case voice = 418
    case wallet = 419
    case writing = 420
    case abc = 421
    
    // emotion habits
    case cakeLarge = 500
    case cakeSmall = 501
    case family = 502
    case game = 503
    case gift = 504
    case heart = 505
    case idea = 506
    case meditation = 507
    case photoAlbum = 508
    case praise = 509
    case rose = 510
    case smile = 511
    case takeNote = 512
    case talk = 513
    case telephone = 514
    
    // other habits
    case banana = 600
    case beer = 601
    case cactiBall = 602
    case cacti = 603
    case calculate = 604
    case calendar = 605
    case camera = 606
    case carrot = 607
    case computer = 608
    case energy = 609
    case fleshiness = 610
    case grape = 611
    case juice = 612
    case lemon = 613
    case mushroom = 614
    case photo = 615
    case position = 616
    case snooker = 617
    case tree = 618
    case callTelephone = 619
    
    
    var stringValue: String {
        switch self {
        // life habits
        case .baby:
            return "icon_life_baby"
        case .bath:
            return "icon_life_bath"
        case .car:
            return "icon_life_car"
        case .cat:
            return "icon_life_cat"
        case .clean:
            return "icon_life_clean"
        case .coffee:
            return "icon_life_coffee"
        case .cook:
            return "icon_life_cook"
        case .cup:
            return "icon_life_cup"
        case .dog:
            return "icon_life_dog"
        case .facialCleanser:
            return "icon_life_facial_cleanser"
        case .hangClose:
            return "icon_life_hang_close"
        case .highBoot:
            return "icon_life_high_boot"
        case .lipstick:
            return "icon_life_lipstick"
        case .mask:
            return "icon_life_mask"
        case .moive:
            return "icon_life_moive"
        case .refuel:
            return "icon_life_refuel"
        case .shoes:
            return "icon_life_shoes"
        case .shop:
            return "icon_life_shop"
        case .shopcart:
            return "icon_life_shopcart"
        case .sleep:
            return "icon_life_sleep"
        case .taobao:
            return "icon_life_taobao"
        case .target:
            return "icon_life_target"
        case .toothbrush:
            // icon_life_tomato
            return "icon_life_toothbrush"
        case .tv:
            return "icon_life_tv"
        case .unbrella:
            return "icon_life_unbrella"
        case .wakeup:
            return "icon_life_wakeup"
        case .washCar:
            return "icon_life_wash_car"
        case .wash:
            return "icon_life_wash"
        case .weather:
            return "icon_life_weather"
            
            
        // sport habits
        case .treadmil:
            return "icon_sport_ treadmill"
        case .badminton:
            return "icon_sport_badminton"
        case .basketball:
            return "icon_sport_basketball"
        case .bhchcle:
            return "icon_sport_bhchcle"
        case .boxing:
            return "icon_sport_boxing"
        case .climb:
            return "icon_sport_climb"
        case .dumbbell:
            return "icon_sport_dumbbell"
        case .football:
            return "icon_sport_football"
        case .golf:
            return "icon_sport_golf"
        case .manDance:
            return "icon_sport_man_dance"
        case .womanDance:
            return "icon_sport_woman_dance"
        case .muscle:
            return "icon_sport_muscle"
        case .pingpang:
            return "icon_sport_pingpang"
        case .pushUpDevice:
            return "icon_sport_push_up_device"
        case .pushUp:
            return "icon_sport_push_up"
        case .ropeSkip:
            return "icon_sport_rope_skip"
        case .run:
            return "icon_sport_run"
        case .swim:
            return "icon_sport_swim"
        case .tenis:
            return "icon_sport_tenis"
        case .walk:
            return "icon_sport_walk"
        case .yoga:
            return "icon_sport_yoga"
            
        // health habits
        case .apple:
            return "icon_health_apple"
        case .beat:
            return "icon_health_beat"
        case .dinner:
            return "icon_health_dinner"
        case .fruit:
            return "icon_health_fruit"
        case .medecine:
            return "icon_health_medecine"
        case .milk:
            return "icon_health_milk"
        case .moon:
            return "icon_health_moon"
        case .noCigarette:
            return "icon_health_no_cigarette"
        case .noPlane:
            return "icon_health_no_plane"
        case .phone:
            return "icon_health_phone"
        case .rice:
            return "icon_health_rice"
        case .salad:
            return "icon_health_salad"
        case .smokeFree:
            return "icon_health_smoke_free"
        case .sugarFree:
            return "icon_health_sugar_free"
        case .suit:
            return "icon_health_suit"
        case .sun:
            return "icon_health_sun"
        case .vegetables:
            return "icon_health_vegetables"
        case .water:
            return "icon_health_water"
        case .weight:
            return "icon_health_weight"
            
        // learn habits
        case .music:
            return "icon_learn_music"
        case .book:
            return "icon_learn_book"
        case .barChart:
            return "icon_learn_bar_chart"
        case .pieChart:
            return "icon_learn_pie_chart"
        case .bitCoin:
            return "icon_learn_bitcoin"
        case .cashCard:
            return "icon_learn_cash_card"
        case .dollor:
            return "icon_learn_dollor"
        case .draw:
            return "icon_learn_draw"
        case .excel:
            return "icon_learn_excel"
        case .word:
            return "icon_learn_word"
        case .github:
            return "icon_learn_github"
        case .guitar:
            return "icon_learn_guitar"
        case .news:
            return "icon_learn_news"
        case .photography:
            return "icon_learn_photography"
        case .ppt:
            return "icon_learn_ppt"
        case .ps:
            return "icon_learn_ps"
        case .rmb:
            return "icon_learn_rmb"
        case .takeAccount:
            return "icon_learn_take_account"
        case .voice:
            return "icon_learn_voice"
        case .wallet:
            return "icon_learn_wallet"
        case .writing:
            return "icon_learn_writing"
        case .abc:
            return "icon_learn_abc"
            
        // emotion habits
        case .cakeLarge:
            return "icon_emotion_cake_large"
        case .cakeSmall:
            return "icon_emotion_cake_small"
        case .family:
            return "icon_emotion_family"
        case .game:
            return "icon_emotion_game"
        case .gift:
            return "icon_emotion_gift"
        case .heart:
            return "icon_emotion_heart"
        case .idea:
            return "icon_emotion_idea"
        case .meditation:
            return "icon_emotion_meditation"
        case .photoAlbum:
            return "icon_emotion_photo_album"
        case .praise:
            return "icon_emotion_praise"
        case .rose:
            return "icon_emotion_rose"
        case .smile:
            return "icon_emotion_smile"
        case .takeNote:
            return "icon_emotion_take_note"
        case .talk:
            return "icon_emotion_talk"
        case .telephone:
            return "icon_emotion_telephone"
            
        // other habits
        case .banana:
            return "icon_other_banana"
        case .beer:
            return "icon_other_beer"
        case .cactiBall:
            return "icon_other_cacti_ball"
        case .cacti:
            return "icon_other_cacti"
        case .calculate:
            return "icon_other_caculate"
        case .calendar:
            return "icon_other_calendar"
        case .camera:
            return "icon_other_camera"
        case .carrot:
            return "icon_other_carrot"
        case .computer:
            return "icon_other_computer"
        case .energy:
            return "icon_other_energy"
        case .fleshiness:
            return "icon_other_fleshiness"
        case .grape:
            return "icon_other_grape"
        case .juice:
            return "icon_other_juice"
        case .lemon:
            return "icon_other_lemon"
        case .mushroom:
            return "icon_other_mushroom"
        case .photo:
            return "icon_other_photo"
        case .position:
            return "icon_other_position"
        case .snooker:
            return "icon_other_snooker"
        case .tree:
            return "icon_other_tree"
        case .callTelephone:
            return "icon_other_telephone"
        }
    }
}

extension HabitIcon: OPEnumableType {
    static var allValues: [HabitIcon] {
        return [.baby, .bath, .car, .cat, .clean,
                .coffee, .cook, .cup, .dog, .facialCleanser,
                .hangClose, .highBoot, .lipstick, .mask, .moive,
                .refuel, .shoes, .shop, .shopcart, .sleep,
                .taobao, .target, .toothbrush, .tv, .unbrella,
                .wakeup, .washCar, .wash, .weather, .treadmil,
                .badminton, .basketball, .bhchcle, .boxing, .climb,
                .dumbbell, .football, .golf, .manDance, .womanDance,
                .muscle, .pingpang, .pushUpDevice, .pushUp, .ropeSkip,
                .run, .swim, .tenis, .walk, .yoga, .apple,
                .beat, .dinner, .fruit, .medecine, .milk,
                .moon, .noCigarette, .noPlane, .phone, .rice,
                .salad, .smokeFree, .sugarFree, .suit, .sun,
                .vegetables, .water, .weight, .music, .book,
                .barChart, .pieChart, .bitCoin, .cashCard, .dollor,
                .draw, .excel, .word, .github, .guitar, .news,
                .photography, .ppt, .ps, .rmb, .takeAccount,
                .voice, .wallet, .writing, .abc, .cakeLarge,
                .cakeSmall, .family, .game, .gift, .heart,
                .idea, .meditation, .photoAlbum, .praise, .rose,
                .smile, .takeNote, .talk, .telephone,
                .banana, .beer, .cactiBall, .cacti, .calculate,
                .calendar, .camera, .carrot, .computer, .energy,
                .fleshiness, .grape, .juice, .lemon, .mushroom,
                .photo, .position, .snooker, .tree, .callTelephone
        ]
    }
}
