function __print_potato_functions_help() {
cat <<EOF
Additional PotatoROM functions:
- cout:            Changes directory to out.
- mmp:             Builds all of the modules in the current directory and pushes them to the device.
- mmap:            Builds all of the modules in the current directory and its dependencies, then pushes the package to the device.
- mmmp:            Builds all of the modules in the supplied directories and pushes them to the device.
- gerritpush:      Push changes to the gerrit code review server.
- aospremote:      Add git remote for matching AOSP repository.
- cafremote:       Add git remote for matching CodeAurora repository.
- mergeaosptag:    Merge specified AOSP tag to all relevant repos.
- mka:             Builds using SCHED_BATCH on all processors.
- mkap:            Builds the module(s) using mka and pushes them to the device.
- cmka:            Cleans and builds using mka.
- deleteOTA:       Deletes an OTA entry from server API.
- pushOTA:         Pushes OTA data to server API.
- repodiff:        Diff 2 different branches or tags within the same repo
- repolastsync:    Prints date and time of last repo sync.
- reposync:        Parallel repo sync using ionice and SCHED_BATCH.
- repopick:        Utility to fetch changes from Gerrit.
- installboot:     Installs a boot.img to the connected device.
- installrecovery: Installs a recovery.img to the connected device.
- extractjni:      Extracts all jni for given project
EOF
}

function mk_timer()
{
    local start_time=$(date +"%s")
    $@
    local ret=$?
    local end_time=$(date +"%s")
    local tdiff=$(($end_time-$start_time))
    local hours=$(($tdiff / 3600 ))
    local mins=$((($tdiff % 3600) / 60))
    local secs=$(($tdiff % 60))
    local ncolors=$(tput colors 2>/dev/null)
    echo
    if [ $ret -eq 0 ] ; then
        echo -n "#### make completed successfully "
    else
        echo -n "#### make failed to build some targets "
    fi
    if [ $hours -gt 0 ] ; then
        printf "(%02g:%02g:%02g (hh:mm:ss))" $hours $mins $secs
    elif [ $mins -gt 0 ] ; then
        printf "(%02g:%02g (mm:ss))" $mins $secs
    elif [ $secs -gt 0 ] ; then
        printf "(%s seconds)" $secs
    fi
    echo " ####"
    echo
    return $ret
}

function brunch()
{
    breakfast $*
    if [ $? -eq 0 ]; then
        mka potato
    else
        echo "No such item in brunch menu. Try 'breakfast'"
        return 1
    fi
    return $?
}

