# Honeybadger Homebrew Tap

This is the official [Homebrew](https://brew.sh/) tap for Honeybadger tools.

## Installation

```bash
brew tap honeybadger-io/tap
brew install honeybadger
```

Or install directly:

```bash
brew install honeybadger-io/tap/honeybadger
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `honeybadger` | CLI tool to interact with the Honeybadger API |

## Updating

To update to the latest version:

```bash
brew update
brew upgrade honeybadger
```

## Usage

After installation, the `hb` command will be available:

```bash
# Report a deployment
hb deploy --environment production --repository github.com/org/repo --revision abc123

# Start the metrics agent
hb agent

# Get help
hb --help
```

## Configuration

Configure the CLI using environment variables:

```bash
export HONEYBADGER_API_KEY=your-api-key-here
export HONEYBADGER_ENDPOINT=https://api.honeybadger.io  # Optional
```

Or use a configuration file at `config/honeybadger.yml`:

```yaml
api_key: your-api-key-here
endpoint: https://api.honeybadger.io
```

## Issues

For issues with the CLI itself, please file them at [honeybadger-io/cli](https://github.com/honeybadger-io/cli/issues).

For issues with the Homebrew formula, please file them here.

## License

MIT