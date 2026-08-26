---
title: Projects
permalink: /projects
---

Everything I am building or have built.

## Building now

**Expense splitting** — a service for splitting shared costs between people. Nothing is
overwritten: every change is appended as an event, so two people editing the same bill both land,
and any balance is derived rather than patched. The settlement maths is checked by property-based
tests against a simpler reference implementation. Private for now.

**Receipt scanning** — a photo of a bill becomes line items that everyone at the table claims at
once. It runs entirely on Cloudflare Workers with no origin server. A staged model pipeline reads
the photo: the image becomes text up front, each stage can fall back to another vendor, and the
arithmetic is checked against the receipt total before anyone is shown a number. Private for now.

## TON ecosystem

**[tonapi-js](https://github.com/tonkeeper/tonapi-js)** — the TypeScript SDK for TonAPI, about
14k installs a week. Sole maintainer since mid-2024. I rewrote the packages and wrote the
generator behind them: custom templates, int64 mapped to bigint, isomorphic output for browser
and Node, one runtime dependency.

**[ton-console](https://github.com/tonkeeper/ton-console)** — Tonkeeper's developer console.
Sole developer for 21 months: billing moved from TON to USDT with no hard cutover, webhooks
management, pricing tiers, the analytics query builder, airdrop tooling.

**[TON Connect specification](https://github.com/ton-blockchain/ton-connect)** — two of my edits
are in the protocol spec: the address format in a sign-data response, and appDomain encoding.
Both were places where the wording let independent implementations disagree.

**[ton-sign-data-reference](https://github.com/mois-ilya/ton-sign-data-reference)** — a TypeScript
reference implementation of TON Connect SignData: a wallet signing arbitrary text, binary or TON
cell payloads, small enough to read in one sitting.

**[opentonapi](https://github.com/tonkeeper/opentonapi)** — the public API schema and its Go
backend. I contributed to the OpenAPI spec, mostly the parts generated clients break on: 64-bit
integers that lose precision in JavaScript, date formats, response types.

**[tonconsole-docs](https://github.com/tonkeeper/tonconsole-docs)** — integration guides on
transaction tracking, data signing and hash normalization.

## This site

**[mois.pro](https://github.com/mois-ilya/mois.pro)** — the page you are reading, and both
editions of my CV. Markdown sources, pandoc and typst for the PDF, a build check that asserts the
result is still parseable before it can be sent anywhere.
