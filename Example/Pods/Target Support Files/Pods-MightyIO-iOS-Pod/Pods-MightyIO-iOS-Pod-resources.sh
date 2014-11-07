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
          install_resource "../../Pod/Assets/MIO_btnFacebook.png"
                    install_resource "../../Pod/Assets/MIO_btnFacebook@2x.png"
                    install_resource "../../Pod/Assets/MIO_btnFacebook~ipad.png"
                    install_resource "../../Pod/Assets/MIO_btnFacebook~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_btnTwitter.png"
                    install_resource "../../Pod/Assets/MIO_btnTwitter@2x.png"
                    install_resource "../../Pod/Assets/MIO_btnTwitter~ipad.png"
                    install_resource "../../Pod/Assets/MIO_btnTwitter~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_gavePlate.png"
                    install_resource "../../Pod/Assets/MIO_gavePlate@2x.png"
                    install_resource "../../Pod/Assets/MIO_gavePlate~ipad.png"
                    install_resource "../../Pod/Assets/MIO_gavePlate~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_GiveViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_GiveViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_hdr-mi.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mi@2x.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mighty-item@2x~ipad.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mighty-item~ipad.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mighy-item.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mighy-item@2x.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mi~ipad.png"
                    install_resource "../../Pod/Assets/MIO_hdr-mi~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-heart.png"
                    install_resource "../../Pod/Assets/MIO_img-heart@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-heart~ipad.png"
                    install_resource "../../Pod/Assets/MIO_img-heart~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-lock.png"
                    install_resource "../../Pod/Assets/MIO_img-lock@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-lock~ipad.png"
                    install_resource "../../Pod/Assets/MIO_img-lock~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-plate-light.png"
                    install_resource "../../Pod/Assets/MIO_img-plate-light@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-plate-light~ipad.png"
                    install_resource "../../Pod/Assets/MIO_img-plate-light~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-plate.png"
                    install_resource "../../Pod/Assets/MIO_img-plate@2x.png"
                    install_resource "../../Pod/Assets/MIO_img-plate~ipad.png"
                    install_resource "../../Pod/Assets/MIO_img-plate~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-childhood-hunger.png"
                    install_resource "../../Pod/Assets/MIO_impact-childhood-hunger@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-childhood-hunger~ipad.png"
                    install_resource "../../Pod/Assets/MIO_impact-childhood-hunger~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-children.png"
                    install_resource "../../Pod/Assets/MIO_impact-children@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-children~ipad.png"
                    install_resource "../../Pod/Assets/MIO_impact-children~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-food.png"
                    install_resource "../../Pod/Assets/MIO_impact-food@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-food~ipad.png"
                    install_resource "../../Pod/Assets/MIO_impact-food~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-high-school.png"
                    install_resource "../../Pod/Assets/MIO_impact-high-school@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-high-school~ipad.png"
                    install_resource "../../Pod/Assets/MIO_impact-high-school~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-united-states.png"
                    install_resource "../../Pod/Assets/MIO_impact-united-states@2x.png"
                    install_resource "../../Pod/Assets/MIO_impact-united-states~ipad.png"
                    install_resource "../../Pod/Assets/MIO_impact-united-states~ipad@2x.png"
                    install_resource "../../Pod/Assets/MIO_ImpactViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ImpactViewController.xib"
                    install_resource "../../Pod/Assets/MIO_ImpactViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ImpactViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_InfoViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_OverviewViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_placeholdersquare.png"
                    install_resource "../../Pod/Assets/MIO_ribbon.png"
                    install_resource "../../Pod/Assets/MIO_ribbon@2x.png"
                    install_resource "../../Pod/Assets/MIO_ShareViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_ShareViewController~ipad.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController~ipad-horiz.xib"
                    install_resource "../../Pod/Assets/MIO_SuccessViewController~ipad.xib"
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
