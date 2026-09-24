---
name: good-readme
description: Creates or improves a repository's main README for public display, with a clear introduction, accurate setup instructions, practical usage examples, and relevant project information. Use when preparing a repository for visitors or polishing its README, not for a documentation-wide audit or a profile README.
---

# Good README

## Goal

Create or improve the repository's main README so a first-time visitor can
understand the project, decide whether it fits their needs, and reach a useful
first result.

## Context

Check first:

- The existing main README and repository instructions. Identify the file
  visitors actually see; on GitHub, `.github/README` takes precedence over a
  root README, followed by one in `docs/`. Preserve the established format and
  location; create `README.md` at the root if no main README exists.
- Manifests, lockfiles, runtime version files, entry points, build scripts,
  CI, tests, and examples. These establish capabilities, prerequisites, and
  working commands; old README claims are not proof.
- Public sample configuration, documentation, license and community files,
  existing screenshots or logos, and the canonical repository URL. Do not
  expose credentials embedded in remotes or configuration.

Useful conventions, not a mandatory section checklist:

- [GitHub's README guidance](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
  covers the introduction, getting started, help, navigation, and relative links.
- [Google's README guidance](https://google.github.io/styleguide/docguide/READMEs.html)
  emphasizes usage, project status, contacts, and links to further documentation.
- [GitHub's repository practices](https://docs.github.com/en/repositories/creating-and-managing-repositories/best-practices-for-repositories)
  describe companion community and security documents.

## Steps

1. Establish the audience, purpose, supported workflow, and current state from
   the repository. Preserve useful existing content, notices, and project
   terminology. Ask only for missing facts that materially block the rewrite;
   continue with supported content elsewhere.
2. Write a clear opening: one H1 with the project name, then a memorable but
   factual one-to-three-sentence pitch explaining what it does, who it serves,
   and why it helps. Use concrete benefits instead of unsupported superlatives.
   Follow with a short bulleted feature list grounded in implemented behavior;
   mention technologies when they explain a useful capability.
3. Make the page easy to scan. Order sections around the reader's path from
   understanding to setup to use. For a long README, add a compact linked table
   of contents and verify its anchors. Keep short READMEs short; link to existing
   detailed docs instead of duplicating them.
4. Consider a visual near the opening when it clarifies the product: an existing
   logo, representative screenshot, or short demo GIF. Prefer actual product
   captures with descriptive alt text and a short caption where needed. Check
   that assets exist, display at a useful size, and contain no private data.
   If no suitable visual is available, omit it and suggest a specific capture
   in the handoff; do not fabricate a product screenshot or leave a broken link.
5. Write getting-started instructions in execution order. State required tools,
   supported versions, operating-system restrictions, and external services
   only where supported by repository evidence. Use the project's package
   manager and real installation path; distinguish installing a published
   package from cloning for local development when both apply. Include the
   working directory, dependency installation, necessary configuration, build
   or initialization steps, and launch command as applicable. Use fenced code
   blocks with language tags, copyable commands without shell prompts, and
   separate output blocks. Explain required environment variables with safe
   example values and point to public example configuration. End with how to
   recognize success, such as a local URL or expected CLI result.
6. Show use beyond startup: at least one small end-to-end example of the main
   task, with input, command or code, and expected result. Match the interface:
   a CLI invocation, library import and call, API request, or a short UI workflow.
   Include essential configuration and defaults when needed. Base example
   output on observed behavior or fixtures; label illustrative or variable
   output clearly. Adapt setup and usage to non-executable repositories instead
   of inventing installation commands.
7. Add optional sections only when relevant and supported:
   - **Status and limitations:** documented experimental status, compatibility,
     known constraints, or deprecation. Describe roadmap items as plans only
     when maintainers have actually recorded them.
   - **Configuration, troubleshooting, and documentation:** common setup
     failures evidenced by the repository and links to deeper guides or APIs.
   - **Development and contributing:** real test/build commands and links to
     existing contribution guidelines or a code of conduct.
   - **Support and security:** established help channels and the existing
     private vulnerability-reporting policy; do not invent contact details or
     direct vulnerability reports to public issues.
   - **License, credits, and citation:** identify and link the actual license,
     preserve attribution, and link citation instructions when present. If
     licensing is absent or ambiguous, flag it in the handoff rather than
     choosing a license or claiming the project is open source.
   - **Badges, releases, and demos:** include only useful links backed by real
     workflows, releases, or public deployments. Avoid decorative badge walls
     and unsupported coverage, download, or build-status claims.
8. Edit the README, then validate it. Run the repository's existing Markdown
   and link checks when available. Check relative links, heading anchors, image
   paths, fence syntax, and heading hierarchy; preview the rendering if tooling
   is available. Verify changed commands against scripts and entry points, and
   run safe local examples where feasible. Report commands or external links
   that could not be checked and why. Review the final diff for accidental
   omissions, invented claims, and unrelated changes.

## Constraints

- Scope is the main README and directly needed visual assets. Do not modify
  application code, dependencies, repository settings, or companion policies
  merely to make the README's claims true.
- Preserve the project's language and tone unless the user requests a change.
  Prefer readable Markdown, descriptive links, and relative paths for files
  within the repository. Keep essential instructions in text, not only images.
- Do not guess commands, minimum versions, URLs, feature availability, license
  terms, benchmark numbers, or support promises. Resolve contradictions from
  evidence or report them; do not fill the public page with speculative facts
  or unfinished scaffold sections.
- Use sample configuration instead of secret-bearing files. Validation is not
  permission to deploy, publish, reset data, or call paid services. Report any
  such untested steps without presenting them as verified.

## Done when

The main README has a clear title and pitch, supported features, an actionable
getting-started path, and a practical usage example appropriate to the project.
Optional sections earn their space, local links and assets resolve, and new
claims and commands are backed by repository evidence. Checks have passed or
their limitations are explicitly reported; no unfinished placeholders remain.

## Output

Apply the changes in the repository. In the handoff, link the edited README,
briefly summarize the improvements, report validation performed, and list any
unresolved facts or useful missing assets. Do not return only a proposed outline
unless the user asked for a review or plan.
