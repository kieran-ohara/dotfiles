# Claude

## Development Principles

These principles MUST be followed at all times.

### Build one feature at a time.

- Changes to the codebase should be small and
- Changes should focused on a single purpose at a time.
- Changes should be able to be committed to git as single, atomic commits.
- Do NOT make sweeping changes across multiple parts of the codebase at once.

### Express intent, not mechanism

Build the named thing the domain or the specification calls for — a service, a
repository, the port that already exists — and let helpers fall out of it as
private detail. Do NOT scatter free-floating pure functions named after their
mechanism (`compileX`, `toY`, `buildZ`) and then wire them together only in a
test.

A function named after its mechanism describes the mechanism. A method named
after the use case — `matchLeadsForCandidate`, `matchCandidatesForLead` —
describes the requirement, so the test reads as the behaviour and can be checked
against the spec. Tests over loose helpers assert glue and tell a reader nothing
about what the code is for.

Before writing a helper:

- Find the seam the specification or the existing ports already name, and
  implement **that** rather than inventing something beside it.
- Name methods for what a caller does, not for what the code does internally.
- Keep third-party client APIs (SDKs, query DSLs, ORMs) behind that seam, so
  nothing outside it is shaped by the library.
- Never ship production surface with no caller. If the only consumer is a test,
  either build the real consumer in the same change or do not build it yet.

Where a datastore or external service is involved, exercise the named service
against the real technology **through the API its callers will use**, rather
than driving the client directly from the test.

#### The file structure is the smell test

If the thing you are writing has no obvious home — it lands loose at the top of
a domain folder, next to nothing it belongs with — that is the structure telling
you the abstraction is wrong. Well-formed code falls naturally into the layout
the codebase already has. When there is no obvious home, stop and find the seam
it belongs to instead of inventing a folder for it.

Related: avoid type-to-type mappers as a design habit. A type named after a
shape transformation (`XDocument`, `toX`, `XMapper`) tells a reader nothing
about where it is used, and a type that merely mirrors another type is usually
duplication rather than design. Where a translation is genuinely needed, it is
private detail of the service that owns it — not exported surface a reader has
to guess the purpose of.

### Use Test Driven Development (TDD)

Code should be delivered using a the Test Driven Development approach:

0. Before writing a test, consider its utility. What real behaviour does it
   verify? A test that mocks everything and only asserts glue wiring is
essentially worthless — if the only thing left under test is trivial
orchestration, skip the test.
1. Write ONE single failing test first
2. Run the test to confirm it fails
3. Implement minimal code to make that test pass
4. Run the test to confirm it passes
5. Move to the next test
6. Suggest refactoring opportunities when appropriate

#### Use the test setup the codebase already has

TDD is followed using the **established test patterns of the codebase** — its
runner, its config, its file naming, its directory layout. Match what is there.

Do NOT introduce test infrastructure into a codebase that has none. If a repo or
package has no test runner, no test files, or only a placeholder script (e.g.
`"test": "echo \"Error: no test specified\" && exit 1"`), that is not an
invitation to add one. Stop and say so: state that the code is untestable as it
stands, what adding a runner would involve, and ask for explicit instruction
before doing it. Adding a runner is its own piece of work with its own
consequences — dependencies, CI changes, a second tool for the team to learn —
and it is the user's call, not a prerequisite to be quietly satisfied on the way
to something else.

The same restraint applies to changing an existing setup: do not swap runners,
add a second one alongside the first, or restructure test layout because a
different approach would suit the code better. Work within what exists, or ask.

#### Test the real technology, never a mock of it

Anything that talks to a datastore or external service — Postgres, DynamoDB,
OpenSearch, S3, a queue — is tested against **the actual technology**, using
testcontainers or an equivalent local instance. Do NOT mock the repository and
assert that a `jest.fn()` received the right arguments. That proves the caller's
arguments and nothing else: not that the query parses, not that the update
expression is valid, not that the schema matches. A mocked repository cannot
fail the way the real one does — a malformed query or update expression passes
every mocked test and fails every real call.

The same applies to the deployed shape: prefer exercising the real handler,
client, or query over a stand-in that merely resembles it.

#### Tests must stand alone

Each test sets up everything it asserts on and shares no mutable state with any
other test. No test may rely on a previous test having written a row, seeded a
fixture, or left a client in a particular state. Ordering is not a contract — a
test that passes only in sequence is testing the sequence.

The check that catches this: run the test on its own (e.g. `jest -t '<name>'`).
If it passes in the suite but fails alone, it is asserting another test's side
effects. Where tests share a container or database, give each one its own key,
row, or namespace rather than reusing an identifier.

