//
//  ObjcReferenceClass.h
//  MixedCode
//
//  Created by Jeff Schroeder on 1/27/22.
//

#import <Foundation/Foundation.h>

// BIG NOTE: Update the Target Membership to Public
//           - or -
//           In build settings on the MixedCode target, drap the ObjcReferenceClass.h from the project folder to the public folder
@interface ObjcReferenceClass : NSObject

@property (nonnull) NSString *stringPublic;
@property (nonnull, nonatomic, strong, readonly) NSString *stringInit;
@property (nullable, nonatomic, strong, readonly) NSString *optionalStringInit;

- (nonnull instancetype)init:(nonnull NSString *)input ;
- (nonnull instancetype)init:(nonnull NSString *)input optional:(nonnull NSString *)optional;

+ (void)publicClassMethodObjc;

- (void)publicInstanceMethodObjc;

@end
