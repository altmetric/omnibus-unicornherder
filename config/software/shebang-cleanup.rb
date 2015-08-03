#
# Copyright 2012-2014 Chef Software, Inc.
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
#

#
# Use this software definition to fix the shebangs of binaries under embedded/bin
# to point to the embedded Python.
#

name "shebang-cleanup"

default_version "0.0.2"

build do
  block "Update shebangs to point to embedded Python" do
    # Fix the shebang for binaries with shebangs that have:
    # #!/usr/bin/env python
    Dir.glob("#{install_dir}/embedded/bin/*") do |bin_file|
      update_shebang = false
      rest_of_the_file = ""

      File.open(bin_file) do |f|
        shebang = f.readline
        if shebang.start_with?("#!") &&
            shebang.include?("python") &&
            !shebang.include?("#{install_dir}/embedded/bin/python")
          rest_of_the_file = f.read
          update_shebang = true
        end
      end

      if update_shebang
        File.open(bin_file, "w+") do |f|
          f.puts("#!#{install_dir}/embedded/bin/python")
          f.puts(rest_of_the_file)
        end
      end
    end
  end
end
