# odoo_dev_helper (odh)

A CLI tool that automates repetitive tasks in Odoo development — scaffolding modules, setting up development databases from production dumps, and keeping the tool itself up to date.

## Features

- **Module scaffolding** — generates a properly structured Odoo module with `__init__.py` and a prefilled `__manifest__.py`
- **Database setup** — drops, recreates, and restores a DB from a SQL dump, then runs a cleanup script to make it safe for local development (disables crons, email servers, resets passwords, extends enterprise expiration)
- **Self-update** — checks GitHub for a newer version and applies it in place
- **Clean uninstall** — removes the alias and installation directory entirely

## Requirements

- Bash
- Git
- `psql` / `createdb` / `dropdb` (PostgreSQL client tools)
- `curl`

## Installation

```bash
git clone https://github.com/adnansabbir/odoo_dev_helper.git
cd odoo_dev_helper
bash setup.sh
```

This installs `odh` to `~/bin/odh` and adds an alias to your `.bashrc` / `.zshrc`. Restart your terminal or run `source ~/.zshrc` (or `~/.bashrc`) to start using it immediately.

## Usage

```
odh <command> [options]
```

| Command | Alias | Description |
|---|---|---|
| `help` | `-h` | Show available commands |
| `create_module` | `cm` | Scaffold a new Odoo module |
| `setup_db` | `sd` | Set up a local dev database from a dump |
| `update` | `up` | Check for updates and apply them |
| `remove` | `rm` | Uninstall `odh` |

---

### `create_module` — scaffold a new Odoo module

Creates a new module directory in your current working directory with `__init__.py` and a prefilled `__manifest__.py`.

```bash
odh create_module --name=module_name
odh cm --name=module_name

# Specify an Odoo version (defaults to 17)
odh cm --name=my_custom_module#16
```

The module name is auto-formatted for the manifest — `my_custom_module` becomes `My Custom Module`.

**Output structure:**

```
my_custom_module/
├── __init__.py
└── __manifest__.py
```

---

### `setup_db` — restore a dump and sanitize for local dev

Expects a `dump.sql` file in your **current directory**. Drops the target database if it exists, recreates it, imports the dump, then runs the cleanup script automatically.

```bash
odh setup_db --n=my_db
odh sd --n=my_db
```

**What the cleanup script does:**

| Action | Why |
|---|---|
| Disables all crons | Prevents background jobs from running unexpectedly |
| Disables all email servers | Stops accidental emails to real users |
| Extends enterprise expiration to 2042 | Avoids license expiry blocking local work |
| Randomizes the database UUID | Prevents the dev instance from reporting to odoo.com as the production database |
| Adds a Mailcatcher SMTP server (`localhost:1025`) | Catches outgoing emails locally |
| Resets all user passwords to their login | Easy login for any user |
| Resets admin password to `admin`, re-enables the admin account | Consistent local access |
| Clears all TOTP secrets | Removes 2FA barriers in local dev |

---

### `update` — update odh

```bash
odh update
odh up
```

Checks the GitHub repo for a newer version and updates the local installation if one is found.

---

### `remove` — uninstall odh

```bash
odh remove
odh rm
```

Removes the `odh` alias from your shell config and deletes the installation directory.

## Version

Current version: **1.0.0**

## License

MIT
