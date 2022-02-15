//
//  SwiftReferenceClass.swift
//  MixedCode
//
//  Created by Jeff Schroeder on 1/27/22.
//

import Foundation

@objc
public class SwiftReferenceClass: NSObject {
    // MARK: - Instance variables
    @objc public var publicString = "ThisIsPublicString"
    @objc public private(set) var initString: String              //NOTE: Funny definition for a read only variable
    @objc public private(set) var initOptionalString: String?
        
    // MARK: - Public initializers
    @objc public init(_ input: String, _ optionalInput: String? = nil ){
        initString = input
        initOptionalString = optionalInput
    }
    
    // MARK: - Class methods
    @objc
    public class func publicClassMethodSwift() {
        internalClassPrintHeader()
        print("-- SwiftReferencClass.publicClassMethodSwift()")
        print("** Running classMethodSwift()")
        classMethodSwift()
        internalClassPrintTrailer()
        
        let initObjcValidation = ObjcReferenceClass("Hello")
        initObjcValidation.publicInstancePrintSomething()
    }
    
    // NOTE: This definition is seen as internal
    class func classMethodSwift() {
        print("-- SwiftReferencClass.classMethodSwift()")
    }
    
    internal class func internalClassPrintHeader() {
        print("\n*****************************************************************************")
    }
    internal class func internalClassPrintTrailer() {
        print("*****************************************************************************\n")
    }
    
    // MARK: - Instance methods
    @objc
    public func publicInstanceMethodSwift() {
        internalPrintHeader()
        print("-- SwiftReferencClass.publicInstanceClassMethodSwift()")
        print("** Running instanceMethodSwift()")
        instanceMethodSwift()
        printInstanceVariables()
        internalPrintTrailer()
    }
    
    @objc
    public func instancePrintSomething() {
        print("-- SwiftReferencClass.printSomething()")
    }
    
    // NOTE: This definition is seen as internal
    func instanceMethodSwift() {
        print("-- SwiftReferencClass.instanceMethodSwift()")
    }
    
    internal func printInstanceVariables() {
        print("- initString:\t\t\t\(initString)")
        print("- initOptionalString:\t\(initOptionalString ?? "nil")")
        print("- publicString:\t\t\t\(publicString)")
    }
    
    internal func internalPrintHeader() {
        print("\n-----------------------------------------------------------------------------")
    }
    
    internal func internalPrintTrailer() {
        print("-----------------------------------------------------------------------------\n")
    }
}
