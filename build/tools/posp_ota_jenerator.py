import os
import json
import sys

if os.environ["BUILD_TYPE"] not "WEEKLY":
    sys.exit(0)

try:
    os.remove(os.environ["PRODUCT_OUT"] + "/update.json")
except OSError:
    pass

update_json = open(os.environ["PRODUCT_OUT"] + "/update.json", "w+")

datetime = os.system("grep ro\.build\.date\.utc $OUT/system/build.prop | cut -d= -f2")
filename = os.environ["POTATO_VERSION"] + ".zip"
md5 = os.environ["MD5SUM"]
romtype = os.environ["BUILD_TYPE"]
size = os.system("stat -c%s $POTATO_TARGET_PACKAGE")
url = "https://sourceforge.net/projects/posp/files/" + os.environ["PRODUCT_DEVICE"] + "/weeklies/" + os.environ["POTATO_VERSION"] + ".zip"
mantainer = os.environ["POTATO_MANTAINER"]
version = os.environ["POTATO_VERNUM"]

json_output = {
    "response": [
        {
            "datetime": int(datetime),
            "filename": filename,
            "id": md5,
            "romtype": romtype.lower(),
            "size": int(size),
            "url": url,
            "mantainer": mantainer,
            "version": version
        }
    ]
}

update_json.write(json_output)
print "OTA JSON file generated and located at " + os.environ["OUT"] + "/update.json"
