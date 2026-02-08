# Caelestia Welcome

A welcome and knowledge center application for Caelestia's live image, built with QuickShell.

## Setup

### For Development

1. Clone repository
2. Generate the qmldir files for your system:
   ```bash
   ./generate-qmldir.sh
   ```
3. Run the application:
   ```bash
   quickshell -p .
   ```
4. Before committing, restore guest paths:
   ```bash
   ./generate-qmldir.sh guest
   ```


### Git Workflow

The script supports two modes:
- `./generate-qmldir.sh` - Generate with local paths for development
- `./generate-qmldir.sh guest` - Restore `/home/guest` paths before committing

Run `./generate-qmldir.sh guest` before committing to ensure the paths are correct for live image.


### Module Redirects

Using qmldir files in the `qs/` directory to redirect module imports to Caelestia's actual files:

- `qs/services/qmldir` → Caelestia services (Colours, Wallpapers)
- `qs/config/qmldir` → Caelestia config (Appearance, Config)
- `qs/utils/qmldir` → Caelestia utils (Paths, Searcher)
- `qs/components/qmldir` → Caelestia components (MaterialIcon, StyledText)

These qmldir files contain `file://` URLs pointing to Caelestia's installation. The `generate-qmldir.sh` script creates these files with the correct paths for your system using `${XDG_CONFIG_HOME:-$HOME/.config}/quickshell/caelestia`.


The app uses environment variable expansion in `shell.qml`: 
```qml
//@ pragma Env QML2_IMPORT_PATH=.:${XDG_CONFIG_HOME:-$HOME/.config}/quickshell/caelestia/build/qml
```


## Development

### Adding New Caelestia Components

If you need to use additional Caelestia components:

1. Add them to the appropriate qmldir in `generate-qmldir.sh`
2. Run `./generate-qmldir.sh` to regenerate the qmldir files
3. Import the module in your QML file (e.g., `import qs.components`)
