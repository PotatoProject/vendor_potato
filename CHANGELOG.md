# Changelog

## v5.2.3 (2022.07.07)
- Merge July security patch - android-12.1.0_r11
- Whitelist some Google apps (Fix breakage caused due to PixelProps)
- Fix "android" boot animation being shown in dark mode
- Fixed inverted volume bar expand icon on Victor and Sam icon pack
- Add back charging ripple 
- Fix suspicious spaces around QS mobile icons 
- Fix QS mobile icon disappearing on the theme switch 
- Slight changes to Potato branding under "Android version" pref
- Remove the "About phone" avatar

## v5.2.2 (2022.06.09)
- Merge June security patch - android-12.1.0_r8
- Add support for QCOM WFD for devices that support it
- Add support for AB Perf mode for devices that support it
- Fix rare MTK IMS crash
- Use AVCProfileMain for screen recorder 
- Fix several QS related bugs
- Fix loading iconpack-based Wellbeing icon

## v5.2.1 (2022.05.03)
- Merge May security patch - android-12.1.0_r5

## v5.2.0 (2022.04.18)
- Initial release based on android-12.1.0_r4 - Android 12L

## v5.1.1 (2022.02.09)
- Merge android-12.0.0_r29 - February security release
- Merge upstream into arm-optimized-routines
- Backported art/bionic patches from master
- Add colors to assistant
- Add unlinked ringtone and notification volumes
- Switch to Ezio's dt2s on lockscreen
- Add dt2s on statusbar
- Add glove mode for supported devices
- Remove aosp battery percentage perf
- Show actual peak refresh rate in smooth display desc
- Bring back good ol iconspacks from dumaloo-release
- Add user avatar in settings
- Add flipendo
- Enable battery stats from Pixel
- Enable smart auto rotate
- Fix adb root breakage
- Use monet colors for Updater
- Kill local updater with fire
- Enable USAP
- Use Gsans for lockscreen clock
- Use monet colors on fingerprint auth ripple anim
- Update Lawnchair to Alpha 5
- Import Lawnicons
- Disable google ota suggestion pop up
- Misc bug fixes & upstream

## v5.1.0 (2022.01.17)
- Merge android-12.0.0_r27 - January security release
- Switch to zlib-ng
- Added full emulator build support
- Backport art optimizations from master
- Disable debug tracing on prod builds
- Fix an issue where model would appear as mainline/qssi on some devices
- Fix an issue where installation would abort on some devices with error code 1
- Fix Enterprise WiFi networks connection
- Fix concurrency issue with BatteryUsageStats
- Fix navbar button hit testing
- Use AVCProfileMain for screen recorder
- Fix ripple animation for side fp devices
- Do not trigger a wake up when hiding lockscreen
- Fallback to global actions if assistant is not available
- Fix an issue in NPMS blockedReasons computation logic
- Fix the case where restricted mode allowed reasons are ignored
- Install seccomp filter even if selinux is permissive
- Add doubletap/longpress power to toggle torch
- Add advance reboot options
- Allow to suppress notifications sound/vibration if screen is on
- Add less boring heads up
- Integrate smartspace and backgesture provider from SystemUIGoogle
- Add volume key music control
- Make require unlocking for sensitive tile optional
- Forward port battery style customisation from dumaloo
- Add heads up qs tile
- Fix keyguard clock/status and AOD layouts without smartspace
- Add settings to toggle the phantom process monitoring in dev options
- Add signature spoofing support
- Forward port good'ol screen off animations
- Updated Lawnchair prebuilts
- Misc upstream and bug fixes

## v5.0.1 (2021.12.30)
- Monet
- Monet customization and color override
- Customize gesture bar size
- DT2S on lockscreen
- Three finger swipe-to-screenshot
- An epic new monet-conforming boot animation
- An even more epic new wallpaper
- A brand new Fries experience
- Good ol' pal Lawnchair, but based on A12
- PixelProps and SafetyNet spoofing (For those who support it)
- Delete action chip on screenshot prompt
- Disable shutter sounds & adjust with ringer volume
- Light mode on QS panel
- Monet colours on power menu
- GMS release for those who support it

## v4.2.3 (2021.09.10)
- Merge tag android-11.0.0_r43 - September security patch
- Disable swap navigation buttons by default
- Enable IORap app launch prefetching
- Update LC 11 to Alpha 6.1

## v4.2.2 (2021.08.06)
- Merge tag android-11.0.0_r40 - August security patch
- Add in-built recovery image for select devices
- Updated prebuilt sounds from RQ1A.201205.011

## v4.2.1 (2021.07.11)
- Merge tag android-11.0.0_r39 - July security patch

## v4.2.0 (2021.06.09)
- Merge tag android-11.0.0_r38 - June security patch
- Update to LC 11 Alpha 5

