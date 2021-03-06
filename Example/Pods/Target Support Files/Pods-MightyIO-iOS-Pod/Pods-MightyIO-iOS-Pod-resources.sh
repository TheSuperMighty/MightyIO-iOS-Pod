#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
          install_resource "../../Pod/Assets/CustomAlertViewController.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_graphic-facebook.png"
                    install_resource "../../Pod/Assets/MIO_graphic-facebook@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-facebook@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-gift-grey.png"
                    install_resource "../../Pod/Assets/MIO_graphic-gift-grey@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-gift-grey@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-heart.png"
                    install_resource "../../Pod/Assets/MIO_graphic-heart@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-heart@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-cal.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-cal@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-cal@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-clock.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-clock@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-clock@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-meal-grey.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-meal-grey@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-icon-meal-grey@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-kid-girl-african-large.png"
                    install_resource "../../Pod/Assets/MIO_graphic-lock.png"
                    install_resource "../../Pod/Assets/MIO_graphic-lock@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-lock@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-drk-pink.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-drk-pink@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-drk-pink@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-light-gray.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-light-gray@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-light-gray@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-pink.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-pink@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-meal-pink@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkArrow.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkArrow@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkArrow@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkCheck.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkCheck@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-pinkCheck@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-plate-grey.png"
                    install_resource "../../Pod/Assets/MIO_graphic-plate-grey@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-plate-grey@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-smWatermark.png"
                    install_resource "../../Pod/Assets/MIO_graphic-smWatermark@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-smWatermark@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-twitterBird.png"
                    install_resource "../../Pod/Assets/MIO_graphic-twitterBird@2x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-twitterBird@3x.png"
                    install_resource "../../Pod/Assets/MIO_graphic-type-endHungerRough@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-astrik.png"
                    install_resource "../../Pod/Assets/MIO_icon-astrik@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-astrik@3x.png"
                    install_resource "../../Pod/Assets/MIO_icon-circle-facebook.png"
                    install_resource "../../Pod/Assets/MIO_icon-circle-facebook@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-circle-facebook@3x.png"
                    install_resource "../../Pod/Assets/MIO_icon-ciricle-twitter.png"
                    install_resource "../../Pod/Assets/MIO_icon-ciricle-twitter@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-ciricle-twitter@3x.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-gray-small.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-gray-small@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-gray-small@3x.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-pink-small.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-pink-small@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-lock-pink-small@3x.png"
                    install_resource "../../Pod/Assets/MIO_icon-new-window-grey.png"
                    install_resource "../../Pod/Assets/MIO_icon-new-window-grey@2x.png"
                    install_resource "../../Pod/Assets/MIO_icon-new-window-grey@3x.png"
                    install_resource "../../Pod/Assets/MIO_InfoViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_placeholdersquare.png"
                    install_resource "../../Pod/Assets/MIO_ShareViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_SummaryViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_SummaryViewController.xib"
                    install_resource "../../Pod/Assets/MIO_tmio-mark-flat-full-color.png"
                    install_resource "../../Pod/Assets/MIO_tmio-mark-flat-full-color@2x.png"
                    install_resource "../../Pod/Assets/MIO_tmio-mark-flat-full-color@3x.png"
                    install_resource "../../Pod/Assets/MIO_tmio-mark-small.png"
                    install_resource "../../Pod/Assets/MIO_tmio-mark-small@2x.png"
                    install_resource "../../Pod/Assets/MIO_tmio-ribbon-online.png"
                    install_resource "../../Pod/Assets/MIO_tmio-ribbon-online@2x.png"
                    install_resource "../../Pod/Assets/MIO_tmio-ribbon.png"
                    install_resource "../../Pod/Assets/MIO_tmio-ribbon@2x.png"
                    install_resource "../../Pod/Assets/MIO_tmio-ribbon@3x.png"
                    install_resource "../../Pod/Assets/RobotoSlab-Bold.ttf"
                    install_resource "../../Pod/Assets/RobotoSlab-Light.ttf"
                    install_resource "../../Pod/Assets/RobotoSlab-Regular.ttf"
                    install_resource "../../Pod/Assets/RobotoSlab-Thin.ttf"
          
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
