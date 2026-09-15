---
title: Ilya Mois — CV
author: Ilya Mois
headline: Software Engineer · Remote or on-site in Tbilisi, Georgia (GMT+4)
contact: |
  [job.offers@mois.pro](mailto:job.offers@mois.pro) ·
  [github.com/mois-ilya](https://github.com/mois-ilya) ·
  [linkedin.com/in/moisilya](https://www.linkedin.com/in/moisilya) ·
  Russian (native), English (professional)
permalink: /cv
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

Software engineer with eight years across product interfaces, API contracts, backend services and
developer tooling. Most recently at Tonkeeper, I was the sole developer of the developer console
and sole maintainer of the TypeScript SDK, with further work in TonAPI's public schema, integration
documentation and wallet. I now build two products solo.

## Experience

### Independent — Software Engineer

*Mar 2026 – Present · Tbilisi · two private products, built solo*

- **Expense splitting** — building an event-sourced service where edits append instead of replacing
  a bill, so concurrent changes survive and balances can be rebuilt from history. Property-based
  tests compare settlement math with a smaller reference implementation.
- **Receipt scanning** — building a service that turns a receipt photo into line items several
  people can claim at once. It runs entirely on Cloudflare Workers; extraction is staged across
  interchangeable model vendors, and the result is rejected unless its arithmetic matches the
  receipt total.

### Tonkeeper — Software Engineer, Developer Platform & DX

*Jun 2024 – Mar 2026 · Remote · TON Apps, the 23-person team behind Tonkeeper, a wallet with 12M+
MAU. Most of this work is public and linked below.*

- **[Developer console](https://github.com/tonkeeper/ton-console)** — sole developer for 21 months.
  Moved billing from TON to USDT without forcing existing users through a cutover, and
  [replaced the MobX state layer](https://github.com/tonkeeper/ton-console/pull/144) with React Query
  to stop duplicate events and server requests.
- **Console product work** — shipped webhook management and pricing, API tiers, billing history,
  the analytics query builder and airdrop tooling.
- **[TypeScript SDK](https://github.com/tonkeeper/tonapi-js), ~16k weekly downloads** — sole
  maintainer from mid-2024. Rebuilt its packages and generator to preserve `int64` values as
  `bigint`, handle OpenAPI serialization edge cases, and emit one client for browsers and Node with
  a single runtime dependency.
- **[API schema](https://github.com/tonkeeper/opentonapi) and
  [integration docs](https://github.com/tonkeeper/tonconsole-docs)** — changed the parts generated
  clients exposed as ambiguous: integer and date formats, response types and operation grouping.
  Wrote guides on transaction tracking, data signing and hash normalization.
- **[Wallet](https://github.com/tonkeeper/tonkeeper-web)** — shipped non-liquid staking flows,
  SSE-backed swap work and TON Connect fixes across web, desktop and extension; made third-party API
  failures recoverable instead of letting them crash the app.

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

- Promoted to lead; took 3–5 engineers and 1–2 QA through about 11 releases and mentored five junior
  developers.
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

- **TON Connect specification** — clarified two places where compliant implementations could sign
  different messages for the same request: the address format in a sign-data response and
  `appDomain` encoding. Both changes are in the
  [protocol specification](https://github.com/ton-blockchain/ton-connect).
- **Data signing** — implemented SignData in `@tonconnect/sdk`, covering text, binary and TON cell
  payloads, and published a readable
  [TypeScript reference implementation](https://github.com/mois-ilya/ton-sign-data-reference).
- **Wallet capabilities** — added `requiredFeatures` and `preferredFeatures` to the SDK, so apps can
  declare what they need and incompatible wallets are filtered before connection.

## Skills

- **Languages & frontend** — TypeScript, JavaScript, Python; Go (reading and small fixes); React,
  Next.js, React Native
- **Backend & APIs** — Node.js, Fastify, NestJS, PostgreSQL, OpenAPI, REST, gRPC, webhooks, event
  sourcing
- **Cloud & testing** — Cloudflare Workers, Durable Objects, AWS, Docker, CI/CD; Vitest, fast-check,
  Testcontainers
- **Domains** — developer platforms and SDKs · payments and billing · Telegram Mini Apps and bots ·
  blockchain

## Education

### MSc, High Technology and Economics of Innovation

*2019 – 2021 · ITMO University*

### BSc, Information Systems and Technologies

*2015 – 2019 · Herzen State Pedagogical University*
