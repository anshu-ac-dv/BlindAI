import { useEffect, useRef } from "react";
import MessageBubble from "./MessageBubble";
import TypingIndicator from "./TypingIndicator";
import EmptyState from "./EmptyState";
import "./ChatWindow.css";

export default function ChatWindow({ messages, isThinking, error, onPick }) {
  const endRef = useRef(null);

  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: "smooth", block: "end" });
  }, [messages, isThinking]);

  if (messages.length === 0 && !isThinking) {
    return (
      <div className="chat-window chat-window--empty">
        <EmptyState onPick={onPick} />
      </div>
    );
  }

  return (
    <div className="chat-window">
      <div className="chat-window__inner">
        {messages.map((m) => (
          <MessageBubble key={m.id} role={m.role} content={m.content} />
        ))}
        {isThinking && <TypingIndicator />}
        {error && <div className="chat-window__error">{error}</div>}
        <div ref={endRef} />
      </div>
    </div>
  );
}
