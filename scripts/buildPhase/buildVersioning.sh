#
# Set the build number to the CI_JOB_ID
#

if [[ "${CONFIGURATION}" = *"Release"* ]]; then
 if [[ -z "${CI_JOB_ID}" ]]; then
 		echo "Skipped updating buildnumer, CI_JOB_ID not found"
	else
		buildNumber=$CI_JOB_ID
		/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${INFOPLIST_FILE}"
		/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
		echo "Incremented the build number ${TARGET_BUILD_DIR}/${INFOPLIST_PATH} to ${buildNumber}"
	fi
else 
	echo "Skipped updating the buildnumer, no CONFIGURATION match"
fi
