#!/bin/bash

# Check if comment exists
if ! grep -q "<!-- Custom -->" app/core/src/main/resources/templates/fragments/common.html; then
    echo "Error: '<!-- Custom -->' comment not found in common.html"
    exit 1
fi

# Insert patch CSS and JS references after comment (only if not already present)
if ! grep -q "patch.css" app/core/src/main/resources/templates/fragments/common.html; then
    sed -i '/<!-- Custom -->/i\
  <link rel="stylesheet" th:href="@{'"'"'/css/patch.css'"'"'}">\
  <script th:src="@{'"'"'/js/patch.js'"'"'}"></script>\
\
' app/core/src/main/resources/templates/fragments/common.html
fi

# Copy patch files
cp .patch/patch.css app/core/src/main/resources/static/css/patch.css
cp .patch/patch.js app/core/src/main/resources/static/js/patch.js

# Disable analytics prompt by adding return statement (only if not already present)
if ! grep -q "return; // Disable analytics prompt" app/core/src/main/resources/static/js/pages/home.js; then
    sed -i '/if (window\.analyticsPromptBoolean)/i\
  return; // Disable analytics prompt\
\
' app/core/src/main/resources/static/js/pages/home.js
fi

# Check if return http.build(); exists
if ! grep -q "return http.build();" app/proprietary/src/main/java/stirling/software/proprietary/security/configuration/SecurityConfiguration.java; then
    echo "Error: 'return http.build();' not found in SecurityConfiguration.java"
    exit 1
fi

# Insert iframe configuration before return http.build(); (only if not already present)
if ! grep -q "http.headers(headers -> headers.disable())" app/proprietary/src/main/java/stirling/software/proprietary/security/configuration/SecurityConfiguration.java; then
    sed -i '/return http\.build();/i\
\
        // Configure headers to allow iframe embedding\
        http.headers(headers -> headers.disable());\
\
' app/proprietary/src/main/java/stirling/software/proprietary/security/configuration/SecurityConfiguration.java
fi
