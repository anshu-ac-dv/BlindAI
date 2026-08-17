import ThemeToggle from "./ThemeToggle";
import "./Header.css";

export default function Header({ isThinking, onClear, hasMessages }) {
  return (
    <header className="header">
      <div className="header__brand">
        <span className={`aperture ${isThinking ? "is-active" : ""}`}>
          <span className="aperture__ring" />
          <span className="aperture__ring aperture__ring--delay" />
          <span className="aperture__core" />
        </span>
        <div className="header__title">
          <span className="header__name">BlindAI</span>
          <span className="header__tagline">it listens, not looks</span>
        </div>
      </div>

      <div className="header__actions">
        {hasMessages && (
          <button type="button" className="header__clear" onClick={onClear}>
            Clear chat
          </button>
        )}
        <ThemeToggle />
      </div>
    </header>
  );
}
