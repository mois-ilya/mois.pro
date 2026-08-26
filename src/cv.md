---
title: Ilya Mois — CV
author: Ilya Mois
headline: Software Engineer · Tbilisi, Georgia (GMT+4) · Available for full-time remote roles
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

An engineer for eight years: I design API schemas, write the backend services behind them, publish
the SDKs, and build the clients that use them. The last two went into developer-facing products at
Tonkeeper, where I rewrote two TonAPI SDK packages installed ~14k times a week, and tightened two
passages of the TON Connect protocol spec where the wording let independent implementations disagree.

## Experience

### Independent — Software Engineer

*Mar 2026 – Present · Tbilisi · two private products, built solo*

- **Expense splitting** — nothing is overwritten: changes are appended as events, so two people
  editing the same bill both land and any balance is derived rather than patched. Settlement math
  checked by property-based tests against a simpler reference implementation.
- **Receipt scanning** — a photo of a bill becomes line items everyone at the table claims at once,
  all on Cloudflare Workers with no origin server. A staged model pipeline reads it: the image
  becomes text up front, each stage falls back across vendors, and the arithmetic is checked against
  the receipt total before anyone is shown a number.

### Tonkeeper — Software Engineer, Developer Platform & DX

*Jun 2024 – Mar 2026 · Remote · TON Apps, the 23-person team behind a wallet with 12M+ MAU. Most of
this work is public — repository links below.*

- **[Developer console](https://github.com/tonkeeper/ton-console)** — sole developer for 21 months.
  Moved billing from TON to USDT with no hard cutover for existing users, and
  [replaced the legacy state layer](https://github.com/tonkeeper/ton-console/pull/144) that had been
  firing redundant events and needless server requests, leaving the app flow sequential.
- **Also on the console** — webhooks management, pricing tiers, USDT payments, the analytics query
  builder and airdrop tooling.
- **[Public API schema](https://github.com/tonkeeper/opentonapi) and its Go backend** — fixed a bug
  where code-generator defaults silently cleared fields on update. Contributed to TonAPI's OpenAPI
  spec, mostly the parts generated clients break on: 64-bit integers that lose precision in
  JavaScript, date formats, response types.
- **[TypeScript SDK](https://github.com/tonkeeper/tonapi-js), ~14k weekly downloads** — sole
  maintainer since mid-2024; rewrote the packages and wrote the generator behind them: custom
  templates, int64 mapped to bigint, isomorphic output for browser and Node, one runtime dependency.
- **[Docs](https://github.com/tonkeeper/tonconsole-docs) and
  [wallet](https://github.com/tonkeeper/tonkeeper-web)** — wrote integration guides on transaction
  tracking, data signing and hash normalization. Shipped TON Connect fixes in Tonkeeper Web across
  web, desktop and extension, and handled third-party API failures so they no longer crashed the app.

### Quintegro — Frontend Developer

*Jul 2023 – May 2024 · Remote*

- Reservation platform connecting hosts and guests; led development of its booking-change module.
- Defined the frontend–backend API contracts, generated TypeScript types from them, set up CI.

### Minacu — Full Stack Engineer

*Apr 2023 – Jul 2023 · Part-time, Remote*

- Built streaming speech-to-text over gRPC, text analysis through the OpenAI API, and a Telegram
  integration via tdlib — Python and NestJS on the backend, Next.js on the frontend.

### Upper Echelon Products — JavaScript Developer, then Technical Team Lead

*Apr 2021 – Mar 2023 · Remote*

- Standardised the frontend codebase and its architecture, mentored 5 junior developers, moved API
  documentation to Swagger.
- Promoted to lead: 3–5 engineers and 1–2 QA through about 11 releases. Built an Amazon Seller
  Central ingestion pipeline; migrated the backend from VPS to AWS with CI/CD.

### Apptech — Software Engineer

*Jul 2020 – Nov 2020 · Part-time, St Petersburg*

- Built push notifications and real-time messaging on Firebase for the second version of a messenger app.

### GET Information Technology — Software Engineer

*Mar 2018 – Feb 2020 · St Petersburg*

- Built Backbone/Marionette and ExtJS interfaces and the ColdFusion code that served their data.
- Introduced ESLint and Babel, with tooling to track their rollout across the codebase.

## Open Source

- **TON Connect specification** — two of my edits are in the
  [protocol spec](https://github.com/ton-blockchain/ton-connect): the address format in a sign-data
  response, and appDomain encoding.
- **Data signing** — implemented the SignData feature in @tonconnect/sdk, which lets a wallet sign
  arbitrary text, binary or TON cell payloads. Published
  [a TypeScript reference implementation](https://github.com/mois-ilya/ton-sign-data-reference).
- **Wallet capabilities** — added requiredFeatures and preferredFeatures to the SDK: an app declares
  what it needs, and incompatible wallets are filtered out before the user connects.

## Skills

- **Languages & frontend** — TypeScript, JavaScript, Python, Go (reading, small fixes); React,
  Next.js, React Native
- **Backend & APIs** — Node.js, Fastify, NestJS, PostgreSQL, OpenAPI, REST, gRPC, webhooks, event sourcing
- **Cloud & testing** — Cloudflare Workers, Durable Objects, AWS, Docker, CI/CD; Vitest, fast-check,
  Testcontainers
- **Domain** — developer platforms and SDKs · payments and billing · Telegram Mini Apps and bots ·
  blockchain

## Education

### MSc, High Technology and Economics of Innovation

*2019 – 2021 · ITMO University*

### BSc, Information Systems and Technologies

*2015 – 2019 · Herzen State Pedagogical University*
