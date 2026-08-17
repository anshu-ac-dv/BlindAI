import { useEffect, useRef } from "react";
import { ArrowUp, Square } from "lucide-react";
import "./ChatInput.css";

export default function ChatInput({
  onSend,
  onStop,
  isThinking,
  value,
  onChange,
}) {
  const textareaRef = useRef(null);

  useEffect(() => {
    const el = textareaRef.current;
    if (el) {
      el.style.height = "auto";
      el.style.height = `${Math.min(el.scrollHeight, 160)}px`;
    }
  }, [value]);

  const handleChange = (e) => onChange(e.target.value);

  const submit = () => {
    if (!value.trim() || isThinking) return;
    onSend(value);
    onChange("");
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      submit();
    }
  };

  return (
    <div className="chat-input">
      <div className="chat-input__inner">
        <textarea
          ref={textareaRef}
          className="chat-input__field"
          placeholder="Message BlindAI…"
          rows={1}
          value={value}
          onChange={handleChange}
          onKeyDown={handleKeyDown}
        />
        {isThinking ? (
          <button
            type="button"
            className="chat-input__send is-stop"
            onClick={onStop}
            aria-label="Stop generating"
          >
            <Square size={14} />
          </button>
        ) : (
          <button
            type="button"
            className="chat-input__send"
            onClick={submit}
            disabled={!value.trim()}
            aria-label="Send message"
          >
            <ArrowUp size={16} />
          </button>
        )}
      </div>
      <p className="chat-input__hint">
        Enter to send · Shift + Enter for a new line
      </p>
    </div>
  );
}
