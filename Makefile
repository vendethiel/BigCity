FRAMEWORKS = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.3.sdk/System/Library/Frameworks/UIKit.framework/


app:
	clang -F$(FRAMEWORKS)