function breakfast()
{
    target=$1
    local variant=$2
    POTATO_DEVICES_ONLY="true"
    unset LUNCH_MENU_CHOICES
    for f in `/bin/ls vendor/potato/vendorsetup.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
    unset f

    if [ $# -eq 0 ]; then
        # No arguments, so let's have the full menu
        lunch
    else
        echo "z$target" | grep -q "-"
        if [ $? -eq 0 ]; then
            # A buildtype was specified, assume a full device name
            lunch $target
        else
            # This is probably just the Potato model name
            if [ -z "$variant" ]; then
                variant="userdebug"
            fi

            lunch potato_$target-$variant
        fi
    fi
    return $?
}

alias bib=breakfast

function eat()
{
    if [ "$OUT" ] ; then
        ZIPPATH=`ls -tr "$OUT"/potato-*.zip | tail -1`
        if [ ! -f $ZIPPATH ] ; then
            echo "Nothing to eat"
            return 1
        fi
        adb start-server # Prevent unexpected starting server message from adb get-state in the next line
        if [ $(adb get-state) != device -a $(adb shell test -e /sbin/recovery 2> /dev/null; echo $?) != 0 ] ; then
            echo "No device is online. Waiting for one..."
            echo "Please connect USB and/or enable USB debugging"
            until [ $(adb get-state) = device -o $(adb shell test -e /sbin/recovery 2> /dev/null; echo $?) = 0 ];do
                sleep 1
            done
            echo "Device Found.."
        fi
        if (adb shell getprop ro.potato.device | grep -q "$POTATO_BUILD"); then
            # if adbd isn't root we can't write to /cache/recovery/
            adb root
            sleep 1
            adb wait-for-device
            cat << EOF > /tmp/command
--sideload_auto_reboot
EOF
            if adb push /tmp/command /cache/recovery/ ; then
                echo "Rebooting into recovery for sideload installation"
                adb reboot recovery
                adb wait-for-sideload
                adb sideload $ZIPPATH
            fi
            rm /tmp/command
        else
            echo "The connected device does not appear to be $POTATO_BUILD, run away!"
        fi
        return $?
    else
        echo "Nothing to eat"
        return 1
    fi
}

function omnom()
{
    brunch $*
    eat
}

function cout()
{
    if [  "$OUT" ]; then
        cd $OUT
    else
        echo "Couldn't locate out directory.  Try setting OUT."
    fi
}

function dddclient()
{
   local OUT_ROOT=$(get_abs_build_var PRODUCT_OUT)
   local OUT_SYMBOLS=$(get_abs_build_var TARGET_OUT_UNSTRIPPED)
   local OUT_SO_SYMBOLS=$(get_abs_build_var TARGET_OUT_SHARED_LIBRARIES_UNSTRIPPED)
   local OUT_VENDOR_SO_SYMBOLS=$(get_abs_build_var TARGET_OUT_VENDOR_SHARED_LIBRARIES_UNSTRIPPED)
   local OUT_EXE_SYMBOLS=$(get_symbols_directory)
   local PREBUILTS=$(get_abs_build_var ANDROID_PREBUILTS)
   local ARCH=$(get_build_var TARGET_ARCH)
   local GDB
   case "$ARCH" in
       arm) GDB=arm-linux-androideabi-gdb;;
       arm64) GDB=arm-linux-androideabi-gdb; GDB64=aarch64-linux-android-gdb;;
       mips|mips64) GDB=mips64el-linux-android-gdb;;
       x86) GDB=x86_64-linux-android-gdb;;
       x86_64) GDB=x86_64-linux-android-gdb;;
       *) echo "Unknown arch $ARCH"; return 1;;
   esac

   if [ "$OUT_ROOT" -a "$PREBUILTS" ]; then
       local EXE="$1"
       if [ "$EXE" ] ; then
           EXE=$1
           if [[ $EXE =~ ^[^/].* ]] ; then
               EXE="system/bin/"$EXE
           fi
       else
           EXE="app_process"
       fi

       local PORT="$2"
       if [ "$PORT" ] ; then
           PORT=$2
       else
           PORT=":5039"
       fi

       local PID="$3"
       if [ "$PID" ] ; then
           if [[ ! "$PID" =~ ^[0-9]+$ ]] ; then
               PID=`pid $3`
               if [[ ! "$PID" =~ ^[0-9]+$ ]] ; then
                   # that likely didn't work because of returning multiple processes
                   # try again, filtering by root processes (don't contain colon)
                   PID=`adb shell ps | \grep $3 | \grep -v ":" | awk '{print $2}'`
                   if [[ ! "$PID" =~ ^[0-9]+$ ]]
                   then
                       echo "Couldn't resolve '$3' to single PID"
                       return 1
                   else
                       echo ""
                       echo "WARNING: multiple processes matching '$3' observed, using root process"
                       echo ""
                   fi
               fi
           fi
           adb forward "tcp$PORT" "tcp$PORT"
           local USE64BIT="$(is64bit $PID)"
           adb shell gdbserver$USE64BIT $PORT --attach $PID &
           sleep 2
       else
               echo ""
               echo "If you haven't done so already, do this first on the device:"
               echo "    gdbserver $PORT /system/bin/$EXE"
                   echo " or"
               echo "    gdbserver $PORT --attach <PID>"
               echo ""
       fi

       OUT_SO_SYMBOLS=$OUT_SO_SYMBOLS$USE64BIT
       OUT_VENDOR_SO_SYMBOLS=$OUT_VENDOR_SO_SYMBOLS$USE64BIT

       echo >|"$OUT_ROOT/gdbclient.cmds" "set solib-absolute-prefix $OUT_SYMBOLS"
       echo >>"$OUT_ROOT/gdbclient.cmds" "set solib-search-path $OUT_SO_SYMBOLS:$OUT_SO_SYMBOLS/hw:$OUT_SO_SYMBOLS/ssl/engines:$OUT_SO_SYMBOLS/drm:$OUT_SO_SYMBOLS/egl:$OUT_SO_SYMBOLS/soundfx:$OUT_VENDOR_SO_SYMBOLS:$OUT_VENDOR_SO_SYMBOLS/hw:$OUT_VENDOR_SO_SYMBOLS/egl"
       echo >>"$OUT_ROOT/gdbclient.cmds" "source $ANDROID_BUILD_TOP/development/scripts/gdb/dalvik.gdb"
       echo >>"$OUT_ROOT/gdbclient.cmds" "target remote $PORT"
       # Enable special debugging for ART processes.
       if [[ $EXE =~ (^|/)(app_process|dalvikvm)(|32|64)$ ]]; then
          echo >> "$OUT_ROOT/gdbclient.cmds" "art-on"
       fi
       echo >>"$OUT_ROOT/gdbclient.cmds" ""

       local WHICH_GDB=
       # 64-bit exe found
       if [ "$USE64BIT" != "" ] ; then
           WHICH_GDB=$ANDROID_TOOLCHAIN/$GDB64
       # 32-bit exe / 32-bit platform
       elif [ "$(get_build_var TARGET_2ND_ARCH)" = "" ]; then
           WHICH_GDB=$ANDROID_TOOLCHAIN/$GDB
       # 32-bit exe / 64-bit platform
       else
           WHICH_GDB=$ANDROID_TOOLCHAIN_2ND_ARCH/$GDB
       fi

       ddd --debugger $WHICH_GDB -x "$OUT_ROOT/gdbclient.cmds" "$OUT_EXE_SYMBOLS/$EXE"
  else
       echo "Unable to determine build system output dir."
   fi
}

function gerritpush()
{

    GERRIT_URL=review.potatoproject.co;
    DEFAULT_BRANCH=croquette-release;
    PROJECT_PREFIX=;
    ref=for;

    local PROJECT_EXCLUSIONS=(
        "device_qcom_sepolicy"
        "device_potato_sepolicy"
    );

    while getopts "tdb" OPTION; do
      case $OPTION in
        t)
                local USE_TOPIC="true"
                ;;
        d)
                ref=heads
                ;;
        b)      local CUSTOM_BRANCH="true"
                ;;
      esac
    done
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo "fatal: not a git repository (or any of the parent directories): .git"
        return 1
    fi
    local c=$(pwd);
    while [ ! -d ".git" ]; do
      cd ../;
    done;
    if [[ ! -z "${PROJECT_PREFIX}" ]]; then
      PROJECT_PREFIX=$(echo "${PROJECT_PREFIX}_");
    fi
    if (pwd -P | grep -qc "manifests");
    then
        local PROJECT="manifest";
    else
        local PROJECT=${PROJECT_PREFIX}$(echo $(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##") | sed 's/\//_/g');
    fi
    if (echo $PROJECT | grep -qv "^device") || [[ "${PROJECT_EXCLUSIONS[@]}" =~ "$PROJECT" ]]
    then
      local PFX="PotatoProject/";
    else
      local PFX="PotatoDevices/";
    fi
    cd $c;
    if [[ -z "${GERRIT_USER}" ]]; then
      printf 'Enter gerrit username: ';
      read -r GERRIT_USER;
    fi
    export GERRIT_USER;
    if [[ "${CUSTOM_BRANCH}" == true ]]; then
      printf 'Enter branch: ';
      read -r DEFAULT_BRANCH;
    fi
    if [[ "${USE_TOPIC}" == true ]]; then
      printf 'Enter topic: '
      read -r topic;
      git push ssh://${GERRIT_USER}@${GERRIT_URL}:29418/$PFX$PROJECT HEAD:refs/${ref}/${DEFAULT_BRANCH}%topic=${topic};
    else
      git push ssh://${GERRIT_USER}@${GERRIT_URL}:29418/$PFX$PROJECT HEAD:refs/${ref}/${DEFAULT_BRANCH};
    fi
    unset USE_TOPIC;
}

function aospremote()
{
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
        return 1
    fi
    git remote rm aosp 2> /dev/null
    local PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
    # Google moved the repo location in Oreo
    if [ $PROJECT = "build/make" ]
    then
        PROJECT="build"
    fi
    if (echo $PROJECT | grep -qv "^device")
    then
        local PFX="platform/"
    fi
    git remote add aosp https://android.googlesource.com/$PFX$PROJECT
    echo "Remote 'aosp' created"
}

function cafremote()
{
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
        return 1
    fi
    git remote rm caf 2> /dev/null
    local PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
     # Google moved the repo location in Oreo
    if [ $PROJECT = "build/make" ]
    then
        PROJECT="build"
    fi
    if [[ $PROJECT =~ "qcom/opensource" ]];
    then
        PROJECT=$(echo $PROJECT | sed -e "s#qcom\/opensource#qcom-opensource#")
    fi
    if (echo $PROJECT | grep -qv "^device")
    then
        local PFX="platform/"
    fi
    git remote add caf https://source.codeaurora.org/quic/la/$PFX$PROJECT
    echo "Remote 'caf' created"
}

function installboot()
{
    if [ ! -e "$OUT/recovery/root/etc/recovery.fstab" ];
    then
        echo "No recovery.fstab found. Build recovery first."
        return 1
    fi
    if [ ! -e "$OUT/boot.img" ];
    then
        echo "No boot.img found. Run make bootimage first."
        return 1
    fi
    PARTITION=`grep "^\/boot" $OUT/recovery/root/etc/recovery.fstab | awk {'print $3'}`
    if [ -z "$PARTITION" ];
    then
        # Try for RECOVERY_FSTAB_VERSION = 2
        PARTITION=`grep "[[:space:]]\/boot[[:space:]]" $OUT/recovery/root/etc/recovery.fstab | awk {'print $1'}`
        PARTITION_TYPE=`grep "[[:space:]]\/boot[[:space:]]" $OUT/recovery/root/etc/recovery.fstab | awk {'print $3'}`
        if [ -z "$PARTITION" ];
        then
            echo "Unable to determine boot partition."
            return 1
        fi
    fi
    adb start-server
    adb wait-for-online
    adb root
    sleep 1
    adb wait-for-online shell mount /system 2>&1 > /dev/null
    adb wait-for-online remount
    if (adb shell getprop ro.potato.device | grep -q "$POTATO_BUILD");
    then
        adb push $OUT/boot.img /cache/
        if [ -e "$OUT/system/lib/modules/*" ];
        then
            for i in $OUT/system/lib/modules/*;
            do
                adb push $i /system/lib/modules/
            done
            adb shell chmod 644 /system/lib/modules/*
        fi
        adb shell dd if=/cache/boot.img of=$PARTITION
        adb shell rm -rf /cache/boot.img
        echo "Installation complete."
    else
        echo "The connected device does not appear to be $POTATO_BUILD, run away!"
    fi
}

function installrecovery()
{
    if [ ! -e "$OUT/recovery/root/etc/recovery.fstab" ];
    then
        echo "No recovery.fstab found. Build recovery first."
        return 1
    fi
    if [ ! -e "$OUT/recovery.img" ];
    then
        echo "No recovery.img found. Run make recoveryimage first."
        return 1
    fi
    PARTITION=`grep "^\/recovery" $OUT/recovery/root/etc/recovery.fstab | awk {'print $3'}`
    if [ -z "$PARTITION" ];
    then
        # Try for RECOVERY_FSTAB_VERSION = 2
        PARTITION=`grep "[[:space:]]\/recovery[[:space:]]" $OUT/recovery/root/etc/recovery.fstab | awk {'print $1'}`
        PARTITION_TYPE=`grep "[[:space:]]\/recovery[[:space:]]" $OUT/recovery/root/etc/recovery.fstab | awk {'print $3'}`
        if [ -z "$PARTITION" ];
        then
            echo "Unable to determine recovery partition."
            return 1
        fi
    fi
    adb start-server
    adb wait-for-online
    adb root
    sleep 1
    adb wait-for-online shell mount /system 2>&1 >> /dev/null
    adb wait-for-online remount
    if (adb shell getprop ro.potato.device | grep -q "$POTATO_BUILD");
    then
        adb push $OUT/recovery.img /cache/
        adb shell dd if=/cache/recovery.img of=$PARTITION
        adb shell rm -rf /cache/recovery.img
        echo "Installation complete."
    else
        echo "The connected device does not appear to be $POTATO_BUILD, run away!"
    fi
}

function extractjni() {
    for apk in $(find $1 -name "*.apk");
    do
        arch=$(basename $(dirname $apk));
        if [ $arch = "arm" ]; then
            arch="armeabi-v7a";
        elif [ $arch = "arm64" ]; then
            arch="arm64-v8a";
        fi
        unzip -jo $apk "lib/$arch/*" -d $(dirname $apk);
    done;
}

function makerecipe() {
    if [ -z "$1" ]
    then
        echo "No branch name provided."
        return 1
    fi
    cd android
    sed -i s/'default revision=.*'/'default revision="refs\/heads\/'$1'"'/ default.xml
    git commit -a -m "$1"
    cd ..

    repo forall -c '

    if [ "$REPO_REMOTE" = "github" ]
    then
        pwd
        potatoremote
        git push potato HEAD:refs/heads/'$1'
    fi
    '
}

function mka() {
    m -j "$@"
}

function mergeaosptag()
{
  username=PotatoProject
  default_branch=croquette-release

  for var in "$@"
  do
    if [[ "$var" == "-p" ]]; then
      PUSH=true
    fi
  done

  whitelist=(
    device_potato_sepolicy
    device_qcom_sepolicy
    external_json-c
    external_sony_boringssl-compat
    hardware_libhardware_legacy
    hardware_potato_interfaces
    hardware_qcom_power
    manifest
    packages_apps_DUI
    packages_apps_Lean
    packages_apps_Wedges
    vendor_potato
    prebuilts_clang_host_linux-x86
    website
    PotatoBot_tg
  )

  whitelist_detected=();
  conflicts=();

  if [ !$(declare -f croot > /dev/null; echo $?) ]; then
    while [ ! -e './build/envsetup.sh' ]; do
      cd ../;
    done;
    source ./build/envsetup.sh;
  fi;
  croot;

  for repo in $(curl -s https://api.github.com/users/${username}/repos\?per_page\=200 \
    | grep html_url | awk 'NR%2 == 0' | cut -d ':' -f 2-3 | tr -d '",'); do
  {
    for clone_repo in ${whitelist[@]}; do
    {
      if [ "$(echo $repo | cut -d '/' -f 5)" = "$clone_repo" ]
      then
        whitelist_detected+=("$repo");
        continue 2;
      fi
    }
    done;
    echo "";
    echo -e "\e[1;32mUpdating $(echo $repo | cut -d '/' -f 5)...\e[0m";
    cd $(echo $repo | cut -d '/' -f 5 | sed 's/_/\//g');
    aospremote;
    git branch $default_branch;
    git update-ref refs/heads/$default_branch HEAD;
    git checkout $default_branch;
    git pull aosp $1 --no-edit;
    if [[ $? != 0 ]]; then
        conflicts+=("$repo");
    else
        if [[ "$PUSH" == true ]]; then
            gerritpush -d;
        fi
    fi
    croot;
  }
  done;

  echo "";

  for repo in ${whitelist_detected[@]}; do
    echo -e "\e[0;36mIgnored whitelisted repo: \e[0m$(echo $repo)";
  done;

  echo "";

  for repo in ${conflicts[@]}; do
    echo -e "\e[0;31mCONFLICT: \e[0m$(echo $repo)";
  done;

  unset PUSH;
  unset branch;
  unset clone_repo;
  unset conflicts;
  unset remote_name;
  unset repo;
  unset username;
  unset whitelist;
  unset whitelist_detected;
}

function cmka() {
    if [ ! -z "$1" ]; then
        for i in "$@"; do
            case $i in
                potato|otapackage|systemimage)
                    mka installclean
                    mka $i
                    ;;
                *)
                    mka clean-$i
                    mka $i
                    ;;
            esac
        done
    else
        mka clean
        mka
    fi
}

function deleteOTA() {
    if [[ -z "$OTA_API_USER_TOKEN" ]]; then
        echo "Please specify OTA_API_USER_TOKEN!"; return 1
    fi
    if [[ -z "$1" ]]; then
        echo "Please provide build id!";
        echo "Usage: deleteOTA id";
        echo -e "\tid - the id of the build you'd like to delete\n\tfrom the OTA server";
    fi

    curl --header "Authorization: Token $OTA_API_USER_TOKEN" \
        --header "Content-Type: application/json" \
        --request DELETE \
        https://api.potatoproject.co/api/ota/builds/$1/;
}

function pushOTA() {
    OPTIND=1;
    if [[ -z "$OTA_API_USER_TOKEN" ]]; then
        echo "Please specify OTA_API_USER_TOKEN!"; return 1
    fi

    CUSTOM_URL="false";

    while getopts "t" OPTION; do
      case $OPTION in
        t)
            TEST_BUILD="true"
            ;;
      esac
    done

    build_date=$(grep ro\.build\.date\.utc $OUT/system/build.prop | cut -d= -f2);
    device=$(grep ro\.potato\.device $OUT/system/build.prop | cut -d= -f2);
    file=$(ls -t ${OUT}/potato_$device-10* | sed -n 2p);
    md5=$(md5sum $file | awk '{ print $1 }');
    build_type=$(echo $BUILD_TYPE | tr '[:upper:]' '[:lower:]');
    size=$(stat -c%s $file);
    version=$(grep ro\.potato\.vernum $OUT/system/build.prop | cut -d= -f2);
    if [ -z $version ]; then
        version=$(grep ro\.potato\.vernum $OUT/vendor/build.prop | cut -d= -f2)
    fi
    dish=$(grep ro\.potato\.dish $OUT/system/build.prop | cut -d= -f2);
    if [ -z $dish ]; then
        dish=$(grep ro\.potato\.dish $OUT/vendor/build.prop | cut -d= -f2)
    fi
    echo $dish
    notes=""

    if [[ "${USE_NOTES}" == true ]]; then
        if [[ ! (-z "$NOTES") ]]; then
            notes=$NOTES
        fi
    fi

    url="https://sourceforge.net/projects/posp/files/$device/$dish/${file##*/}";
    if [[ "${TEST_BUILD}" == true ]]; then
        url="https://sourceforge.net/projects/posp/files/$device/mashed/${file##*/}";
    fi

    data="{\"build_date\":\"$build_date\", \"device\":\"$device\",\"filename\":\"${file##*/}\",\"md5\":\"$md5\",\"build_type\":\"$build_type\",\"size\":\"$size\",\"url\":\"$url\",\"version\":\"$version\",\"dish\":\"$dish\",\"notes\":\"$notes\"}";

    curl --header "Authorization: Token $OTA_API_USER_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data "$data" \
        https://api.potatoproject.co/api/ota/builds/;
}

function repolastsync() {
    RLSPATH="$ANDROID_BUILD_TOP/.repo/.repo_fetchtimes.json"
    RLSLOCAL=$(date -d "$(stat -c %z $RLSPATH)" +"%e %b %Y, %T %Z")
    RLSUTC=$(date -d "$(stat -c %z $RLSPATH)" -u +"%e %b %Y, %T %Z")
    echo "Last repo sync: $RLSLOCAL / $RLSUTC"
}

function reposync() {
    repo sync -j 4 "$@"
}

function repodiff() {
    if [ -z "$*" ]; then
        echo "Usage: repodiff <ref-from> [[ref-to] [--numstat]]"
        return
    fi
    diffopts=$* repo forall -c \
      'echo "$REPO_PATH ($REPO_REMOTE)"; git diff ${diffopts} 2>/dev/null ;'
}

# Return success if adb is up and not in recovery
function _adb_connected {
    {
        if [[ "$(adb get-state)" == device &&
              "$(adb shell test -e /sbin/recovery; echo $?)" != 0 ]]
        then
            return 0
        fi
    } 2>/dev/null

    return 1
};

# Credit for color strip sed: http://goo.gl/BoIcm
function dopush()
{
    local func=$1
    shift

    adb start-server # Prevent unexpected starting server message from adb get-state in the next line
    if ! _adb_connected; then
        echo "No device is online. Waiting for one..."
        echo "Please connect USB and/or enable USB debugging"
        until _adb_connected; do
            sleep 1
        done
        echo "Device Found."
    fi

    if (adb shell getprop ro.potato.device | grep -q "$POTATO_BUILD") || [ "$FORCE_PUSH" = "true" ];
    then
    # retrieve IP and PORT info if we're using a TCP connection
    TCPIPPORT=$(adb devices \
        | egrep '^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]):[0-9]+[^0-9]+' \
        | head -1 | awk '{print $1}')
    adb root &> /dev/null
    sleep 0.3
    if [ -n "$TCPIPPORT" ]
    then
        # adb root just killed our connection
        # so reconnect...
        adb connect "$TCPIPPORT"
    fi
    adb wait-for-device &> /dev/null
    sleep 0.3
    adb remount &> /dev/null

    mkdir -p $OUT
    ($func $*|tee $OUT/.log;return ${PIPESTATUS[0]})
    ret=$?;
    if [ $ret -ne 0 ]; then
        rm -f $OUT/.log;return $ret
    fi

    is_gnu_sed=`sed --version | head -1 | grep -c GNU`

    # Install: <file>
    if [ $is_gnu_sed -gt 0 ]; then
        LOC="$(cat $OUT/.log | sed -r -e 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' -e 's/^\[ {0,2}[0-9]{1,3}% [0-9]{1,6}\/[0-9]{1,6}\] +//' \
            | grep '^Install: ' | cut -d ':' -f 2)"
    else
        LOC="$(cat $OUT/.log | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" -E "s/^\[ {0,2}[0-9]{1,3}% [0-9]{1,6}\/[0-9]{1,6}\] +//" \
            | grep '^Install: ' | cut -d ':' -f 2)"
    fi

    # Copy: <file>
    if [ $is_gnu_sed -gt 0 ]; then
        LOC="$LOC $(cat $OUT/.log | sed -r -e 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' -e 's/^\[ {0,2}[0-9]{1,3}% [0-9]{1,6}\/[0-9]{1,6}\] +//' \
            | grep '^Copy: ' | cut -d ':' -f 2)"
    else
        LOC="$LOC $(cat $OUT/.log | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" -E 's/^\[ {0,2}[0-9]{1,3}% [0-9]{1,6}\/[0-9]{1,6}\] +//' \
            | grep '^Copy: ' | cut -d ':' -f 2)"
    fi

    # If any files are going to /data, push an octal file permissions reader to device
    if [ -n "$(echo $LOC | egrep '(^|\s)/data')" ]; then
        CHKPERM="/data/local/tmp/chkfileperm.sh"
(
cat <<'EOF'
#!/system/xbin/sh
FILE=$@
if [ -e $FILE ]; then
    ls -l $FILE | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}' | cut -d ' ' -f1
fi
EOF
) > $OUT/.chkfileperm.sh
        echo "Pushing file permissions checker to device"
        adb push $OUT/.chkfileperm.sh $CHKPERM
        adb shell chmod 755 $CHKPERM
        rm -f $OUT/.chkfileperm.sh
    fi

    stop_n_start=false
    for FILE in $(echo $LOC | tr " " "\n"); do
        # Make sure file is in $OUT/system or $OUT/data
        case $FILE in
            $OUT/system/*|$OUT/data/*)
                # Get target file name (i.e. /system/bin/adb)
                TARGET=$(echo $FILE | sed "s#$OUT##")
            ;;
            *) continue ;;
        esac

        case $TARGET in
            /data/*)
                # fs_config only sets permissions and se labels for files pushed to /system
                if [ -n "$CHKPERM" ]; then
                    OLDPERM=$(adb shell $CHKPERM $TARGET)
                    OLDPERM=$(echo $OLDPERM | tr -d '\r' | tr -d '\n')
                    OLDOWN=$(adb shell ls -al $TARGET | awk '{print $2}')
                    OLDGRP=$(adb shell ls -al $TARGET | awk '{print $3}')
                fi
                echo "Pushing: $TARGET"
                adb push $FILE $TARGET
                if [ -n "$OLDPERM" ]; then
                    echo "Setting file permissions: $OLDPERM, $OLDOWN":"$OLDGRP"
                    adb shell chown "$OLDOWN":"$OLDGRP" $TARGET
                    adb shell chmod "$OLDPERM" $TARGET
                else
                    echo "$TARGET did not exist previously, you should set file permissions manually"
                fi
                adb shell restorecon "$TARGET"
            ;;
            /system/priv-app/SystemUI/SystemUI.apk|/system/framework/*)
                # Only need to stop services once
                if ! $stop_n_start; then
                    adb shell stop
                    stop_n_start=true
                fi
                echo "Pushing: $TARGET"
                adb push $FILE $TARGET
            ;;
            *)
                echo "Pushing: $TARGET"
                adb push $FILE $TARGET
            ;;
        esac
    done
    if [ -n "$CHKPERM" ]; then
        adb shell rm $CHKPERM
    fi
    if $stop_n_start; then
        adb shell start
    fi
    rm -f $OUT/.log
    return 0
    else
        echo "The connected device does not appear to be $POTATO_BUILD, run away!"
    fi
}

alias mmp='dopush mm'
alias mmmp='dopush mmm'
alias mmap='dopush mma'
alias mmmap='dopush mmma'
alias mkap='dopush mka'
alias cmkap='dopush cmka'

function repopick() {
    T=$(gettop)
    $T/vendor/potato/build/tools/repopick.py $@
}

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    if [ ! -z $POTATO_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

# Enable SD-LLVM if available
if [ -d $(gettop)/prebuilts/snapdragon-llvm/toolchains ]; then
    case `uname -s` in
        Darwin)
            # Darwin is not supported yet
            ;;
        *)
            export SDCLANG=true
            export SDCLANG_PATH=$(gettop)/prebuilts/snapdragon-llvm/toolchains/llvm-Snapdragon_LLVM_for_Android_4.0/prebuilt/linux-x86_64/bin
            export SDCLANG_PATH_2=$(gettop)/prebuilts/snapdragon-llvm/toolchains/llvm-Snapdragon_LLVM_for_Android_4.0/prebuilt/linux-x86_64/bin
            export SDCLANG_LTO_DEFS=$(gettop)/vendor/potato/build/core/sdllvm-lto-defs.mk
            ;;
    esac
fi

# Android specific JACK args
if [ -n "$JACK_SERVER_VM_ARGUMENTS" ] && [ -z "$ANDROID_JACK_VM_ARGS" ]; then
    export ANDROID_JACK_VM_ARGS=$JACK_SERVER_VM_ARGUMENTS
fi
