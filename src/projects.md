---
title: Projects
permalink: /projects
---

The two products at the top are still private. Everything after them links to code, a
specification, or documentation that can be inspected directly.

## In development

**Expense splitting** records every change as an event instead of replacing the current bill.
Concurrent edits both survive, balances can be rebuilt from history, and property-based tests
compare the settlement algorithm with a simpler reference implementation.

**Receipt scanning** turns a photo into line items that several people can claim at the same time.
It runs entirely on Cloudflare Workers. The extraction pipeline separates image reading from later
stages, can switch model vendors at each boundary, and rejects results whose arithmetic does not
match the receipt total.

## Developer platforms and TON

**[tonapi-js](https://github.com/tonkeeper/tonapi-js)** is the generated TypeScript client for
TonAPI. I maintained it alone from mid-2024 through March 2026, rewrote its packages, and built the
generator that maps OpenAPI `int64` values to `bigint` and produces the same client for browsers
and Node with one runtime dependency.

**[ton-console](https://github.com/tonkeeper/ton-console)** is Tonkeeper's developer console. I was
its only developer for 21 months. The work includes billing moved from TON to USDT without a hard
cutover, webhooks management, pricing tiers, analytics queries and airdrop tooling.

**[TON Connect](https://github.com/ton-blockchain/ton-connect)** is the protocol used by apps and
TON wallets to connect. Two ambiguities I found became specification changes: the address format
in a sign-data response and the encoding of `appDomain`.

**[ton-sign-data-reference](https://github.com/mois-ilya/ton-sign-data-reference)** is a compact
TypeScript implementation of TON Connect SignData. It covers text, binary and TON-cell payloads
and is intended to be read alongside the specification.

**[opentonapi](https://github.com/tonkeeper/opentonapi)** contains TonAPI's public OpenAPI schema
and Go backend. My contribution was almost entirely to the schema: 64-bit integers in JavaScript,
date formats and response types. I made two small fixes in the Go code.

**[tonconsole-docs](https://github.com/tonkeeper/tonconsole-docs)** contains integration guides I
wrote on transaction tracking, data signing and hash normalization.

## This site

**[mois.pro](https://github.com/mois-ilya/mois.pro)** builds this page, two CV pages and two PDFs
from one repository. Pandoc renders the Markdown, Typst produces the PDFs, and a build check reads
their text layer to make sure dates still belong to the correct jobs.
