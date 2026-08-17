// Minimal client for the Anthropic Messages API.
//
// SECURITY NOTE: this calls api.anthropic.com directly from the browser using
// the "anthropic-dangerous-direct-browser-access" header. That means your API
// key ships to every visitor's browser — fine for local development or a demo
// only you use, but NOT safe for anything you deploy publicly. For production,
// move this fetch call to a small backend/serverless route that holds the key
// server-side and forwards the request.

const API_URL = "https://api.anthropic.com/v1/messages";
const MODEL = "claude-sonnet-4-6";

export class AnthropicApiError extends Error {}

export async function sendMessage(history, { apiKey, signal } = {}) {
  if (!apiKey) {
    throw new AnthropicApiError(
      "Missing API key. Add VITE_ANTHROPIC_API_KEY to your .env file."
    );
  }

  const response = await fetch(API_URL, {
    method: "POST",
    signal,
    headers: {
      "Content-Type": "application/json",
      "x-api-key": apiKey,
      "anthropic-version": "2023-06-01",
      "anthropic-dangerous-direct-browser-access": "true",
    },
    body: JSON.stringify({
      model: MODEL,
      max_tokens: 1024,
      system:
        "You are BlindAI, a calm, direct assistant. Keep answers clear and to the point.",
      messages: history.map(({ role, content }) => ({ role, content })),
    }),
  });

  if (!response.ok) {
    const errBody = await response.json().catch(() => ({}));
    throw new AnthropicApiError(
      errBody?.error?.message || `Request failed with ${response.status}`
    );
  }

  const data = await response.json();
  const text = data.content
    ?.map((block) => (block.type === "text" ? block.text : ""))
    .join("")
    .trim();

  return text || "";
}
