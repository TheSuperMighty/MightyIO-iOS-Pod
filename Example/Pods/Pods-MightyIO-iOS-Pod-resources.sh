#!/bin/sh
set -e

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
install_resource "../../Pod/Assets/btn-back.png"
install_resource "../../Pod/Assets/btn-back@2x.png"
install_resource "../../Pod/Assets/btn-back~ipad.png"
install_resource "../../Pod/Assets/btn-back~ipad@2x.png"
install_resource "../../Pod/Assets/btn-close.png"
install_resource "../../Pod/Assets/btn-close@2x.png"
install_resource "../../Pod/Assets/btn-close~ipad.png"
install_resource "../../Pod/Assets/btn-close~ipad@2x.png"
install_resource "../../Pod/Assets/btnFacebook.png"
install_resource "../../Pod/Assets/btnFacebook@2x.png"
install_resource "../../Pod/Assets/btnTwitter.png"
install_resource "../../Pod/Assets/btnTwitter@2x.png"
install_resource "../../Pod/Assets/gavePlate.png"
install_resource "../../Pod/Assets/gavePlate@2x.png"
install_resource "../../Pod/Assets/GiveViewController-horiz.xib"
install_resource "../../Pod/Assets/GiveViewController.xib"
install_resource "../../Pod/Assets/GiveViewController~ipad-horiz.xib"
install_resource "../../Pod/Assets/GiveViewController~ipad.xib"
install_resource "../../Pod/Assets/hdr-mi.png"
install_resource "../../Pod/Assets/hdr-mi@2x.png"
install_resource "../../Pod/Assets/hdr-mighty-item@2x~ipad.png"
install_resource "../../Pod/Assets/hdr-mighty-item~ipad.png"
install_resource "../../Pod/Assets/hdr-mighy-item.png"
install_resource "../../Pod/Assets/hdr-mighy-item@2x.png"
install_resource "../../Pod/Assets/hdr-mi~ipad.png"
install_resource "../../Pod/Assets/hdr-mi~ipad@2x.png"
install_resource "../../Pod/Assets/hdr-share-screen.png"
install_resource "../../Pod/Assets/hdr-share-screen@2x.png"
install_resource "../../Pod/Assets/hdr-share-screen~ipad.png"
install_resource "../../Pod/Assets/hdr-share-screen~ipad@2x.png"
install_resource "../../Pod/Assets/icon-fb.png"
install_resource "../../Pod/Assets/icon-fb@2x.png"
install_resource "../../Pod/Assets/icon-fb~ipad.png"
install_resource "../../Pod/Assets/icon-fb~ipad@2x.png"
install_resource "../../Pod/Assets/icon-tw.png"
install_resource "../../Pod/Assets/icon-tw@2x.png"
install_resource "../../Pod/Assets/icon-tw~ipad.png"
install_resource "../../Pod/Assets/icon-tw~ipad@2x.png"
install_resource "../../Pod/Assets/img-arrow-light.png"
install_resource "../../Pod/Assets/img-arrow-light@2x.png"
install_resource "../../Pod/Assets/img-arrow.png"
install_resource "../../Pod/Assets/img-arrow@2x.png"
install_resource "../../Pod/Assets/img-check-red.png"
install_resource "../../Pod/Assets/img-check-red@2x.png"
install_resource "../../Pod/Assets/img-check-red~ipad.png"
install_resource "../../Pod/Assets/img-check-red~ipad@2x.png"
install_resource "../../Pod/Assets/img-check.png"
install_resource "../../Pod/Assets/img-check@2x.png"
install_resource "../../Pod/Assets/img-check~ipad.png"
install_resource "../../Pod/Assets/img-check~ipad@2x.png"
install_resource "../../Pod/Assets/img-child.png"
install_resource "../../Pod/Assets/img-child@2x.png"
install_resource "../../Pod/Assets/img-heart.png"
install_resource "../../Pod/Assets/img-heart@2x.png"
install_resource "../../Pod/Assets/img-heart~ipad.png"
install_resource "../../Pod/Assets/img-heart~ipad@2x.png"
install_resource "../../Pod/Assets/img-lock.png"
install_resource "../../Pod/Assets/img-lock@2x.png"
install_resource "../../Pod/Assets/img-lock@2x~ipad.png"
install_resource "../../Pod/Assets/img-lock~ipad.png"
install_resource "../../Pod/Assets/img-next.png"
install_resource "../../Pod/Assets/img-next@2x.png"
install_resource "../../Pod/Assets/img-next~ipad.png"
install_resource "../../Pod/Assets/img-next~ipad@2x.png"
install_resource "../../Pod/Assets/img-plate-light.png"
install_resource "../../Pod/Assets/img-plate-light@2x.png"
install_resource "../../Pod/Assets/img-plate-light~ipad.png"
install_resource "../../Pod/Assets/img-plate-light~ipad@2x.png"
install_resource "../../Pod/Assets/img-plate.png"
install_resource "../../Pod/Assets/img-plate@2x.png"
install_resource "../../Pod/Assets/img-plate~ipad.png"
install_resource "../../Pod/Assets/img-plate~ipad@2x.png"
install_resource "../../Pod/Assets/img-question.png"
install_resource "../../Pod/Assets/img-question@2x.png"
install_resource "../../Pod/Assets/img-question@2x~ipad.png"
install_resource "../../Pod/Assets/img-question~ipad.png"
install_resource "../../Pod/Assets/img-share.png"
install_resource "../../Pod/Assets/img-share@2x.png"
install_resource "../../Pod/Assets/img-share~ipad.png"
install_resource "../../Pod/Assets/img-share~ipad@2x.png"
install_resource "../../Pod/Assets/impact-childhood-hunger.png"
install_resource "../../Pod/Assets/impact-childhood-hunger@2x.png"
install_resource "../../Pod/Assets/impact-childhood-hunger~ipad.png"
install_resource "../../Pod/Assets/impact-childhood-hunger~ipad@2x.png"
install_resource "../../Pod/Assets/impact-children.png"
install_resource "../../Pod/Assets/impact-children@2x.png"
install_resource "../../Pod/Assets/impact-children~ipad.png"
install_resource "../../Pod/Assets/impact-children~ipad@2x.png"
install_resource "../../Pod/Assets/impact-food.png"
install_resource "../../Pod/Assets/impact-food@2x.png"
install_resource "../../Pod/Assets/impact-food~ipad.png"
install_resource "../../Pod/Assets/impact-food~ipad@2x.png"
install_resource "../../Pod/Assets/impact-high-school.png"
install_resource "../../Pod/Assets/impact-high-school@2x.png"
install_resource "../../Pod/Assets/impact-high-school~ipad.png"
install_resource "../../Pod/Assets/impact-high-school~ipad@2x.png"
install_resource "../../Pod/Assets/impact-huger-effects.png"
install_resource "../../Pod/Assets/impact-huger-effects@2x.png"
install_resource "../../Pod/Assets/impact-huger-effects~ipad.png"
install_resource "../../Pod/Assets/impact-huger-effects~ipad@2x.png"
install_resource "../../Pod/Assets/impact-united-states.png"
install_resource "../../Pod/Assets/impact-united-states@2x.png"
install_resource "../../Pod/Assets/impact-united-states~ipad.png"
install_resource "../../Pod/Assets/impact-united-states~ipad@2x.png"
install_resource "../../Pod/Assets/ImpactViewController-horiz.xib"
install_resource "../../Pod/Assets/ImpactViewController.xib"
install_resource "../../Pod/Assets/ImpactViewController~ipad-horiz.xib"
install_resource "../../Pod/Assets/ImpactViewController~ipad.xib"
install_resource "../../Pod/Assets/info-dollars.png"
install_resource "../../Pod/Assets/info-dollars@2x.png"
install_resource "../../Pod/Assets/info-stamps.png"
install_resource "../../Pod/Assets/info-stamps@2x.png"
install_resource "../../Pod/Assets/info-table.png"
install_resource "../../Pod/Assets/info-table@2x.png"
install_resource "../../Pod/Assets/OverviewViewController-horiz.xib"
install_resource "../../Pod/Assets/OverviewViewController.xib"
install_resource "../../Pod/Assets/OverviewViewController~ipad-horiz.xib"
install_resource "../../Pod/Assets/OverviewViewController~ipad.xib"
install_resource "../../Pod/Assets/placeholdersquare.png"
install_resource "../../Pod/Assets/ribbon.png"
install_resource "../../Pod/Assets/ribbon@2x.png"
install_resource "../../Pod/Assets/RobotoSlab-Bold.ttf"
install_resource "../../Pod/Assets/RobotoSlab-Light.ttf"
install_resource "../../Pod/Assets/RobotoSlab-Regular.ttf"
install_resource "../../Pod/Assets/RobotoSlab-Thin.ttf"
install_resource "../../Pod/Assets/ShareViewController-horiz.xib"
install_resource "../../Pod/Assets/ShareViewController.xib"
install_resource "../../Pod/Assets/ShareViewController~ipad-horiz.xib"
install_resource "../../Pod/Assets/ShareViewController~ipad.xib"
install_resource "../../Pod/Assets/SuccessViewController-horiz.xib"
install_resource "../../Pod/Assets/SuccessViewController.xib"
install_resource "../../Pod/Assets/SuccessViewController~ipad-horiz.xib"
install_resource "../../Pod/Assets/SuccessViewController~ipad.xib"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ `xcrun --find actool` ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
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
