//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<device_info_plus/FLTDeviceInfoPlusPlugin.h>)
#import <device_info_plus/FLTDeviceInfoPlusPlugin.h>
#else
@import device_info_plus;
#endif

#if __has_include(<package_info_plus/FLTPackageInfoPlusPlugin.h>)
#import <package_info_plus/FLTPackageInfoPlusPlugin.h>
#else
@import package_info_plus;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTDeviceInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTDeviceInfoPlusPlugin"]];
  [FLTPackageInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlusPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
}

@end
