//
//  MixedCodeObjcTests.m
//  MixedCodeObjcTests
//
//  Created by Jeff Schroeder on 1/27/22.
//

#import <XCTest/XCTest.h>
#import <MixedCode/MixedCode.h>
#import <MixedCode/MixedCode-Swift.h>

@interface MixedCodeObjcTests : XCTestCase

@end

@implementation MixedCodeObjcTests

- (void)testInObjC {
 
    [SwiftReferenceClass publicClassMethodSwift];
    //[SwiftReferenceClass classMethodSwift];  //<-- Should not be accessible
    //[SwiftReferenceClass internalClassPrintHeader]; //<-- Should not be accessible
    //[SwiftReferenceClass internalClassPrintTrailer]; //<-- Should not be accessible

    SwiftReferenceClass *swiftRefClass = [[SwiftReferenceClass alloc] init:@"RegularInput" : nil ];
    XCTAssertTrue([[swiftRefClass publicString] isEqualToString:@"ThisIsPublicString"]);
    XCTAssertTrue([[swiftRefClass initString] isEqualToString:@"RegularInput"]);
    XCTAssertEqual([swiftRefClass initOptionalString], nil);
    //swiftRefClass.initOptionalString = @"Jelly" //<-- Should not be accessible
    [swiftRefClass publicInstanceMethodSwift];

    swiftRefClass = [[SwiftReferenceClass alloc] init:@"RegularInputAgain" : @"OptionalInput" ];
    swiftRefClass.publicString = @"Yummy";
    XCTAssertTrue([[swiftRefClass publicString] isEqualToString:@"Yummy"]);
    XCTAssertTrue([[swiftRefClass initString] isEqualToString:@"RegularInputAgain"]);
    XCTAssertTrue([[swiftRefClass initOptionalString] isEqualToString:@"OptionalInput"]);
    [swiftRefClass publicInstanceMethodSwift];
    //[swiftRefClassinstanceMethodSwift]; //<-- Should not be accessible

    [ObjcReferenceClass publicClassMethodObjc];
    //[ObjcReferenceClass classMethodObjc];  //<-- Should not be accessible
    //[ObjcReferenceClass internalClassPrintHeader]; //<-- Should not be accessible
    //[ObjcReferenceClass internalClassPrintTrailer]; //<-- Should not be accessible
    
    ObjcReferenceClass *objcRefClass = [[ObjcReferenceClass alloc] init:@"RegularInput"];
    XCTAssertTrue([[objcRefClass stringPublic] isEqualToString:@"ThisIsPublicString"]);
    XCTAssertEqual([objcRefClass optionalStringInit], nil);
    XCTAssertTrue([[objcRefClass stringInit] isEqualToString:@"RegularInput"]);
    [objcRefClass publicInstanceMethodObjc];
    
    objcRefClass = [[ObjcReferenceClass alloc] init:@"RegularInput" optional: @"OptionalInput" ];
    objcRefClass.stringPublic = @"Yummy";
    XCTAssertTrue([[objcRefClass stringPublic] isEqualToString: @"Yummy"]);
    XCTAssertTrue([[objcRefClass optionalStringInit] isEqualToString:@"OptionalInput"]);
    XCTAssertTrue([[objcRefClass stringInit] isEqualToString:@"RegularInput"]);
    [objcRefClass publicInstanceMethodObjc];
}


@end
