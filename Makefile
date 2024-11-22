#Use this for every path in the build process
BLESONITE_PATH = $(shell pwd)

VARS = $(BLESONITE_PATH)/vars

BLESONITE_BLENDER_VERSION_MAJOR = $(shell cat $(VARS)/BLESONITE_BLENDER_VERSION_MAJOR)
ifeq ($(BLESONITE_BLENDER_VERSION_MAJOR),)

BLESONITE_BLENDER_VERSION_MAJOR=4.3
BLESONITE_BLENDER_VERSION_MINOR=0
$(file >$(VARS)/BLESONITE_BLENDER_VERSION_MAJOR,$(BLESONITE_BLENDER_VERSION_MAJOR))
$(file >$(VARS)/BLESONITE_BLENDER_VERSION_MINOR,$(BLESONITE_BLENDER_VERSION_MINOR))
endif

BLESONITE_BLENDER_VERSION=$(BLESONITE_BLENDER_VERSION_MAJOR).$(BLESONITE_BLENDER_VERSION_MINOR)



dummy := $(shell mkdir -p $(VARS))

BLESONITE_BLENDER_PATH = $(shell cat $(VARS)/BLESONITE_BLENDER_PATH)
ifeq ($(BLESONITE_BLENDER_PATH),)

$(file >$(VARS)/BLESONITE_BLENDER_PATH,$(BLESONITE_PATH)/blender/blender-$(BLESONITE_BLENDER_VERSION)-windows-x64/)
BLESONITE_BLENDER_PATH = $(shell cat $(VARS)/BLESONITE_BLENDER_PATH)

dummy := $(shell mkdir -p $(BLESONITE_PATH)/blender/)
dummy := $(shell unzip blender-$(BLESONITE_BLENDER_VERSION)-windows-x64.zip -d $(BLESONITE_PATH)/blender/)

endif

BLESONITE_BLENDER_INITIALIZED = $(shell cat $(VARS)/BLESONITE_BLENDER_INITIALIZED)
ifneq ($(BLESONITE_BLENDER_INITIALIZED),1)

$(file >$(VARS)/BLESONITE_BLENDER_INITIALIZED,1)
dummy := $(shell wine $(BLESONITE_BLENDER_PATH)/blender.exe -b --python-expr "import pip; pip.main(['install','pythonnet']); pip.main(['install','-U','numpy'])")

endif



all:
	