## v4.1.6 (2021.05.31)
- Switched to user build for releases
- Improve performance in parts of framework
- Adjust ripple animation for immediate feedback
- Add machine learning back gesture provider
- Add blinking stop dot and low quality screen rec options
- Allow adjusting refresh rate for supported devices
- Enable blur on lockscreen's quick setting
- Switched to CAF Gallery and enabled edit button in screenshot diag
- Fixes to backuptool on dynamic devices
- Add ES translations to fries
- Misc bug fixes

## v4.1.5 (2021.05.11)
- Merge tag android-11.0.0_r37 - May security patch
- Update LC 11 to Alpha 4
- Added option to tint qs tile with accent color
- Added option to disable screenshot shutter sound
- Misc bug fixes

## v4.1.4 (2021.04.20)
- Add dark mode to Contacts and overall improvements to Contacts app
- Fix SystemUI crash when using LiveWallpaper with Colored SystemUI
- Fix crash on MediaOuptutReceiver
- Fix background colouring for settings themed icons

## v4.1.3 (2021.04.08)
- April security patch
- Add Portuguese (Brazil) translations to Fries (thanks to @augusto_peress!)
- Add QS color and transparency
- Add SysUI color mode (wallpaper based theming)
- Add pocket mode
- Add NavigationBarMode2ButtonOverlay
- Full emulator build support
- Use seekbar to allow setting arbitrary animation durations
- Improvements to backuptool
- Fixes to Fries

## v4.1.1 (2021.03.31)
- Switch to Lawnchair 11
- Fix lockscreen wallpaper not being set if different from the Home one
- Ask pin for shutdown/reboot on secure lockscreen
- Fixes to Fries

## v4.0.6 (2021.03.16)
- Add network traffic indicator
- Add Smart clock
- Add AOD tile for supported devices
- Add back cutout animation in Fries
- Fixes to Fries

## v4.0.5 (2021.03.08)
- Merge android-11.0.0_r33 - March security patch
- Add DataSwitchTile tile
- Add Quick access Wallet
- Add call recorder for supported devices
- Improve "Conversation" app list
- Various misc bug fixes

## v4.0.4 (2021.03.01)
- Fix AudioFX in Fries
- Add back QS Tile Disco
- Fixed AOD bug
- Add Caffeine tile
- Update drawables of Advanced reboot
- Add multiuser avatar in search bar
- Various misc bug fixes

## v4.0.3 (2021.02.21)
- Use fixed row & column in landscape if media is playing
- Fixed lock icon not changing after system icon pack
- Hide lockscreen media art if media is not playing
- PixelPropsUtils (spoofed build fingerprint to redfin for some apps)
- Implement SmartSpace from redfin
- Advanced reboot option
- Dash charging text for OnePlus devices
- Reset battery stats
- Fix crashes in Updater
- Add back initial DiracSound and MiSound support

## v4.0.2 (2021.02.14)
- Builds will now compile weekly!
- Merge android-11.0.0_r31
- February security patch
- New OTA app
- LTE <-> 4G icon toggle
- Roaming indicator toggle
- VoLTE icon toggle
- Epic improvements to Fries
- 3 finger screenshot
- Pill hide
- Pill sizes
- StatusBar Tuner
- Lockscreen Tuner
- Navbar Tuner
- Improvements to DeskClock
- Disable SafetyNet HW attestation
- Smoother upload and download animations
- Temporarily re-add backuptool
- Add QTI BT for devices that support it
- Switch to GitHub releases for releases

## v4.0.1 (2020.12.24)
- RGB accenter 3.0
- Custom volume panels
- Headsup QS tile
- NFC QS tile
- Notch City
- Show new & current apk version while installing
- Add/remove QS tiles with one click
- Custom clocks
- Bluetooth battery level on StatusBar
- Fixed Wifi QS tile icon in some icon packs
- Delete option in Screenshot UI
- Fixed lags when screen recording for few devices
- Colors to assistant animation
- Battery styles
- Brightness slider tweaks
- QS panel columns and rows
- QS tile title
- Doubletap/longpress power to toggle Flashlight
- Option to enable lockscreen media art with blur control
- Double tap to sleep on lockscreen
- Skip tracks with volume buttons
- Pulse ambient display on new music tracks
- Less boring heads up
- Enabled permission hub
- Per app network isolation option
- Dark theme support in dialer and messaging app
- Google feed integration in launcher
- Double tap to sleep on home screen

## v3.2.0-hotfix (2020.06.19)
- Fix SystemUI crashes with TiledPanel
- Revert wallpaper change for now (fixes issues on some devices)

## v3.2.0 (2020.06.18)
- Added volume panel manager with 4 built in panels
  - AospPanel
  - CompactPanel
  - OreoPanel
  - TiledPanel