#### Do not touch tests outside the work

Change a test only when the work you were asked to do requires it: the behaviour
it covers has changed, or your change breaks it. A test that merely sits nearby,
reads badly, or carries a misleading name is not yours to edit.

This applies above all to **renaming**. Never rename a test on your own
initiative. A name that no longer matches what the test asserts is worth
raising, not silently fixing: say which tests and why, and let the call be made.
Unrequested renames pad a diff the reviewer needs kept small, and they change
the shared vocabulary of the suite without anyone having agreed to it.

The same restraint covers deleting tests, retitling `describe` blocks, and
tidying assertions that are not in your way. Flag freely; edit narrowly.

#### Find elements by test id, never by their copy

In UI tests, locate elements with `data-testid` (`getByTestId`,
`queryByTestId`, `within(scope).getByTestId(...)`). Do **not** find them by
matching rendered prose — `getByText` / `queryByText` / `findByText` against a
sentence the component displays.

Rewording a message is a copy decision, not a behaviour change, but a text
query fails on it. Worse, the assertion duplicates the translation, so the test
starts fighting i18n: the same test cannot pass in two locales, and the string
in the test drifts from the one in the translation file.

Role and label queries are fine and often better — `getByRole("button", {name})`,
`getByRole("region", {name})`, `getByLabelText(...)` — because they identify an
element by its role and accessible name, which is behaviour, not decoration.

When a component gains a new visible state, give it a `data-testid` in the same
edit rather than reaching for its text afterwards. Name the id after the state,
prefixed by the feature (e.g. `cv-extraction-nothing`). Reach for
`toHaveTextContent` with a short substring only when a test must distinguish
*which* of several messages rendered — never as the way to find the element.

### Follow the Twelve-Factor App

