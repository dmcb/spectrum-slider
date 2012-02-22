//
//  Menu.mm
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "GameScene.h"


@implementation Menu

+ (id)scene {
    CCScene *scene = [CCScene node];
    Menu *layer = [Menu node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {

        // Get dimensions
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        // Set background
        /*
        [CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"menu.png"];
        [texture setAliasTexParameters];
        CCSprite *background = [CCSprite spriteWithTexture:texture];
        background.position = ccp(screenSize.width*0.5, screenSize.height*0.5);
        [self addChild:background];
         */

        // Create main menu
        [CCMenuItemFont setFontName:@"Neuropol"];
        [CCMenuItemFont setFontSize:48];
        CCMenuItem *New = [CCMenuItemFont itemFromString:@"New Game"
                                                  target:self
                                                selector:@selector(goToGameplay:)
        ];
        CCMenuItem *Resume = [CCMenuItemFont itemFromString:@"Resume Game"
                                                     target:self
                                                   selector:@selector(goToGameplay:)
        ];
        CCMenuItem *Options = [CCMenuItemFont itemFromString:@"Options"
                                                      target:self
                                                    selector:@selector(goToGameplay:)
        ];
        CCMenu *menu = [CCMenu menuWithItems:New, Resume, Options, nil];
        [menu alignItemsVerticallyWithPadding:10];
        menu.position = ccp(screenSize.width * 0.5, screenSize.height * 0.5 - 80);
        [self addChild:menu];
    }

    return self;
}

- (void)goToGameplay:(id)sender {

    [[CCDirector sharedDirector]
            replaceScene:[CCTransitionFade
                                 transitionWithDuration:0.5
                                                  scene:[GameScene node]]];
}

@end
