# RBX UI

A comprehensive collection of reusable UI components for Roblox games built with [Vide](https://github.com/centau/vide). This library provides a set of production-ready components designed to streamline UI development in Roblox.

## Features

- **Component-Based Architecture**: Modular, reusable UI components
- **Vide Integration**: Built with Vide for reactive and declarative UI
- **Theming Support**: Centralized theme management with customizable styling
- **Animation Support**: Built-in motion and transition components
- **Type-Safe**: Developed in Luau with full type annotations
- **Developer-Friendly**: Simple APIs with comprehensive component library

## Available Components

| Component       | Description                                              |
| --------------- | -------------------------------------------------------- |
| **Button**      | Standard clickable button with various states and styles |
| **IconButton**  | Compact button component displaying an icon              |
| **Card**        | Container component for organizing content               |
| **Panel**       | Flexible panel component for UI layouts                  |
| **Modal**       | Dialog/modal window for overlaying content               |
| **Toggle**      | Switch component for boolean states                      |
| **Slider**      | Range input component for numeric values                 |
| **ProgressBar** | Visual progress indicator                                |
| **Motion**      | Animation and motion utilities                           |
| **Theme**       | Theme system for consistent styling across components    |

## Installation

This project uses [Wally](https://wally.run/) for dependency management.

```toml
[dependencies]
RbxUI = "renz/rbx-ui@0.1.0"
```

Run `wally install` to download dependencies.

## Getting Started

### Building the Place

To build the Roblox place from scratch:

```bash
rojo build -o "RBX UI.rbxlx"
```

### Serving in Development

Open `RBX UI.rbxlx` in Roblox Studio, then start the Rojo server for live sync:

```bash
rojo serve
```

For detailed information, see [Rojo documentation](https://rojo.space/docs).

## Usage

### Basic Component Example

```luau
local UI = require(game.ReplicatedStorage.Components.UI)

local Button = UI.Button({
    Label = "Click Me",
    OnClick = function()
        print("Button clicked!")
    end
})
```

### Theme Customization

Use the Theme component to manage and apply custom styling:

```luau
local Theme = require(game.ReplicatedStorage.Components.UI.Theme)

Theme:SetColor("Primary", Color3.fromRGB(255, 100, 50))
```

## Project Structure

```
RBX UI/
├── Components/
│   └── UI/                    # Reusable UI components
│       ├── Button.luau
│       ├── Card.luau
│       ├── IconButton.luau
│       ├── Modal.luau
│       ├── Motion.luau
│       ├── Panel.luau
│       ├── ProgressBar.luau
│       ├── Slider.luau
│       ├── Theme.luau
│       ├── Toggle.luau
│       └── init.luau
├── Packages/                  # Wally dependencies
├── src/
│   ├── client/               # Client-side scripts
│   ├── server/               # Server-side scripts
│   └── shared/               # Shared utilities
└── default.project.json      # Rojo project configuration
```

## Dependencies

- [Vide](https://github.com/centau/vide) - Reactive UI framework
- [Promise](https://github.com/evaera/promise) - Async/await utilities
- [Networker](https://github.com/leifstout/networker) - Network communication

## Development

### Requirements

- [Rojo](https://github.com/rojo-rbx/rojo) 7.6.1+
- [Wally](https://wally.run/) - Package manager
- [Roblox Studio](https://www.roblox.com/create)

### Setup

1. Clone the repository
2. Install dependencies: `wally install`
3. Build the place: `rojo build -o "RBX UI.rbxlx"`
4. Open the generated file in Roblox Studio
5. Start the development server: `rojo serve`

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to improve the component library.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions, please open an issue on the repository.

---

Built with ❤️ for the Roblox developer community
