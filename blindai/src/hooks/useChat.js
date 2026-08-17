import { useCallback, useRef, useState } from "react";
import { sendMessage, AnthropicApiError } from "../lib/anthropic";

const API_KEY = import.meta.env.VITE_ANTHROPIC_API_KEY;

let idCounter = 0;
const nextId = () => `msg-${Date.now()}-${idCounter++}`;

export function useChat() {
  const [messages, setMessages] = useState([]);
  const [isThinking, setIsThinking] = useState(false);
  const [error, setError] = useState(null);
  const controllerRef = useRef(null);

  const send = useCallback(
    async (text) => {
      const trimmed = text.trim();
      if (!trimmed || isThinking) return;

      setError(null);
      const userMessage = { id: nextId(), role: "user", content: trimmed };
      const nextMessages = [...messages, userMessage];
      setMessages(nextMessages);
      setIsThinking(true);

      const controller = new AbortController();
      controllerRef.current = controller;

      try {
        const reply = await sendMessage(nextMessages, {
          apiKey: API_KEY,
          signal: controller.signal,
        });
        setMessages((current) => [
          ...current,
          { id: nextId(), role: "assistant", content: reply },
        ]);
      } catch (err) {
        if (err.name === "AbortError") return;
        const message =
          err instanceof AnthropicApiError
            ? err.message
            : "Something went wrong reaching BlindAI. Check your connection and try again.";
        setError(message);
      } finally {
        setIsThinking(false);
        controllerRef.current = null;
      }
    },
    [messages, isThinking]
  );

  const stop = useCallback(() => {
    controllerRef.current?.abort();
  }, []);

  const clear = useCallback(() => {
    setMessages([]);
    setError(null);
  }, []);

  return { messages, isThinking, error, send, stop, clear };
}