- Left volume panel alignment fixes
- Align owner info as per typeclock style
- Option to change navigation pill size to stock, medium & long
- Option to hide navigation pill
- Option to swap navigation buttons when using 3 button layout
- Remove white flash of screenshot in dark mode
- Fix live caption button on left side when using stock volume panel
- Option to hide/show Auto brightness icon in QS panel
- Clock app UI improvements
- Add Snap Camera
- Dialer app dark mode & video call improvements
- Option to unlink ring & notification volume
- Several under the hood improvements

## v3.1.9 (2020.06.04)
- Merge android-10.0.0_r39 - June security patch
- Fixed inactive WiFi icon in custom icon packs
- Fix BT battery level on different icon packs
- Updates to vold
- Fixed up WiFi Display for multiple devices
- Fixes for VirtualDisplay (VDS)
- Enable call recording on a few more devices
- Added 4 new Clock Styles
- Fix notifications overlapping clock on ambient when using TypeClock
- Fixed potential lags during screen recording
- Misc performance and stability improvements

## v3.1.8 (2020.05.19)
- Merge android-10.0.0_r36 - May security patch
- Call recording
- Auto call recording toggle
- Fixed potential lags in some apps
- StatusBar Date string customization
- Disable Bluetooth power off when Airplane mode is toggled
- Bluetooth QS tile panel
- Per-app network restriction
- QS Tile Disco - Colorful QS Tiles
- Battery styles redone in Kotlin: Added text style separately
- Sync battery icon in settings with Statusbar battery icon
- Battery percentage or estimate time on qs panel header
- Partial screenshot improvements
- Ability to record internal/microphone audio in screenrecords
- 3 new system themes!
- AOSP Lockscreen clock styles
- Major improvements to Fries

