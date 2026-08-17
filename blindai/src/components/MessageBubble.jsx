import "./MessageBubble.css";

export default function MessageBubble({ role, content }) {
  const isUser = role === "user";
  return (
    <div className={`bubble-row ${isUser ? "is-user" : "is-assistant"}`}>
      <div className="bubble">
        <p className="bubble__text">{content}</p>
      </div>
    </div>
  );
}
