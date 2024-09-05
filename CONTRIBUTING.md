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

If you have a feature request, you can use our Feature Request issue template. For new component or larger scopes of work, it is a good idea to open a Request For Comments (RFC) first to gather feedback from the team. Create a [new discussion](https://github.com/getcommunity/roots/discussions/categories/rfc) in the RFC category by using our [RFC](https://github.com/getcommunity/roots/tree/main/templates/rfc.md) template.

## Connect with your community with Get Community

Send us a message through our [website contact page](https://getcommunity.com/contact/) or email our development team at [joey@getcommunity.com](mailto:joey@getcommunity.com)

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

Get Community core libraries are a polyrepo with submodules to add/remove pacakges and apps as needed. We build packages and applications with [pnpm](https://pnpm.io) and [turborepo](https://turbo.build/repo).

### Git branches

- **main** - current version.
- **develop** - contains next version, most likely you would want to create a PR to this branch.

### Commit convention

Get Community uses pre-commit hooks to enforce a commit message convention. We use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) to standardize our commit messages. This allows us to automatically generate changelogs and follow semantic versioning.

### Get Community Core Library

- Fork [repository](https://github.com/getcommunity/roots), clone or download your fork.
- Install dependencies with pnpm – `pnpm`.
- Build local version of all packages and docs – `pnpm build`.
- Build local version of all packages – `pnpm build:libs`.
- Build local version of specific packages – `pnpm -F <package-name> build`.
- To start docs – `pnpm dev:docs`.
- To start playground – `pnpm dev:core`.

<!--
### Tests - TODO need to update this section

We use [jest](https://jestjs.io/) for unit tests and [@solidjs/testing-library](https://github.com/solidjs/@solidjs/testing-library) for rendering and writing assertions. Please make sure you include tests with your pull requests. Our CI will run the tests on PRs, you can see on each PR whether you have passed all our checks.

- To run tests locally - `pnpm test`.
-->

### Pull Request

Before opening a pull request be sure to test and run the following checks:

- Format - `pnpm format`
- Check lint - `pnpm check`

To apply automatic lints run `pnpm lint`
