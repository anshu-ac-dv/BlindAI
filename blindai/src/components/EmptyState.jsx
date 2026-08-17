import "./EmptyState.css";

const PROMPTS = [
  "Explain a tricky concept simply",
  "Draft a message for me",
  "Help me plan something",
  "Just talk something through",
];

export default function EmptyState({ onPick }) {
  return (
    <div className="empty">
      <div className="empty__mark" aria-hidden="true" />
      <h1 className="empty__title">What's on your mind?</h1>
      <p className="empty__subtitle">
        BlindAI doesn't see anything — no camera, no images, just what you
        type. Start with one of these, or write your own.
      </p>
      <div className="empty__prompts">
        {PROMPTS.map((p) => (
          <button
            key={p}
            type="button"
            className="empty__prompt"
            onClick={() => onPick(p)}
          >
            {p}
          </button>
        ))}
      </div>
    </div>
  );
}
