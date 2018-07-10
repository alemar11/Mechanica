#TODO: https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4_2.md
TEST_RESOURCE_FILE = ./Tests/Resources/Resource.swift
APPKIT_TESTS_FOLDER = ./Tests/AppKitTests
UIKIT_TESTS_FOLDER = ./Tests/UIKitTests
SHARED_TESTS_FOLDER = ./Tests/SharedTests
COPIED_RESOURCE_FILENAME = _Resources.swift

copyResources:
	cp ${TEST_RESOURCE_FILE} ${APPKIT_TESTS_FOLDER}/${COPIED_RESOURCE_FILENAME}
	cp ${TEST_RESOURCE_FILE} ${UIKIT_TESTS_FOLDER}/${COPIED_RESOURCE_FILENAME}
	cp ${TEST_RESOURCE_FILE} ${SHARED_TESTS_FOLDER}/${COPIED_RESOURCE_FILENAME}