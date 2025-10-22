(() => {
  window.addEventListener("message", (event) => {
    if (event.source !== window.parent) return;

    const message = event.data;
    // Handle theme and language synchronization
    if (message.event === "theme") {
      const isParentDarkMode = message.data === "dark";
      const isChildDarkMode = localStorage.getItem("dark-mode") === "on";
      if (isParentDarkMode !== isChildDarkMode) {
        document.getElementById("dark-mode-toggle")?.click();
      }
    }

    // Handle language synchronization
    else if (message.event === "lang") {
      const isParentEnglish = message.data === "en";
      const isChildEnglish = localStorage.getItem("languageCode")?.startsWith("en");
      if (isParentEnglish !== isChildEnglish) {
        const lang = isParentEnglish ? "en_US" : "zh_CN";
        document.querySelector(`#languageSelection a[data-bs-language-code=${lang}]`)?.click();
      }
    }
  });
})();
