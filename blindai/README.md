# BlindAI

A minimal AI chat app built with React + Vite. Talks to the Anthropic API
directly, and remembers your light/dark mode choice.

> "Blind" because it only ever sees what you type — no camera, no image
> input, just conversation.

## Setup

```bash
npm install
cp .env.example .env
# then edit .env and paste in your Anthropic API key
npm run dev
```

Get a key at https://console.anthropic.com/

## ⚠️ Before you deploy this anywhere public

This app calls `api.anthropic.com` straight from the browser, which means
your API key ends up visible in every visitor's network tab. That's fine for
running locally on your own machine, but **do not deploy this as-is** to a
public URL — anyone could copy your key and rack up usage on your account.

For a real deployment, add a tiny backend route (Express, a Vercel/Netlify
function, etc.) that holds the key server-side, and point the `fetch` call in
`src/lib/anthropic.js` at that route instead of Anthropic directly.

## Project structure

```
src/
  components/     UI pieces (header, bubbles, input, theme toggle...)
  context/        ThemeContext — light/dark mode, persisted to localStorage
  hooks/          useChat — message state, sending, cancelling
  lib/            anthropic.js — the API call
```

## Features

- Chat UI with streaming-style typing indicator
- Dark / light mode toggle (persists across reloads, respects system
  preference on first visit)
- Stop-generating control
- Clear chat
- Responsive down to mobile, visible focus states, respects
  `prefers-reduced-motion`

## Scripts

- `npm run dev` — start the dev server
- `npm run build` — production build
- `npm run preview` — preview the production build locally
