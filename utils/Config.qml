pragma Singleton

import QtQuick
import caelestia.welcome

Item {
    id: root

    property var appearance: Appearance {}

    // Get config path from C++ context property, with fallback
    property string configPath: {
        if (typeof configFilePath !== "undefined") {
            return configFilePath;
        }
        // Default XDG location fallback
        const home = Qt.application.arguments.includes("--home")
            ? Qt.application.arguments[Qt.application.arguments.indexOf("--home") + 1]
            : null;

        if (home) {
            return `${home}/shell.json`;
        }

        // Default XDG location
        return `${Qt.application.arguments[0].substring(0, Qt.application.arguments[0].lastIndexOf("/"))}/../../.config/caelestia/shell.json`;
    }

    function loadConfig(): void {
        try {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "file://" + configPath, false);
            xhr.send();

            if (xhr.status === 200 || xhr.status === 0) {
                const config = JSON.parse(xhr.responseText);
                applyConfig(config);
            }
        } catch (e) {
            // Silently use defaults if file doesn't exist or can't be read
        }
    }

    function flattenConfigs(obj: var, prefix: string): var {
        const result = {};

        for (const [key, value] of Object.entries(obj)) {
            const newKey = prefix ? prefix + key.charAt(0).toUpperCase() + key.slice(1) : key;

            if (value !== null && typeof value === "object" && !Array.isArray(value) && typeof value !== "string") {
                Object.assign(result, flattenConfigs(value, newKey));
            } else if (typeof value === "string") {
                result[newKey] = value;
            }
        }

        return result;
    }

    function applyConfig(config: var): void {
        let flat

        flat = flattenConfigs(config.appearance.rounding || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.rounding.hasOwnProperty(name)) {
                appearance.rounding[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.spacing || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.spacing.hasOwnProperty(name)) {
                appearance.spacing[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.padding || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.padding.hasOwnProperty(name)) {
                appearance.padding[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.font.family || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.font.family.hasOwnProperty(name)) {
                appearance.font.family[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.font.size || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.font.size.hasOwnProperty(name)) {
                appearance.font.size[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.anim.curves || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.anim.curves.hasOwnProperty(name)) {
                appearance.anim.curves[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.anim.durations || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.anim.durations.hasOwnProperty(name)) {
                appearance.anim.durations[name] = `${opt}`;
            }
        }

        flat = flattenConfigs(config.appearance.transparency || {}, "");
        for (const [name, opt] of Object.entries(flat)) {
            if (appearance.transparency.hasOwnProperty(name)) {
                appearance.transparency[name] = `${opt}`;
            }
        }
    }

    Timer {
        id: fileWatcher
        interval: 500
        running: true
        repeat: true
        onTriggered: root.loadConfig()
    }

    Component.onCompleted: {
        loadConfig();
    }
}