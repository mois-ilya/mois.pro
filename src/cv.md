---
title: Ilya Mois — CV
author: Ilya Mois
headline: Senior Full-Stack Engineer · Remote or on-site in Tbilisi, Georgia (GMT+4)
contact: |
  [job.offers@mois.pro](mailto:job.offers@mois.pro) ·
  [github.com/mois-ilya](https://github.com/mois-ilya) ·
  [linkedin.com/in/moisilya](https://www.linkedin.com/in/moisilya) ·
  Russian (native), English (professional)
permalink: /cv
pdf: /Ilya-Mois-CV.pdf
translation:
  href: /cv/ru
  lang: ru
  label: По-русски
alternate:
  - lang: en
    href: /cv
  - lang: ru
    href: /cv/ru
xdefault: /cv
---

## Summary

I have been building web products since 2018, most recently developer platforms and payments. At
Tonkeeper, I owned Tonconsole, TonAPI's developer console, for 21 months, including its billing and
documentation, and maintained TonAPI's TypeScript SDK, which has about 16k weekly downloads. In
2026, I built Diwy Split on my own, a Telegram Mini App that splits restaurant bills from receipt
photos: from the interface and LLM recognition pipeline to the server it runs on. It went from
prototype to launch in under a month of active work.

I work with AI on both sides of a product. Inside it, Diwy reads receipts with an LLM pipeline, and
prompt and model changes are benchmarked on receipts checked by hand before release. Behind it,
coding agents work within a workflow of test scenarios, review by several models and screenshot
tests in CI, so nothing reaches users until every test passes and I have reviewed every changed
screen.

## Experience

### Diwy Split — side project, shipped

*Mar 2026 – Present · [diwy.me](https://diwy.me) · Telegram Mini App for splitting restaurant bills
from receipt photos · solo, live in beta*

- **LLM recognition** — models misread receipts, and a wrong amount destroys trust. The model only
  transcribes, code does the arithmetic, and a person confirms anything that changes what someone
  pays. I scored around 20 model pairings on hand-checked receipts and chose one at 0.991 for $0.004 per receipt.
- **Regressions** — product changes brought side effects that were hard to spot and trace. I rebuilt
  77 bill states through the app's own commands. They drive manual QA and pixel-exact iOS and
  Android screenshots in CI.
- **Availability** — the app did not open in Russia, where Cloudflare is throttled. GeoDNS
  sends users there through a relay and everyone else through Cloudflare. Monitoring and alerts
  cover both routes.
- **UX** — a paper receipt had to become an intuitive screen with no dead ends. The hardest case
  was taking only part of a dish. I prototyped the flows in Claude Design and added a receipt editor
  before launch.

### Tonkeeper — Software Engineer, Developer Platform & Developer Experience

*Jun 2024 – Mar 2026 · Remote · TON Apps: 23-person team behind the Tonkeeper wallet (12M+ MAU).
Most work is public, linked below.*

- **[Tonconsole](https://github.com/tonkeeper/ton-console)**, TonAPI's developer console — moved
  billing to one USD balance matching plan prices, with TON or USDT top-ups. Migrated state to React
  Query incrementally, isolating caches by user so accounts in one browser never share data.
- **Console products** — shipped webhooks, dedicated liteservers, API plans and analytics. One
  tested pricing function made a threefold webhook price change a constants edit. Liteserver buyers
  download `global.config.json` without manual edits. Downgrades show the unspent balance instead
  of being blocked.
- **Free TonAPI limits for dApps** — took an idea I was given and designed and built it on every
  wallet platform, including QA's test setup. The wallet injects `window.tonapi.fetch`; the SDK
  uses it without configuration, giving dApps inside Tonkeeper higher limits.
- **[TypeScript SDK](https://github.com/tonkeeper/tonapi-js), ~16k weekly downloads** — sole
  maintainer from mid-2024. Added `bigint`, address and cell formats to TonAPI's
  [OpenAPI schema](https://github.com/tonkeeper/opentonapi), giving any generator exact amount
  types. Kept old SDK paths as deprecated wrappers when the schema was regrouped.
- **[Integration docs](https://github.com/tonkeeper/tonconsole-docs)** — generated the REST
  reference from the same schema. Wrote the transaction-tracking and data-signing guides and the
  cookbook.
- **[Wallet](https://github.com/tonkeeper/tonkeeper-web)** — replaced polling of two DEX aggregators
  with streamed Omniston swap quotes. Built desktop staking
  ([merged after I left](https://github.com/tonkeeper/tonkeeper-web/pull/592)). Changed TRC20
  sending errors from "Insufficient funds" to "temporarily unavailable" during TronGrid outages.
  Fixed slow server rendering in Tonviewer, the explorer.
- **Fees and wallet extensions** — wrote a fee estimator using TON's formulas, tested against real
  transactions ([unfinished when I left](https://github.com/tonkeeper/tonkeeper-web/pull/550)).
  Worked on sponsored-fee (gasless) transfers and W5 wallet extensions, including 2FA.

### Quintegro — Frontend Developer

*Jul 2023 – May 2024 · Remote*

- Led development of the booking-change module for a reservation platform connecting hosts and
  guests.
- Defined frontend–backend API contracts, generated TypeScript types from them and set up CI.

### Minacu — Full Stack Engineer

*Apr 2023 – Jul 2023 · Part-time, Remote*

- Built streaming speech-to-text over gRPC, text analysis through the OpenAI API and a Telegram
  integration through tdlib — Python and NestJS on the backend, Next.js on the frontend.

### Upper Echelon Products — JavaScript Developer, then Technical Team Lead

*Apr 2021 – Mar 2023 · Remote*

- Promoted to team lead: ran 3–5 engineers and 1–2 QA through about 11 releases, mentored five juniors.
- Built an Amazon Seller Central ingestion pipeline and moved the backend from a VPS to AWS with
  CI/CD. Standardised the frontend architecture and moved API documentation to Swagger.

### Apptech — Software Engineer

*Jul 2020 – Nov 2020 · Part-time, St Petersburg*

- Built push notifications and real-time messaging on Firebase for the second version of a
  messenger app.

### GET Information Technology — Software Engineer

*Mar 2018 – Feb 2020 · St Petersburg*

- Built Backbone/Marionette and ExtJS interfaces and the ColdFusion services that supplied their
  data.
- Introduced ESLint and Babel, including tooling that tracked their rollout across the codebase.

## Selected Open Source

- **[TON Connect SDK](https://github.com/ton-connect/sdk)**, the library dApps use to connect TON
  wallets — implemented [data signing](https://github.com/ton-connect/sdk/pull/349) for text,
  binary and TON cell payloads across the protocol, SDK and UI. Added wallet capabilities:
  [required features](https://github.com/ton-connect/sdk/pull/324) filter out unsuitable wallets,
  [preferred features](https://github.com/ton-connect/sdk/pull/348) rank them and prompt a
  reconnect instead of failing silently.
- **[TON Connect specification](https://github.com/ton-blockchain/ton-connect)** — wrote a
  [sign-data reference implementation](https://github.com/mois-ilya/ton-sign-data-reference) with
  tests. They exposed two places where compliant wallets could sign different messages for the
  same request, both fixed in the spec: the response
  [address format](https://github.com/ton-blockchain/ton-connect/pull/73) and
  [`appDomain` encoding](https://github.com/ton-blockchain/ton-connect/pull/74), where the spec's own
  example was wrong.
- **[Telegram Bot Docs skill](https://github.com/mois-ilya/telegram-bot-docs-skill)** — an agent
  skill that splits Telegram's bot documentation into about 1,000 searchable sections with a
  freshness check, so coding agents read current docs rather than memory.

## Skills

::: {typst:text:size="9.3pt"}
- **Languages & frontend** — TypeScript, JavaScript, Python; Go (reading and small fixes); React,
  Next.js
- **Backend & APIs** — Node.js, Fastify, NestJS, PostgreSQL, OpenAPI, REST, gRPC, webhooks, event
  sourcing
- **Cloud** — Cloudflare Workers, Durable Objects, AWS, Azure AI, Docker, CI/CD
- **Testing** — Vitest, Playwright (pixel-exact screenshot tests), fast-check, Testcontainers
- **Domains** — developer platforms and SDKs · payments and billing · Telegram Mini Apps and bots ·
  blockchain
:::

## Education

### MSc, High Technology and Economics of Innovation

*2019 – 2021 · ITMO University*

### BSc, Information Systems and Technologies

*2015 – 2019 · Herzen State Pedagogical University*
