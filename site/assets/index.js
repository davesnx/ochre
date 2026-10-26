(() => {
  const THEME_STORAGE_KEY = "ochre.docs.theme";
  const root = document.documentElement;
  const themeToggleButton = document.querySelector("[data-doc-theme-toggle]");
  const navToggle = document.getElementById("nav-toggle");
  const sidebarEl = document.getElementById("doc-sidebar");
  const hamburgerLabel = document.querySelector(".nav-hamburger");

  const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");

  const normalizeTheme = (value) => (value === "light" || value === "dark" ? value : null);

  const systemTheme = () => (prefersDarkScheme.matches ? "dark" : "light");

  const effectiveTheme = () => {
    const activeTheme = normalizeTheme(root.getAttribute("data-doc-theme"));
    if (activeTheme) {
      return activeTheme;
    }

    return systemTheme();
  };

  const updateThemeToggle = () => {
    if (!themeToggleButton) {
      return;
    }

    const theme = effectiveTheme();
    const nextTheme = theme === "dark" ? "light" : "dark";
    themeToggleButton.setAttribute("data-theme", theme);
    themeToggleButton.setAttribute("aria-pressed", theme === "dark" ? "true" : "false");
    themeToggleButton.setAttribute("aria-label", `Switch to ${nextTheme} theme`);
    themeToggleButton.setAttribute("title", `Switch to ${nextTheme} theme`);
  };

  const applyTheme = (theme) => {
    if (theme === "light" || theme === "dark") {
      root.setAttribute("data-doc-theme", theme);
    }

    updateThemeToggle();
  };

  const rememberedTheme = normalizeTheme(localStorage.getItem(THEME_STORAGE_KEY));
  applyTheme(rememberedTheme ?? systemTheme());

  const onSystemThemeChange = () => {
    if (!normalizeTheme(localStorage.getItem(THEME_STORAGE_KEY))) {
      applyTheme(systemTheme());
    }
  };

  if (typeof prefersDarkScheme.addEventListener === "function") {
    prefersDarkScheme.addEventListener("change", onSystemThemeChange);
  } else {
    prefersDarkScheme.addListener(onSystemThemeChange);
  }

  if (themeToggleButton) {
    themeToggleButton.addEventListener("click", () => {
      const nextTheme = effectiveTheme() === "dark" ? "light" : "dark";
      localStorage.setItem(THEME_STORAGE_KEY, nextTheme);
      applyTheme(nextTheme);
    });
  }

  // Mobile drawer: ARIA wiring, focus management, link-click close, Esc close.
  if (navToggle && sidebarEl && hamburgerLabel) {
    const syncDrawerAria = () => {
      const open = navToggle.checked;
      hamburgerLabel.setAttribute("aria-expanded", open ? "true" : "false");
      sidebarEl.setAttribute("aria-hidden", open ? "false" : "true");
    };

    const closeDrawer = () => {
      if (navToggle.checked) {
        navToggle.checked = false;
        syncDrawerAria();
      }
    };

    // Make the label keyboard-activatable as a button.
    hamburgerLabel.setAttribute("role", "button");
    hamburgerLabel.setAttribute("tabindex", "0");
    syncDrawerAria();

    hamburgerLabel.addEventListener("keydown", (event) => {
      if (event.key === "Enter" || event.key === " ") {
        event.preventDefault();
        navToggle.checked = !navToggle.checked;
        syncDrawerAria();
      }
    });

    navToggle.addEventListener("change", syncDrawerAria);

    // Close on Esc
    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape" && navToggle.checked) {
        closeDrawer();
        // Return focus to the hamburger
        hamburgerLabel.focus();
      }
    });

    // Close on sidebar link click (so navigation feels right on mobile)
    sidebarEl.addEventListener("click", (event) => {
      const anchor = event.target?.closest?.("a[href]");
      if (anchor) {
        closeDrawer();
      }
    });

    // Close drawer when transitioning back to desktop width.
    const desktopMq = window.matchMedia("(min-width: 881px)");
    const onDesktopChange = () => {
      if (desktopMq.matches) closeDrawer();
    };
    if (typeof desktopMq.addEventListener === "function") {
      desktopMq.addEventListener("change", onDesktopChange);
    } else {
      desktopMq.addListener(onDesktopChange);
    }
  }
})();
