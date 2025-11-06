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

1. Write ONE single failing test first
2. Run the test to confirm it fails
3. Implement minimal code to make that test pass
4. Run the test to confirm it passes
5. Move to the next test
6. Suggest refactoring opportunities when appropriate

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

## Git

Never mention "created by claude]," when you are creating git commits.
