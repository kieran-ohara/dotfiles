# Claude

## Development Principles

These principles MUST be followed at all times.

### Build one feature at a time.

- Changes to the codebase should be small and
- Changes should focused on a single purpose at a time.
- Changes should be able to be committed to git as single, atomic commits.
- Do NOT make sweeping changes across multiple parts of the codebase at once.

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

### Lambda

Use **AWS Lambda Powertools for TypeScript** (`@aws-lambda-powertools/*`) as the standard toolkit for all Lambda handlers:

- **Logger** (`@aws-lambda-powertools/logger`) — structured JSON logging. Set `serviceName` per handler.
- **Parameters** (`@aws-lambda-powertools/parameters`) — retrieve secrets and config from Secrets Manager, SSM, etc. Use `getSecret()` for API keys rather than passing them as plaintext environment variables.
- **Batch** (`@aws-lambda-powertools/batch`) — use `BatchProcessor` with `processPartialResponse` for any Lambda triggered by SQS or DynamoDB Streams. This handles partial batch failures correctly (reports `batchItemFailures`).
- **Idempotency** (`@aws-lambda-powertools/idempotency`) — use for handlers where at-least-once delivery requires deduplication.

Do NOT roll your own batch processing, structured logging, or secrets retrieval when Powertools provides it.

In TypeScript projects, type Lambda handlers and events using **`@types/aws-lambda`** wherever applicable (e.g. `APIGatewayProxyHandler`, `SQSHandler`, `DynamoDBStreamHandler`, `ScheduledHandler`, `S3Handler`, `EventBridgeHandler`). If the package is not already a dev dependency, recommend adding it (`npm install -D @types/aws-lambda`) before writing the handler rather than hand-rolling types or using `any`.

## Jira

Claude has access to Jira via the Jira CLI (`j`). Use it to view, create, update, and search for issues.

### Adding Comments

Use a positional argument for the comment body — there is no `--body` flag:

```bash
j issue comment add ISSUE-KEY "comment text"
```

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

## Code Comments

- Code should be self-documenting. Reduce the need for comments.
- Only add comments for complex procedures where the logic is not immediately obvious.
- DO NOT add function documentation (JSDoc, docstrings, etc.) UNLESS that convention already exists in the codebase.
- Avoid silly or unhelpful comments that restate what the code does.

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
