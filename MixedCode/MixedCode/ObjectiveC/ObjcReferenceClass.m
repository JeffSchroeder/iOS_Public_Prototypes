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
	        SwiftReferenceClass *initSwiftValidation = [[SwiftReferenceClass alloc] init:@"1" :@"2"];
        [initSwiftValidation instancePrintSomething];
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
    [self internalPrintHeader];
    NSLog(@"-- ObjcReferenceClass.publicInstanceMethodObjc()");
    NSLog(@"** Running classMethodSwift()");
    [self instanceMethodOjbc];
    [self printInstanceVariables];
    [self internalPrintTrailer];
}

- (void) publicInstancePrintSomething {
    NSLog(@"-- ObjcReferenceClass.printSomething()");
}

- (void)instanceMethodOjbc {
    NSLog(@"-- ObjcReferenceClass.instanceMethodOjbc()");
}

- (void) printInstanceVariables {
    NSString *s1 = [NSString stringWithFormat:@"- initString:\t\t\t%@",_stringInit];
    NSLog(s1, nil);
    NSString *s2 = [NSString stringWithFormat:@"- initOptionalString:\t\t\t%@",_optionalStringInit];
    NSLog(s2, nil);
    NSString * s3 = [NSString stringWithFormat:@"- initOptionalString:\t\t\t%@",_stringPublic];
    NSLog(s3, nil);
}

- (void)internalPrintHeader {
    NSLog(@"\n-----------------------------------------------------------------------------");
}

- (void)internalPrintTrailer {
    NSLog(@"-----------------------------------------------------------------------------\n");
}

@end