We follow the [Twelve-Factor App](https://12factor.net/) methodology closely.

**Especially important: Factor III - Config**

- Store configuration in environment variables, never in code
- Never commit secrets, credentials, or environment-specific config to version control
- Use `.env` files locally (gitignored) and environment variables in production
- Configuration should vary between deployments (dev, staging, prod) without code changes

## AWS

### CLI

Standard AWS CLI commands should be executed directly with AWS_PROFILE environment variable.
**DO NOT use aws-vault for standard AWS CLI commands.**

#### Usage Examples

```bash
# List buckets
AWS_PROFILE=profile-name aws s3 ls

# Delete a bucket
AWS_PROFILE=profile-name aws s3 rb bucket-name
```

### CDK

AWS CDK commands **MUST** be executed using `aws-vault` to pass credentials.
**ONLY use aws-vault for CDK commands, never for standard AWS CLI commands.**

#### Usage Examples

```bash
# Deploy a CDK stack
aws-vault exec profile-name -- cdk deploy
# Synthesize CloudFormation templates
aws-vault exec profile-name -- cdk synth
# Destroy a stack
aws-vault exec profile-name -- cdk destroy stack-name
# List all stacks
aws-vault exec profile-name -- cdk list
```

Replace `profile-name` with the profile name given in the instruction. If no
profile name is given, ask the user.

#### Verifying a deployment

A CDK deploy that reports `UPDATE_COMPLETE` / `CREATE_COMPLETE` (the `✅` line)
has shipped the code. Do **not** download or grep the deployed Lambda bundle to
"confirm" the new code is present — a completed deploy is the confirmation.
(Provided the artifact was built fresh: always let the build run before
deploying — e.g. `turbo run deploy:dev`, which builds first, or run the
package's own `build` before a direct `cdk deploy`. Never deploy a stale
pre-built bundle; that, not the deploy status, is what makes people distrust it.)

To **verify a deployment**, exercise the deployed behaviour and observe the
result — invoke the function or publish the triggering event, then check the
output/logs/traces (e.g. Langfuse) — rather than inspecting the code artifact.

### Lambda

Use **AWS Lambda Powertools for TypeScript** (`@aws-lambda-powertools/*`) as the standard toolkit for all Lambda handlers:

- **Logger** (`@aws-lambda-powertools/logger`) — structured JSON logging. Set `serviceName` per handler.
- **Parameters** (`@aws-lambda-powertools/parameters`) — retrieve secrets and config from Secrets Manager, SSM, etc. Use `getSecret()` for API keys rather than passing them as plaintext environment variables.
- **Batch** (`@aws-lambda-powertools/batch`) — use `BatchProcessor` with `processPartialResponse` for any Lambda triggered by SQS or DynamoDB Streams. This handles partial batch failures correctly (reports `batchItemFailures`).
- **Idempotency** (`@aws-lambda-powertools/idempotency`) — use for handlers where at-least-once delivery requires deduplication.

Do NOT roll your own batch processing, structured logging, or secrets retrieval when Powertools provides it.

In TypeScript projects, type Lambda handlers and events using **`@types/aws-lambda`** wherever applicable (e.g. `APIGatewayProxyHandler`, `SQSHandler`, `DynamoDBStreamHandler`, `ScheduledHandler`, `S3Handler`, `EventBridgeHandler`). If the package is not already a dev dependency, recommend adding it (`npm install -D @types/aws-lambda`) before writing the handler rather than hand-rolling types or using `any`.

#### Caching across warm invocations

Lambda containers are reused: anything awaited or constructed in the handler
body is paid on **every** invocation, not just cold start. Expensive init —
SSM parameters, secrets, DB connections, SDK/service clients — must be cached
at module level so warm invocations skip it. Never call `getParameter` /
`getSecret` directly in the handler path (Powertools' built-in cache has a
short default `maxAge` and is not a substitute).

The canonical shape is a module-level **promise cache**: memoize the in-flight
promise, validate the result inside it, and reset to `null` on failure so a
transient error is retried on the next invocation instead of being cached
forever:

```typescript
let apiKeyPromise: Promise<string> | null = null;

export function getApiKey(): Promise<string> {
  if (!apiKeyPromise) {
    apiKeyPromise = getParameter("/service/api-key", { decrypt: true })
      .then((value) => {
        if (!value) {
          throw new Error("Missing API key");
        }
        return value;
      })
      .catch((err) => {
        apiKeyPromise = null;
        throw err;
      });
  }
  return apiKeyPromise;
}
```

A cold-start-only value cache (`if (!cached) { cached = ... }` assigned only
after a successful await) is an acceptable equivalent inside a handler module —
don't churn existing code between the two shapes.

Corollary: wire services **once per container** (module scope, or a memoized
`getApp()`/factory). An object constructed per invocation defeats any caching
it does internally — e.g. a service that lazily fetches its encryption key on
first use re-fetches it every invocation if the handler news it up per event.

#### Handler exports in ADOT environments

When a Lambda uses the ADOT (AWS Distro for OpenTelemetry) layer with the
`aws-lambda` auto-instrumentation, the handler **must** be exported with
`module.exports = { handler }`, **not** `export const handler`. The ADOT layer
hot-patches `exports.handler` at init via `Object.defineProperty`; esbuild
compiles `export const handler` to a non-configurable getter, so the patch throws
`TypeError: Cannot redefine property: handler` and the function fails at init —
every invocation dead-letters.

Before writing or refactoring a Lambda handler's export, determine whether the
project runs in an ADOT environment (look for the ADOT layer in CDK, the
`AWS_LAMBDA_EXEC_WRAPPER=/opt/otel-handler` env var, or `OTEL_*` config). If you
cannot tell from the code, use AskUserQuestion to ask whether the project uses
the ADOT layer before choosing the export style. When in doubt, prefer
`module.exports = { handler }`.

## Jira

Claude has access to Jira via the Jira CLI (`j`). Use it to view, create, update, and search for issues.

### Adding Comments

Use a positional argument for the comment body — there is no `--body` flag:

```bash
j issue comment add ISSUE-KEY "comment text"
```

## Bitbucket

Repos hosted on Bitbucket (`origin` pointing at `bitbucket.org` or a Data
Center host) are managed with the Bitbucket CLI, whose binary is **`bkt`** —
installed by the `bitbucket-cli` formula from the `avivsinai/tap`. Use it for
pull requests, pipelines and repository queries; `gh` will not work against
these remotes.

```bash
bkt pr list                 # open PRs in the current repo
bkt pr list --mine          # your PRs across all repos
bkt pr view <id>            # description, state, source -> target
bkt pr create               # source defaults to the current branch
bkt pipeline list           # Cloud pipelines
```

Notes:

- There is no `--head` / branch filter on `bkt pr list`. List and grep for the
  branch name instead.
- `bkt pr create` defaults the target to the **remote's default branch**. Where
  a team integrates into a branch other than the default (e.g. `develop`), pass
  `--target` explicitly rather than relying on the default.
- `--json` plus `--jq` is supported on commands that produce structured output.

## Git

### Git Commands

- For git commands involving file paths, `cd` to the root of the project first.

### Commit Style

- **NEVER** use Conventional Commits format
- NO prefixes like `feat:`, `fix:`, `chore:`, `refactor:`, etc.
- Write plain, descriptive commit messages without any prefix conventions

### Lockfile Conflict Resolution

When a lockfile (`package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`) has merge or rebase conflicts, **never** just pick a side. Instead:

1. `git checkout --theirs <lockfile>`
2. Run the package manager install (e.g. `npm install`) to regenerate it
3. `git add <lockfile>` and continue

### Pull Request Descriptions

- Open with a brief "why" - provide context for the change
- Follow with a brief summary of what was done
- If relevant, note what was intentionally excluded and why
- Do NOT list or summarise individual file changes - reviewers can read the diff
- Do NOT include a "Test Plan" section
- Keep it concise; respect the reviewer's time and intelligence

### Pull Request Reviews

When reviewing a pull request - or your own changes before opening one - apply
these in addition to checking correctness.

#### YAGNI

Flag production surface that has no caller: public methods, exported types,
repository/service functions, config, routes, or endpoints that are exercised
only by tests, or by nothing at all. Unused code is a liability - delete it, or
defer it until a real consumer exists. A method that exists purely so a test can
observe internal state is NOT a consumer; verify the behaviour through the real
seam instead (e.g. query the datastore directly).

#### Spec-driven work (spec-kit / specify)

When the change came out of a spec-kit workflow (a `specs/<n>/` directory with
`spec.md` / `plan.md` / `tasks.md`), additionally check the spec against what
actually ships:

- If a functional requirement or success criterion mandates a capability the
  delivered slice has no consumer for, it should be descoped or deferred in the
  spec - not built speculatively to satisfy the letter of the spec.
- Requirements describing a deferred consumer (a future read, endpoint, or UI)
  do not justify building that surface now.
- Prefer amending the spec to match the delivered scope over adding unused code.

## Clean Up

When the user says a feature is finished and asks to clean up, run through these:

### Stacked branches (`gh stack`)

- If the feature was built as a stack, clean it up with `gh stack sync --prune`,
  run from a branch **in** the stack (not the trunk) while the local stack
  tracking still exists. It fetches, fast-forwards the trunk, cascade-rebases any
  still-open branches, and then prunes — deletes the **local** branches whose PRs
  are merged. Do this *before* the local tracking is lost.
- If the tracking is already gone (`gh stack view --json` reports "not part of a
  stack"), `sync --prune` has nothing to operate on. Fall back to: confirm each
  PR is `MERGED` (`gh pr list --head <branch> --state all`), then
  `git branch -D <branch>`. Force-delete (`-D`) is needed because squash-merged
  branches are not ancestors of the trunk, so `git branch -d`'s merged-check
  refuses them.
- Remote branches are usually auto-deleted on merge; confirm with
  `git ls-remote --heads origin '<pattern>'` before assuming they linger.

### Worktrees

- If this session — or an agent spawned during it — created git worktrees, tidy
  them up once the work is merged or abandoned. List them with
  `git worktree list`, then `git worktree remove <path>` for each
  session-created one, and `git worktree prune` to clear stale administrative
  entries.
- Never force-remove a worktree that has uncommitted or unpushed changes. Check
  its state first (`git -C <path> status`, `git -C <path> log --oneline @{u}..`)
  and surface anything unmerged to the user rather than discarding it.

## Clients

Conventions that apply only to a particular client's repositories. Where these
conflict with the general guidance above, the client's convention wins.

### Arden

Repositories under `~/src/arden`. Bitbucket-hosted, so pull requests go through
`bkt`.

Pull requests:

- The ticket number always goes at the front of the title, e.g.
  `MW-124: Add structured logging foundation`.
- Never leave the description empty. There is no required format beyond that,
  so the general pull request guidance above applies.

The team is publishing further PR guides and conventions to their channels;
update this section as they land.

## Code Comments

- Code should be self-documenting. Reduce the need for comments.
- Only add comments for complex procedures where the logic is not immediately obvious.
- DO NOT add function documentation (JSDoc, docstrings, etc.) UNLESS that convention already exists in the codebase.
- Avoid silly or unhelpful comments that restate what the code does.
- **Comment the surprise, not the code.** A comment earns its place only if,
  without it, a reader would be liable to change the code *incorrectly* — a
  non-obvious constraint, a default that bites, a decision that looks wrong but
  is not. If the comment would still read as true with the code deleted, it is
  narration; delete it.
- Do NOT restate the method name in prose above the method. A well-named method
  is the comment.
- **Design rationale belongs in the commit message and the pull request**, not
  above every member. The code explains what the system does now; the history
  explains why it came to be that way. Do not editorialise in source about
  alternatives considered, what another service does differently, or why an
  approach was chosen.
- **Comment density is itself a smell.** A comment above nearly every member
  means either the names are not carrying their weight or rationale is being
  narrated. Both are fixed by deleting the comments, not by improving them.

### Spec-kit Task References

When working through a spec-kit (`/speckit-*`) workflow, **never** embed spec-kit
identifiers into the code or its comments. These reference numbers are local
planning artefacts and mean nothing to anyone reading the codebase:

- Task numbers (e.g. `// T012`, `// Task 3.2`)
- User story / requirement codes (e.g. `// US-04`, `// FR-12`, `// AC-2`)
- Spec or plan section references (e.g. `// per spec.md §4`)

The implementation should stand on its own. If a comment is genuinely warranted,
explain the behaviour — do not cite the task or story that produced it.

This applies equally to **git commit messages** (both titles and descriptions).
Do not tag commits with task numbers or story/requirement codes (e.g.
`Add role guard (T029, T031)`). Describe the change on its own terms; the commit
history should read as a narrative of the work, not of the plan that produced it.

## Banned Phrases

Never use the following phrases in responses, code comments, commit messages, or
any other written output:

- "you're absolutely right"
- "load bearing"
- "wrinkles"

## TypeScript

- Do NOT use dynamic imports (`import()`) - use static imports only
- ALWAYS use braces for control structures (if, for, while, etc.) - never use shorthand syntax
  ```typescript
  // ❌ Bad
  if (condition) statement

  // ✅ Good
  if (condition) {
    statement
  }
  ```

### Type Safety

- Do NOT use `as` type assertions to cast unvalidated data (e.g. `JSON.parse(x) as Foo`). Parse and validate at runtime instead (e.g. with Zod).
- Avoid `any` — prefer `unknown` and narrow with type guards or schema validation.

### Function Signatures

- Prefer objects over positional arguments for function parameters, especially when:
  - The function takes optional parameters (avoids `undefined` in function calls)
  - The function signature is likely to change or grow in the future
- Use positional arguments only when:
  - The function is simple and unlikely to be modified
  - The function has a small, fixed number of required parameters

## Node.js Package Managers

If tools like `yarn` or `pnpm` are not available in PATH:
1. Check `package.json` for a `packageManager` field
2. If present, use `corepack enable` to activate the specified package manager
3. Then run the required package manager commands

### Monorepo Workspaces

In a monorepo, **always use the package manager's workspace flag** to run commands in the context of a specific package. Never `cd` into a package directory or hack together paths to binaries in `node_modules/.bin/`.

```bash
# npm workspaces
npm -w @scope/package-name run build
npm -w @scope/package-name exec cdk synth
npm -w @scope/package-name test

# yarn workspaces
yarn workspace @scope/package-name run build
yarn workspace @scope/package-name exec cdk synth

# pnpm workspaces
pnpm --filter @scope/package-name run build
pnpm --filter @scope/package-name exec cdk synth
```

This ensures the command runs with the correct working directory, PATH, and dependency resolution for that package.

## Shell

- When running development commands (tests, builds, linting, formatting, package managers, etc.), do NOT use `cd`. Always run commands from the repo root using relative or absolute paths.
- Only use `cd` as a last resort when a tool genuinely requires it to work from a specific directory.

## PDFs

To read, render, or extract content from PDFs, use the **poppler** CLI. It is
available on `PATH` as a containerised tool (a `docker run` wrapper) — do NOT
install poppler via Homebrew or `apt`.

- `pdftoppm` — rasterise pages to images (this is what the PDF-reading path uses)
- `pdftotext` — extract text
- `pdfinfo` — inspect metadata / page count

## AI Applications

### Testing & Evaluation

#### Single-Step Evals

Test individual LLM decisions in isolation, not full agent pipelines end-to-end. This is unit testing applied to agents.

- Isolate and test one LLM call at a time - failures point directly to the broken component
- Test properties, not exact values - LLM outputs are non-deterministic
  ```python
  # Bad: brittle, will break across runs
  assert result["tech_stack"] == ["Python", "Django", "PostgreSQL"]

  # Good: tests the properties that matter
  assert "Python" in result["tech_stack"]
  assert len(result["tech_stack"]) >= 2
  ```
- Fast and cheap - 1 LLM call per test vs 10+ for end-to-end

## Documentation Lookup

When working with frameworks or libraries and needing to look up documentation
(APIs, usage patterns, how-to guides), prefer using the Context7 MCP tool if it
is available. This provides up-to-date, version-specific documentation
directly.

## Revision and Studying

### Mochi Cards

When creating Mochi cards:
- DO NOT add tags unless explicitly asked to
- Focus on the content of the card rather than categorization

@RTK.md
