//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fc_native_video_thumbnail/fc_native_video_thumbnail_plugin_c_api.h>
#include <mecab_for_flutter/mecab_for_flutter_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FcNativeVideoThumbnailPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FcNativeVideoThumbnailPluginCApi"));
  MecabForFlutterPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MecabForFlutterPluginCApi"));
}
