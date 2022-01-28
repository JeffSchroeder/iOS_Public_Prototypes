//
//  MixedCodeSwiftTests.swift
//  MixedCodeSwiftTests
//
//  Created by Jeff Schroeder on 1/27/22.
//

import XCTest
import MixedCode

class MixedCodeSwiftTests: XCTestCase {

    func testSwiftReferenceClass() throws {
        
        // MARK: - Testing the SwiftReferenceClass
        SwiftReferenceClass.publicClassMethodSwift()
        //SwiftReferencClass.classMethodSwift()  //<-- Should not be accessible
        //SwiftReferencClass.internalClassPrintHeader() //<-- Should not be accessible
        //SwiftReferencClass.internalClassPrintTrailer() //<-- Should not be accessible
        
        var swiftRefClass = SwiftReferenceClass("RegularInput")
        XCTAssertEqual(swiftRefClass.publicString, "ThisIsPublicString")
        XCTAssertEqual(swiftRefClass.initString, "RegularInput")
        XCTAssertEqual(swiftRefClass.initOptionalString, nil)
        //swiftRefClass.initOptionalString = "Jelly" //<-- Should not be accessible
        swiftRefClass.publicInstanceMethodSwift()
        
        swiftRefClass = SwiftReferenceClass("RegularInputAgain","OptionalInput")
        swiftRefClass.publicString = "Yummy"
        XCTAssertEqual(swiftRefClass.publicString, "Yummy")
        XCTAssertEqual(swiftRefClass.initString, "RegularInputAgain")
        XCTAssertEqual(swiftRefClass.initOptionalString, "OptionalInput")
        swiftRefClass.publicInstanceMethodSwift()
        //swiftRefClass.instanceMethodSwift() //<-- Should not be accessible
        
        // MARK: - Testing the ObjcReferenceClass
        ObjcReferenceClass.publicClassMethodObjc()
        //ObjcReferenceClass.classMethodObjc() //<-- Should not be accessible
        //ObjcReferenceClass.internalClassPrintHeader() //<-- Should not be accessible
        //ObjcReferenceClass.internalClassPrintTrailer() //<-- Should not be accessible
        
        var objcRefClass = ObjcReferenceClass("RegularInput")
        XCTAssertEqual(objcRefClass.stringPublic, "ThisIsPublicString")
        XCTAssertEqual(objcRefClass.stringInit, "RegularInput")
        XCTAssertEqual(objcRefClass.optionalStringInit, nil)
        //objcRefClass.initOptionalString = "Jelly" //<-- Should not be accessible
        objcRefClass.publicInstanceMethodObjc()
        
        objcRefClass = ObjcReferenceClass("RegularInputAgain", optional: "OptionalInput")
        objcRefClass.stringPublic = "Yummy"
        XCTAssertEqual(objcRefClass.stringPublic, "Yummy")
        XCTAssertEqual(objcRefClass.stringInit, "RegularInputAgain")
        XCTAssertEqual(objcRefClass.optionalStringInit, "OptionalInput")
        objcRefClass.publicInstanceMethodObjc()
    }
}
