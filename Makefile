CC = clang

IOS_VERSION = 8.3

XCODE_BASE=/Applications/Xcode.app/Contents
SIMULATOR_BASE=$(XCODE_BASE)/Developer/Platforms/iPhoneSimulator.platform
SDK_BASE=$(SIMULATOR_BASE)/Developer/SDKs/iPhoneSimulator$(IOS_VERSION).sdk

CFLAGS = -ObjC -fobjc-arc -fmodules \
		-mios-simulator-version-min=$(IOS_VERSION) \
		-isysroot $(SDK_BASE)

FRAMEWORKS = -framework Foundation -framework UIKit

SRC = $(wildcard *.m) $(wildcard *.mm)

app:
	$(CC) $(CFLAGS) $(SRC) $(FRAMEWORKS)
