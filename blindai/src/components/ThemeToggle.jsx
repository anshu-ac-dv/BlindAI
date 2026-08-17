import { Moon, Sun } from "lucide-react";
import { useTheme } from "../context/ThemeContext";
import "./ThemeToggle.css";

export default function ThemeToggle() {
  const { theme, toggleTheme } = useTheme();
  const isDark = theme === "dark";

  return (
    <button
      type="button"
      className="theme-toggle"
      onClick={toggleTheme}
      aria-label={`Switch to ${isDark ? "light" : "dark"} mode`}
      title={`Switch to ${isDark ? "light" : "dark"} mode`}
    >
      <span className={`theme-toggle__icon ${isDark ? "" : "is-flipped"}`}>
        {isDark ? <Moon size={16} /> : <Sun size={16} />}
      </span>
    </button>
  );
}
