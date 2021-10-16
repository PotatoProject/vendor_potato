#!/usr/bin/env python2.7

import sys

import json
import os
import subprocess

CACHE_FILE = "out/potato-vars"


def is_subdir(a, b):
    a = os.path.realpath(a) + '/'
    b = os.path.realpath(b) + '/'
    return b == a[:len(b)]


def get_build_type(target_product):
    build_type = os.environ['BUILD_TYPE'].strip() if 'BUILD_TYPE' in os.environ else ''
    current_device = '_'.join(target_product.split("_")[1:])
    if build_type == 'CHEESY' or build_type == 'MASHED' or build_type == 'SALAD':
        with open("vendor/potato/devices.json", "r") as read_file:
            devices = json.load(read_file).keys()
            if current_device not in devices:
                build_type = 'Community'
            else:
                build_type = build_type.title()
    else:
        build_type = "Community"
    return build_type


def ensure_path():
    if 'ANDROID_BUILD_TOP' in os.environ:
        top = os.environ['ANDROID_BUILD_TOP']
        if not is_subdir(os.getcwd(), top):
            sys.stderr.write('ERROR: You must run this tool from within $ANDROID_BUILD_TOP!\n')
            sys.exit(1)
        os.chdir(os.environ['ANDROID_BUILD_TOP'])

    if not os.path.isdir('.repo'):
        sys.stderr.write('ERROR: No .repo directory found. Please run this from the top of your tree.\n')
        sys.exit(1)


def handle_query(query, data):
    if query == 'write':
        if os.path.exists(CACHE_FILE):
            handle_query('invalidate', data)
        data['buildtype'] = handle_query('buildtype', data)
        data['version'] = handle_query('version', data)
        with open(CACHE_FILE, 'w') as cf:
            json.dump(data, cf)
    elif query == 'invalidate':
        if os.path.exists(CACHE_FILE):
            os.remove(CACHE_FILE)
    else:
        if os.path.exists(CACHE_FILE):
            with open(CACHE_FILE, 'r') as cf:
                data = json.load(cf)
        if query in data.keys():
            return data[query]
        else:
            if query == 'buildtype':
                return get_build_type(data['product'])
            elif query == 'version':
                return "{}-{}-{}-{}.v{}.{}".format(data['product'], data['platform'], data['date'], data['dish'], data['vernum'],
                                                  get_build_type(data['product']))
            else:
                return ''


def main():
    if len(sys.argv) < 2:
        sys.stderr.write('ERROR: You must provide a query!\n')
        sys.exit(1)

    ensure_path()
    query = sys.argv[1]
    data = {}
    with open("vendor/potato/version.json", "r") as read_file:
        data = json.load(read_file)

    target_product = os.environ['TARGET_PRODUCT'] if 'TARGET_PRODUCT' in os.environ else ''
    date = subprocess.Popen(['date', '-u', '+%Y%m%d'],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT).communicate()[0].strip()
    data['product'] = target_product
    data['device'] = target_product.split("_")[1]
    data['date'] = date
    output = handle_query(query, data)
    if output is not None:
        print(output)


if __name__ == '__main__':
    main()
