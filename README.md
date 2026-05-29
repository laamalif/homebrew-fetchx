# Homebrew Fetchx

Homebrew tap for the portable FreeBSD `fetch` utility.

## Upstream

This tap packages [`jrmarino/fetch-freebsd`](https://github.com/jrmarino/fetch-freebsd).
The formula uses tagged archives from the
[`laamalif/fetch-freebsd`](https://github.com/laamalif/fetch-freebsd) fork so
Homebrew can install reproducible versioned releases.

## Install

```sh
brew install laamalif/fetchx/fetchx
```

Or:

```sh
brew tap laamalif/fetchx
brew install fetchx
```

## Bottles

Bottle builds run on pull requests with `brew test-bot`. When the checks pass,
add the `pr-pull` label to the pull request. The publish workflow will run
`brew pr-pull`, upload the bottles to GitHub Releases, update the formula's
`bottle do` block, and push the result to `main`.
