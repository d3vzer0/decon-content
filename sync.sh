#!/bin/bash

elastic() {
    TMP_PATH="/tmp/ElasticContent"
    TARGET_PATH="./ElasticContent"
    git clone https://github.com/elastic/detection-rules.git $TMP_PATH
    rm -rf "$TARGET_PATH/detections/"*
    cp -r "$TMP_PATH/rules/"* $TARGET_PATH/detections
}

splunk() {
    TMP_PATH="/tmp/SplunkContent"
    TARGET_PATH="./SplunkContent"
    rm -rf "$TARGET_PATH/detections/"*
    git clone https://github.com/splunk/security_content.git $TMP_PATH
    cp -r "$TMP_PATH/detections/"* $TARGET_PATH/detections && rm -rf $TMP_PATH
}

sigma() {
    TMP_PATH="/tmp/SigmaContent"
    TARGET_PATH="./SigmaContent/"
    git clone https://github.com/SigmaHQ/sigma.git $TMP_PATH
    rm -rf "$TARGET_PATH/detections/"* && rm -rf "$TARGET_PATH/hunting/"*
    cp -r "$TMP_PATH/rules/"* $TARGET_PATH/detections
    cp -r "$TMP_PATH/rules-threat-hunting/"* $TARGET_PATH/hunting && rm -rf $TMP_PATH
}

sentinel() {
    TMP_PATH="/tmp/SentinelContent"
    TARGET_PATH="./SentinelContent"
    git clone --depth=1 https://github.com/Azure/Azure-Sentinel.git $TMP_PATH

    rm -rf "$TARGET_PATH/hunting/original/"* && rm -rf "$TARGET_PATH/hunting/solutions/"*
    find $TMP_PATH/Solutions -name "Hunting Queries" -type d -exec cp -r "{}" ./SentinelContent/hunting/solutions \;
    cp -r "$TMP_PATH/Hunting Queries/"* $TARGET_PATH/hunting/original

    rm -rf "$TARGET_PATH/detections/original/"* && rm -rf "$TARGET_PATH/detections/solutions/"*
    find $TMP_PATH/Solutions -name "Analytic Rules" -type d -exec cp -r "{}" SentinelContent/detections/solutions \;
    cp -r "$TMP_PATH/Detections/"* $TARGET_PATH/detections/original
}

elastic
splunk
sigma
sentinel