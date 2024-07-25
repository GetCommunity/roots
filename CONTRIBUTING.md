# Contributing to Get Community Core Library

First of all, thank you for showing interest in contributing to Get Community, Inc. Here you will find information on how to propose bug fixes, suggest improvements, and develop locally.

## Vision

...

### Principles

#### Accessible

- Components adhere to WAI-ARIA guidelines and are tested regularly in a wide selection of modern browsers and assistive technologies.
- Where WAI-ARIA guidelines do not cover a particular use case, prior research is done to determine the patterns and behaviors we adopt when designing a new component.
- Developers should know about accessibility but shouldn't have to spend too much time implementing accessible patterns.
- Most behavior and markup related to accessibility should be abstracted, and bits that can't should be simplified where possible.
- Components are thoroughly tested on a variety of devices and assistive technology, including all major screen reader vendors (VoiceOver, JAWS, NVDA).

### Other considerations

#### Internationalization

- When applicable, components support international string formatting and make behavioral adjustments for right-to-left languages.

#### Developer experience

- Component APIs should be relatively intuitive and as declarative as possible.

## Reporting issues

### Bugs

We use [GitHub issues](https://github.com/getcommunity/roots/issues) to track work and log bugs. Please check existing issues before filing anything new. We do our best to respond to issues within a few days. If you would like to contribute a fix, please let us know by leaving a comment on the issue.

The best way to reduce back and forth on a bug is to provide a small code example exhibiting the issue along with steps to reproduce it. If you would like to work on a bugfix yourself, make sure an issue exists first.

Please follow the issue templates when filing new ones and add as much information as possible.

### Feature requests

Kobalte components can always be improved upon. If you have a feature request, you can use our Feature Request issue template. For new component or larger scopes of work, it is a good idea to open a Request For Comments (RFC) first to gather feedback from the team. Create a [new discussion](https://github.com/kobaltedev/kobalte/discussions/categories/rfc) in the RFC category by using our [RFC](https://github.com/kobaltedev/kobalte/tree/main/templates/rfc.md) template.

## Connect with the community

The [Kobalte channel](https://discord.com/channels/722131463138705510/1063803756388548709) on SolidJS's discord is a great place to chat about Kobalte.

## Pull requests

For new components and significant changes, it is recommended that you first propose your solution in an [RFC](#feature-requests) and gather feedback.

A few things to keep in mind before submitting a pull request:

- Add a clear description covering your changes.
- Reference the issue in the description.
- Make sure linting and tests pass.
- Include relevant tests.
- Update documentation.
- Remember that all submissions require review, please be patient.

The team will review all pull requests and do one of the following:

- Request changes to it.
- Merge it.
- Close it with an explanation.

## Where to start

If you are looking for place to start, consider the following options:

- Look for issues tagged with help wanted and/or good first issue.
- Help triage existing issues by investigating problems and following up on missing information.
- Update missing or fix existing documentation.
- Review and test open pull requests.

## Developing

Kobalte is a monorepo built with [pnpm](https://pnpm.io) and [turborepo](https://turbo.build/repo).

### Git branches

- **main** - current version.
- **develop** - contains next version, most likely you would want to create a PR to this branch.

### Commit convention

Kobalte follows the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) and use [commitizen](https://github.com/commitizen/cz-cli) to run the linter and type checker before each commit.

### Get started with Kobalte locally

- Install [editorconfig](https://editorconfig.org/) extension for your editor.
- Fork [repository](https://github.com/kobaltedev/kobalte), clone or download your fork.
- Install dependencies with pnpm – `pnpm`.
- Build local version of all packages and docs – `pnpm build`.
- Build local version of all packages – `pnpm build:libs`.
- Build local version of specific packages – `pnpm -F <package-name> build`.
- To start docs – `pnpm dev:docs`.
- To start playground – `pnpm dev:core`.

### Tests

We use [jest](https://jestjs.io/) for unit tests and [@solidjs/testing-library](https://github.com/solidjs/@solidjs/testing-library) for rendering and writing assertions. Please make sure you include tests with your pull requests. Our CI will run the tests on PRs, you can see on each PR whether you have passed all our checks.

- To run tests locally - `pnpm test`.

### Pull Request

Before opening a pull request be sure to test and run the following checks:

- Format - `pnpm format`
- Check lint - `pnpm check`

To apply automatic lints run `pnpm lint`
