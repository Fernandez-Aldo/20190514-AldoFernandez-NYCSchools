//
//  SchoolSATService.m
//  NYCSchools
//
//  Created by mac on 5/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

#import "SchoolSATService.h"
#import "Constants.h"
#import <NYCSchools-Swift.h>

@interface SchoolSATService ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation SchoolSATService

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static SchoolSATService *sharedInstance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (void)retrieveSAT:(void (^)(NSArray<School *> * _Nonnull))completion {
    NSURL *url = [NSURL URLWithString:SAT_RESOURCE];
    
    void (^dataTaskCompletion)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableLeaves
                                                             error:nil];
        
        NSMutableArray *schools = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in results) {
            School *school = [[School alloc] init];
            school.schoolId = dict[@"dbn"];
            school.numOfParticipantsSAT = dict[@"num_of_sat_test_takers"];
            school.critcalReadAvgScoresSAT = dict[@"sat_critical_reading_avg_score"];
            school.mathAvgScoresSAT = dict[@"sat_math_avg_score"];
            school.writingAvgScoresSAT = dict[@"sat_writing_avg_score"];
            school.name = dict[@"school_name"];
            [schools addObject:school];
        }
        completion(schools);
    };
    
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url
                completionHandler:dataTaskCompletion];
    
    [task resume];
}

@end
