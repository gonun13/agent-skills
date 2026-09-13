---
name: improve-seo
description: Audits a project's public web surface and fixes it — target search terms, page metadata, descriptive URLs, crawlability, structured data, image alt text, and internal and outbound links. Use when a site should rank, or before launching one.
---

# Improve SEO

## Goal

Every indexable page of this project carries a stated target query, a unique
title and description, a canonical URL, a descriptive path, correct structured
data, alt text on every image, and working links in both directions — with a
table saying what each page is now trying to rank for.

## Context

Check first:

- Whether there is a public web surface at all. A library, CLI, or private
  service has no pages to optimise; say so and stop rather than inventing work.
  Its registry listing and repository metadata are still in scope (step 9).
- What the project is and who it is for (README, landing copy, docs). That is
  where target search terms come from — you do not get to invent them.
- The stack and its metadata API: Next.js `metadata` exports or `next-seo`,
  Astro layouts, Nuxt `useSeoMeta`, SvelteKit `<svelte:head>`, Hugo/Jekyll
  front matter and config, Gatsby Head API, or a plain template partial. Use
  the one the project already has instead of adding a second mechanism.
- The route table or content tree, and whether pages are server-rendered,
  static, or client-rendered. Client-rendered content is the common cause of a
  site with no indexable text at all.
- The canonical production origin — scheme, host, `www` or apex, trailing
  slash. Every absolute URL you write depends on it. Ask if it is not in the
  config, and never guess a domain.
- What already exists: `robots.txt`, `sitemap.xml`, canonical tags, JSON-LD,
  redirect rules (`_redirects`, `netlify.toml`, `vercel.json`, `.htaccess`,
  nginx config), and any analytics or Search Console verification.

## Steps

1. Build the site and read the rendered HTML, not the templates. What the
   crawler sees is the output. Record a baseline: pages missing a title,
   description, canonical, `h1`, or `lang`, and images missing `alt`.
2. Target terms: give each page one primary query and a few supporting ones,
   drawn from the project's own vocabulary and the problem it solves. Match
   intent to page type — informational for docs, commercial for the pricing
   page. One page per intent: two pages chasing the same query compete with
   each other, so merge or differentiate them.
3. Metadata, per page and unique: a `<title>` of roughly 50–60 characters
   leading with the primary term and ending with the brand; a meta description
   of roughly 150–160 written to earn the click, not to repeat the title; an
   absolute `rel=canonical`; `lang` on `<html>`; Open Graph and Twitter tags
   with an image that exists and is reachable at an absolute URL.
4. Headings: exactly one `h1` per page, stating what the page is; no skipped
   levels below it; headings that describe the section rather than decorate it.
5. Descriptive URLs: lowercase, hyphenated, word-based paths that read as the
   page's subject — `/docs/rate-limiting`, not `/p?id=417` or `/docs/page3`.
   Drop stop words and dates that carry no meaning, keep the depth shallow, and
   pick one trailing-slash convention and enforce it everywhere. **Any path
   that changes needs a 301 from the old one in the same commit.** A live URL
   changed without a redirect loses every ranking and backlink it had; if you
   cannot add the redirect, leave the URL alone and report it.
6. Crawlability: `robots.txt` that blocks nothing needed to render the page and
   points at the sitemap; an XML sitemap generated from the real route table,
   with absolute URLs and honest `lastmod`; `noindex` on thin, duplicate, and
   internal pages; a 404 that returns status 404 rather than a 200 with an
   error in the body. Confirm no staging `noindex` or `Disallow: /` can reach
   production — that single line is the most expensive bug in this skill.
7. Structured data: JSON-LD matching the page — `Organization` and `WebSite` on
   the home page, `Article` with author and dates, `BreadcrumbList`,
   `SoftwareApplication`, `Product`, `FAQPage`. Mark up only what is visibly on
   the page; invented ratings or prices earn a manual penalty, not a rich
   result. Validate the syntax before you finish.
