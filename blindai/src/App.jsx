import { useState } from "react";
import { ThemeProvider } from "./context/ThemeContext";
import { useChat } from "./hooks/useChat";
import Header from "./components/Header";
import ChatWindow from "./components/ChatWindow";
import ChatInput from "./components/ChatInput";
import "./App.css";

function AppShell() {
  const { messages, isThinking, error, send, stop, clear } = useChat();
  const [draft, setDraft] = useState("");

  return (
    <div className="app">
      <Header
        isThinking={isThinking}
        onClear={clear}
        hasMessages={messages.length > 0}
      />
      <ChatWindow
        messages={messages}
        isThinking={isThinking}
        error={error}
        onPick={(prompt) => setDraft(prompt)}
      />
      <ChatInput
        onSend={send}
        onStop={stop}
        isThinking={isThinking}
        value={draft}
        onChange={setDraft}
      />
    </div>
  );
}

export default function App() {
  return (
    <ThemeProvider>
      <AppShell />
    </ThemeProvider>
  );
}
