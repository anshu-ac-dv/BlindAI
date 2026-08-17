import "./TypingIndicator.css";

export default function TypingIndicator() {
  return (
    <div className="bubble-row is-assistant">
      <div className="bubble typing">
        <span className="typing__dot" />
        <span className="typing__dot" />
        <span className="typing__dot" />
      </div>
    </div>
  );
}
