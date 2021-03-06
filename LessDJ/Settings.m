//
//  Settings.m
//  LessDJ
//
//  Created by xu xhan on 2/10/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import "Settings.h"

@implementation Settings
static Settings* _gInstance;
@synthesize channelIndex;

- (id)init
{
    if (_gInstance) return _gInstance;
    self = [super init];
    return self;
}

- (void)setupDefaults
{
    //implement by subclass, this method will only be invoked once
    self.channelIndex = 0;
}

+ (void)setupRoutes
{
	//implement by subclass
	[self setupProperty:@"channelIndex" withType:PLSettingTypeInt];    
}


- (int)version
{
	return 1;
}

- (void)migrateFromOldVersion:(int)oldVersion
{
	// implemented by subclass
	// you also need to handle oldVersion might is greater than current version. (happens uninstall and reinstall an older version apps)
    
    //Note: have to call this if  isNonDynamicProperties
    [self _writePropertiesToDefaults];
}

+ (Settings*)singleton
{
	if (!_gInstance) {
		_gInstance = [[[self class] alloc] init];
        [_gInstance synchronize];
        _gInstance.isDynamicProperties = NO;
	}
	return _gInstance;
}

@end

Settings* AppSetting()
{
    return [Settings singleton];
}