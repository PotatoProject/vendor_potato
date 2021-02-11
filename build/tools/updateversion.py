#!/usr/bin/env python3

import json
import sys

def main():
    if len(sys.argv) < 2:
        sys.stderr.write('ERROR: You must provide a query!\n')
        sys.exit(1)

    build_num = sys.argv[1]
    data = {}
    with open("vendor/potato/version.json", "r") as read_file:
        data = json.load(read_file)

    data['vernum'] = data['vernum'].split('+')[0] + '+' + build_num
    with open("vendor/potato/version.json", "w") as write_file:
        write_file.write(json.dumps(data, indent=8))


if __name__ == '__main__':
    main()
