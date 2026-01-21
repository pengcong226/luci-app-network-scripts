# Changelog

## [3.0.1] - 2026-01-21

### Changed

- **Project Structure**: Reorganized directory structure, removed redundant `ff0f8630...` subdirectory
- **Internationalization**: Converted all Chinese strings to English with `translate()` wrapper
- **Makefile**: Updated to use standard `luci.mk` build system

### Added

- **Translation Support**: Added `po/templates/network-scripts.pot` template
- **Chinese Translation**: Added `po/zh_Hans/network-scripts.po` for Chinese localization
- Separate `luci-i18n-network-scripts-zh-cn` package will be generated during build

### Fixed

- Fixed Unicode quote character (`"`) causing Lua syntax error
- Removed Chinese comments that could cause issues with SrcDiet processing

### Removed

- Removed deprecated `network_scripts/` and `schoolnet/` directories
- Removed unused `index.html` and backup files

## [3.0] - Initial Release

### Features

- Multi-WAN switching between broadband and CPE
- Campus network authentication support
- Quality monitoring (latency/packet loss)
- Time-based schedule policy
- DingTalk notification integration
- History statistics and logging
- Manual control interface
