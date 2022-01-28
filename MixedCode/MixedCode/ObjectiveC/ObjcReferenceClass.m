//
//  ObjcReferenceClass.m
//  MixedCode
//
//  Created by Jeff Schroeder on 1/27/22.
//

#import "ObjcReferenceClass.h"
#import <MixedCode/MixedCode-Swift.h>

@implementation ObjcReferenceClass

#pragma mark - Public initializers
- (instancetype)init:(nonnull NSString *)input
{
    self = [super init];
    if (self) {
        _stringInit = input;
        _stringPublic = @"ThisIsPublicString";
    }
    return self;
}

- (instancetype)init:(nonnull NSString *)input optional:(nonnull NSString *)optional;
{
    self = [super init];
    if (self) {
        _stringInit = input;
        _optionalStringInit = optional;
        _stringPublic = @"ThisIsPublicString";
    }
    
    return self;
}

#pragma mark - Class functions
+ (void)publicClassMethodObjc {
    [self internalClassPrintHeader];
    NSLog(@"-- ObjcReferenceClass.publicClassMethodString()");
    NSLog(@"** Running classMethodSwift()");
    [self classMethodObjc];
    [self internalClassPrintTrailer];
}

+ (void)classMethodObjc {
    NSLog(@"-- ObjcReferenceClass.privateClassMethod()");
}

+ (void)internalClassPrintHeader {
    NSLog(@"\n*****************************************************************************");
}
+ (void) internalClassPrintTrailer {
    NSLog(@"*****************************************************************************\n");
}


#pragma mark - Instance functions

- (void)publicInstanceMethodObjc {
    
}

- (NSString *)publicInstanceMethodString {
    return @"" ;
}

- (void)internalPrintHeader {
    NSLog(@"\n-----------------------------------------------------------------------------");
}

- (void)internalPrintTrailer {
    NSLog(@"-----------------------------------------------------------------------------\n");
}

@end
