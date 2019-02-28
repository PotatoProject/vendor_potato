#!/usr/bin/env python2.7
#
# Copyright (C) 2018, The Potato Open Sauce Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import glob
import hashlib
import json
import os
import subprocess
import sys

try:
    os.remove(os.environ["OUT"] + "/update.json")
except OSError:
    pass

def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

version = "2.1"
android_version = "9"

print "Generating OTA JSON..."
datetime = subprocess.check_output('grep ro\.build\.date\.utc $OUT/system/build.prop | cut -d= -f2', shell=True)
file_list = glob.glob(os.environ["OUT"] + "/potato_" + os.environ["POTATO_BUILD"] + "-" + android_version + "*.zip" );
latest = max(file_list, key=os.path.getctime)
romtype = os.environ["BUILD_TYPE"]

filename = os.path.basename(latest)
md5sum = md5(latest)
size = subprocess.check_output('stat -c%s ' + latest, shell=True)
url = "https://sourceforge.net/projects/posp/files/" + os.environ["POTATO_BUILD"] + "/weeklies/" + filename

update_json = open(os.environ["OUT"] + "/update.json", "w+")
json_output = {
    "response": [
        {
            "datetime": int(datetime),
            "filename": filename,
            "id": md5sum,
            "romtype": romtype.lower(),
            "size": int(size),
            "url": url,
            "version": version
        }
    ]
}

update_json.write(json.dumps(json_output, sort_keys=True, indent=4))
print "OTA configuration available at " + os.environ["OUT"] + "/update.json"
