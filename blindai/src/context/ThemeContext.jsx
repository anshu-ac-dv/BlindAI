import { createContext, useContext, useEffect, useState, useMemo } from "react";

const ThemeContext = createContext(null);

function getInitialTheme() {
  const stored = window.localStorage.getItem("blindai-theme");
  if (stored === "light" || stored === "dark") return stored;
  const prefersLight = window.matchMedia?.(
    "(prefers-color-scheme: light)"
  ).matches;
  return prefersLight ? "light" : "dark";
}

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState(getInitialTheme);

  useEffect(() => {
    document.documentElement.setAttribute("data-theme", theme);
    window.localStorage.setItem("blindai-theme", theme);
  }, [theme]);

  const value = useMemo(
    () => ({
      theme,
      toggleTheme: () =>
        setTheme((current) => (current === "dark" ? "light" : "dark")),
      setTheme,
    }),
    [theme]
  );

  return (
    <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
  );
}

export function useTheme() {
  const ctx = useContext(ThemeContext);
  if (!ctx) throw new Error("useTheme must be used within a ThemeProvider");
  return ctx;
}
