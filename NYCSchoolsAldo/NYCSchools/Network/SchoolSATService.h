//
//  SchoolSATService.h
//  NYCSchools
//
//  Created by mac on 5/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class School;

NS_ASSUME_NONNULL_BEGIN

@interface SchoolSATService : NSObject

+ (instancetype)sharedInstance;

- (void)retrieveSAT:(void (^)(NSArray<School *> *))completion;

@end

NS_ASSUME_NONNULL_END
