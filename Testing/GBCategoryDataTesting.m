//
//  GBCategoryDataTesting.m
//  appledoc
//
//  Created by Tomaz Kragelj on 28.7.10.
//  Copyright (C) 2010 Gentle Bytes. All rights reserved.
//

#import "GBDataObjects.h"

@interface GBCategoryDataTesting : SenTestCase
@end

@implementation GBCategoryDataTesting

#pragma mark Base data merging

- (void)testMergeDataFromObject_shouldMergeImplementationDetails {
	//setup
	GBCategoryData *original = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	[source registerDeclaredFile:@"file"];
	// execute
	[original mergeDataFromObject:source];
	// verify - simple testing here, fully tested in GBModelBaseTesting!
	assertThatInteger([original.declaredFiles count], equalToInteger(1));
}

- (void)testMergeDataFromObject_shouldRaiseExceptionOnDifferentClassName {
	//setup
	GBCategoryData *original = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"AnotherClass"];
	// execute & verify
	STAssertThrows([original mergeDataFromObject:source], nil);
}

- (void)testMergeDataFromObject_shouldRaiseExceptionOnDifferentCategoryName {
	//setup
	GBCategoryData *original = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:@"AnotherCategory" className:@"MyClass"];
	// execute & verify
	STAssertThrows([original mergeDataFromObject:source], nil);
}

#pragma mark Category components merging

- (void)testMergeDataFromObject_categoryShouldMergeAdoptedProtocolsAndPreserveSourceData {
	//setup - only basic handling is done here; details are tested within GBAdoptedProtocolsProviderTesting!
	GBCategoryData *original = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	[original.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P1"]];
	[original.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P2"]];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	[source.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P1"]];
	[source.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P3"]];
	// execute
	[original mergeDataFromObject:source];
	// verify
	assertThatInteger([[original.adoptedProtocols protocols] count], equalToInteger(3));
	assertThatInteger([[source.adoptedProtocols protocols] count], equalToInteger(2));
}

- (void)testMergeDataFromObject_categoryShouldMergeMethodsAndPreserveSourceData {
	//setup - only basic handling is done here; details are tested within GBIvarsProviderTesting!
	GBCategoryData *original = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	[original.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m1", nil]];
	[original.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m2", nil]];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:@"MyCategory" className:@"MyClass"];
	[source.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m1", nil]];
	[source.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m3", nil]];
	// execute
	[original mergeDataFromObject:source];
	// verify
	assertThatInteger([[original.methods methods] count], equalToInteger(3));
	assertThatInteger([[source.methods methods] count], equalToInteger(2));
}

#pragma mark Extension components merging

- (void)testMergeDataFromObject_extensionShouldMergeAdoptedProtocolsAndPreserveSourceData {
	//setup - only basic handling is done here; details are tested within GBAdoptedProtocolsProviderTesting!
	GBCategoryData *original = [GBCategoryData categoryDataWithName:nil className:@"MyClass"];
	[original.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P1"]];
	[original.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P2"]];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:nil className:@"MyClass"];
	[source.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P1"]];
	[source.adoptedProtocols registerProtocol:[GBProtocolData protocolDataWithName:@"P3"]];
	// execute
	[original mergeDataFromObject:source];
	// verify
	assertThatInteger([[original.adoptedProtocols protocols] count], equalToInteger(3));
	assertThatInteger([[source.adoptedProtocols protocols] count], equalToInteger(2));
}

- (void)testMergeDataFromObject_extensionShouldMergeMethodsAndPreserveSourceData {
	//setup - only basic handling is done here; details are tested within GBIvarsProviderTesting!
	GBCategoryData *original = [GBCategoryData categoryDataWithName:nil className:@"MyClass"];
	[original.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m1", nil]];
	[original.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m2", nil]];
	GBCategoryData *source = [GBCategoryData categoryDataWithName:nil className:@"MyClass"];
	[source.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m1", nil]];
	[source.methods registerMethod:[GBTestObjectsRegistry instanceMethodWithNames:@"m3", nil]];
	// execute
	[original mergeDataFromObject:source];
	// verify
	assertThatInteger([[original.methods methods] count], equalToInteger(3));
	assertThatInteger([[source.methods methods] count], equalToInteger(2));
}

@end