## v3.1.7 (2020.04.10)
- Merge android-10.0.0_r33 - April security patch
- StatusBar icon toggling (tuner)
- StatusBar battery styles
- StatusBar Clock controls
- Add back statusbar BT battery level
- Add back permission chart
- 3 Finger screenshot
- Fries redesign
- Fix Fries reloading on some settings
- New bootanimation (Thanks @valvze!)
- Face unlock for supported devices
- Instant screenshot
- Fix a few QS color conditions
- ~~Return of the Disco~~ (He's hiding!)

## v3.1.6 (2020.03.31)
- Fix default custom QS colors
- Misc bug fixes
- Screenrecord dialog redesigned like Android R's
- Notification log in Settings
- Dialer dark mode
- QS panel tiles improvements
- Fix data usage display on mobile data QS panel tile
- D I S C O

## v3.1.5 (2020.03.25)
- 3 mode notch switcher
- Network traffic indicator
- Old style mobile data style
- QS tile row & column configuration
- QS tile title visibility
- WiFi, NFC & Mobile Data QS tile Action Panels (on long press)
- AOD & Sync tile improvments
- Statusbar privacy indicator toggle
- Fix lockscreen statusbar padding
- Fix Fries' parser and all getInt calls
- Add compatibility checking (using props) to Fries
- Fix OTA version checking
- UI & UX, and other misc fixes

## v3.1.4 (2020.03.10)
- Merge android-10.0.0_r32 - March security patch
- Show current version & new version of apk during installation (needs aosp package installer only)
- SystemUI crashes fixes
- IMS related changes
- Double tap to wake from AOD improvements
- Padding fixes in statusbar
- Fix powermenu not tracking accent in landscape
- Power button for flashlight improvements
- Fixed potential mess in strings when dirty flashing

## v3.1.3 (2020.02.22)
- Merge android-10.0.0_r29 - February security patch
- Introduce smart clock
- Brightness slider in bottom with auto brightness icon
- Fixed AOD on DT2W
- Burn-in protection
- Micro-G support

## v3.1.2 (2020.02.04)
- Fix multiple device breaking issues of 3.1.1

## v3.1.1 (2020.01.27)
# (Release rolled back)
- Merge android-10.0.0_r25 - January security patch
- Removed build number from QS footer
- NFC tile drawable improvement
- Permission Hub
- Require unlocking to use Airplane, wifi & cellular tile on lockscreen
- Keyguard lock icon improvement
- Volume button to skip tracks
- POSP logo on StatusBar
- Fix lock icon being stuck on AOD
- Double tap on track tile to skip track on ambient
- Caffeine tile
- Double tap to sleep on lockscreen
- Double tap StatusBar to sleep
- Ability to disable/enable lockscreen media art
- Ability to control blur of Media art on lockscreen
- Ability to hide powermenu on secure lockscreen
- Some padding adjustments for media seekbar in Notifications
- Animate MultiUser Avatar on QS footer
- Kill some ugly grey dialogs & match it with dark theme
- StatusBar icon pack
- SystemWide icon shape
- Enable native ScreenRecording
- Advanced Powermenu configuration
- Tint powermenu with accents
- Add ScreenRecord powermenu
- Add partial screenshot on longpress screenshot powermenu
- Added VoLTE (HD) icon
- Ability to choose "4G" or "LTE" on StatusBar
- Fixed margins of settings Searchbar & Conditions
- Fix icon for ring volume in settings
- Fixed some bad strings in settings
- Protect sensitive info in About device
- Removed some unnecessary dropdown in settings
- Added MultiUser Avatar in Searchbar
- Fix multiple issues with Fries, including Play Store updates
- Fix Accenter for selinux enforcing

## v3.1.0 (2019.12.27)
- Fix issues with most devices, mark as stable
- Introduce PotatoFries, the POSP customisation panel written in Flutter
- QS Panel color customisation (custom and wallpaper with opacity)
- Introduce dual-tone acccenter
- Enable build signing for all official devices

## v3.0.0-alpha (2019.09.15)
- Initial Android 10 release
- Alpha/bringup release for select supported devices

## v2.3 (2019.07.19)
- July security patch
- Merge android-9.0.0_r45
- OTA app redo: new design and data architecture
- New system icons thanks to rshbfn!
- New wallpaper
- System-wide adaptive icons (Android Q like)
- Remove screenshot delay
- Long press screenshot option in power menu for partial SS
- Bring back SystemUI demo mode
- Fixed theming of notification self dot
- Reduced the padding between media controls & seekbar
- Seekbar positioning fixes
- Ambient music ticker: fixed text scrolling glitches
- Chiron[Mi Mix 2] builds will be system-as-root

### v2.3 (2019.06.10)
- June security patch
- Update some APNs
- Pixel home button animations improvement
- Detailed view of QS tiles layout fixes
- Option to restrict Wifi/Data of any app
- Lockscreen clocks: Now clock tracks accent
- Q clock: Align owner info with clock
- Q clock: Animate time when it changes
- Advanced location tile
- Aggressive battery fixes
- Oreo panel: Brought back oreo layout
- Oreo panel: Notifications size improvements
- Oreo panel: Added QS colors
- Oreo panel: Fix delayed animations
- Oreo panel: Show network traffic
- Enhanced call blocking function
- Fix data usage detail's text view on Dark/Black theme
- Seekbar to Media notifications
- Migrated to signed builds
- To fix any app FC after dirty flash, use the posp-sign-migrate flashable zip

### v2.3 (2019.05.28)
- Support santoni (Zainudin (ErrorNetwork28))
- May security patch
- android-9.0.0_r37
- Introduced RGB accenter
- Dark theme revamped
- Add new Flatato base theme
- Settings Search bar fixed on Dark/black theme
- Oreo QS Panel
- QS colors fixes
- Update Lawnchair
- Back to SoundPicker 1.0 (for older devices)
- Fix notifications if less notification sound is enabled
- Animate volume panel
- Google sound search tile
- Added Aggressive battery
- Q style Battery icon
- Toggle to disable Album art cover on Lockscreen
- Added Lockscreen Album art filters
- Toggle to hide Lockscreen items (clock & date)
- Added clock styles (accent issue will be addressed in next update)
- POSP logo on statusbar
- Swipe to screenshot improvements
- Lockscreen weather improvements
- Toggle to disable any sim slot
- Added Uptime with deepsleep info
- Moved IMEI info in SIM status
- Improved Ambient ticker layout

### v2.2 (2019.03.31)
- Support sagit [dpatrongomez]
- Support tissot [Keian (TF2Wake)]
- Support vince [4PERTURE]
- Support X00T [BabluS]
- Fix settings icon tinting for all
- Fix QS footer multiuser icon visbility
- Unbreak ambient when heads up is disabled
- Add in statusbar tuner
- Reorder and cleanup Fries
- Upstream changes
- Minor theme fixes
- ???


### v2.2 (2019.03.21)
- Oreo/OOS like persistent QS footer
- Oreo styled settings
- Settings icon tinting
- Fixes and improvements to expanded volume panel
- Minor fixes to camera on some devices
- Hotspot fixed on multiple devices
- Fixes to Lockscreen Weather
- Added more APNs
- Added more translations to Fries
- OTA app layout and behavior fixes


### v2.2 (2019.03.10)
- Merge latest security patch
- android-9.0.0_r34
- Network activity indicators in QS
- New accents
- Add GoogleSans to actionbars
- New default wallpaper - PotatoLand
- Statusbar Bluetooth battery indicator
- Statusbar NFC icon
- Clean up volume panel code
- Fixes to op-gestures on keyguard
- Expandable volume panel
- Initial Flutter and gradle project support in build system
- Full OTA support (WiP, may have small issues; please report)
- Properly support A/B backuptools
- exFAT support
- Theme package installer