8. Images: every image that carries meaning gets `alt` describing what it shows
   or does in context — a button's action, a screenshot's content, a chart's
   takeaway. Decorative images get `alt=""`, never a missing attribute. Don't
   open with "image of", don't stuff terms. While you are there: descriptive
   file names, explicit `width` and `height` to stop layout shift, `loading="lazy"`
   below the fold but never on the LCP image, and modern formats with `srcset`.
9. Links, both directions:
   - **Internal** — descriptive anchor text over "click here" and "read more";
     no orphan pages; related pages cross-linked; every internal link resolving.
   - **Outbound** — where the copy makes a claim, link the primary source.
     Linking to authoritative pages is a quality signal, not a leak. Mark paid
     or untrusted links `rel="sponsored"` or `rel="ugc"`, and verify each
     external URL still resolves.
   - **Inbound** — you cannot create backlinks from inside a repository, and
     any skill that claims otherwise is describing a link scheme. What you can
     do is make the project linkable and consistent: correct `homepage` and
     `repository` fields in the package manifest, the repository's own
     description, topics, and website field, one canonical domain everywhere it
     is cited, and no broken URL on a page that others already link to. Then
     list legitimate outreach targets for the operator — registries the project
     belongs in, "awesome" lists, docs of tools it integrates with, its own
     changelog and release notes.
10. Core Web Vitals, to the extent the repo controls them: render-blocking CSS
    and JS, font loading and fallbacks, a preloaded LCP image, and reserved
    space for anything that arrives late.
11. Validate: rebuild, rerun the project's link check and Lighthouse or
    equivalent if it has one, and re-read the built output. Confirm the counts
    from step 1 are now zero, that the sitemap matches the routes the build
    emitted, and that every redirect you added resolves to a 200.

## Constraints

- Never change a published URL without a 301 in the same change.
- No manipulation: no keyword stuffing, hidden text, cloaking, doorway pages,
  bought or exchanged links, or structured data describing things not on the
  page. All of it is detectable, all of it is penalised, and none of it is
  yours to gamble with.
- Alt text is for the reader who cannot see the image. Search benefit is a
  side effect of writing it honestly.
- Metadata, markup, and links are in scope. Rewriting the project's actual
  copy is a voice decision — propose it, don't do it unasked.
- Don't add analytics, tag managers, consent banners, or any third-party
  script. That is a privacy and performance decision for the operator.
- Fetching an external URL to check it resolves is fine. Submitting a sitemap,
  registering a property, pinging a search engine, or posting anywhere is not.
- Don't guess the production domain, brand name, or company details. Ask.
- Report what you inspected and what you did not. Never report "SEO complete".

## Done when

The build passes, every indexable page has a unique title, description,
canonical, single `h1`, and social image, every `img` has a resolved `alt`
decision, the sitemap and `robots.txt` agree with the real routes, every
internal link and every redirect resolves, and each page has a stated target
query in the report.

## Output

Open with one line: how many pages were audited, how many changed, and whether
any URL changed.

**Pages**

| URL | Primary term | Title | Fixed |
| --- | --- | --- | --- |

`Fixed` is a short list of what changed on that page (`title`, `description`,
`canonical`, `h1`, `alt×4`, `jsonld`).

**URL changes**

| Old | New | Redirect |
| --- | --- | --- |

Omit the table when nothing moved.

**Site-wide** — one line each for `robots.txt`, the sitemap, structured data,
redirects, and anything under step 10, as `path` plus what changed.

Close with three short lists:

- **Outreach** — where this project could legitimately be linked from, and why
  it qualifies. Suggestions for the operator, never actions taken.
- **Left alone** — pages, URLs, or images you did not touch, and what would
  settle each. Missing alt text you could not write because the image's
  meaning was unclear belongs here, named.
- **Needs a human** — copy rewrites, domain decisions, a Search Console
  submission, or anything requiring access you do not have.
