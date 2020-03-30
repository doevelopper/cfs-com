# Copyright 2019, Adrien HL
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

licenses(["notice"])  # Apache 2.0

#package(default_visibility = ["//:__subpackages__"])
package(default_visibility = ["//visibility:public"])

config_setting(
    name = "linux",
    constraint_values = ["@bazel_tools//platforms:linux"],
    visibility = ["//visibility:public"],
)

config_setting(
    name = "freebsd",
    constraint_values = ["@bazel_tools//platforms:freebsd"],
    visibility = ["//visibility:public"],
)

config_setting(
    name = "osx",
    constraint_values = ["@bazel_tools//platforms:osx"],
    visibility = ["//visibility:public"],
)

config_setting(
    name = "windows",
    constraint_values = ["@bazel_tools//platforms:windows"],
    visibility = ["//visibility:public"],
)

