pragma Singleton

import QtQuick
import Caelestia
import caelestia.welcome

Item {
    id: root

    property Palette palette: Palette {}
    readonly property alias wallLuminance: analyser.luminance

    // Get state path from C++ context property, with fallback
    property string statePath: {
        if (typeof stateFilePath !== "undefined") {
            return stateFilePath;
        }
        // Default XDG location fallback
        const home = Qt.application.arguments.includes("--home")
            ? Qt.application.arguments[Qt.application.arguments.indexOf("--home") + 1]
            : null;

        if (home) {
            return `${home}`;
        }

        // Default XDG location
        return `${Qt.application.arguments[0].substring(0, Qt.application.arguments[0].lastIndexOf("/"))}/../../.local/state/caelestia`;
    }

    function getWallpaperPath(): string {
        let wallpaperPath = "";

        try {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "file://" + statePath + '/wallpaper/path.txt', false);
            xhr.send();

            if (xhr.status === 200 || xhr.status === 0) {
                wallpaperPath = xhr.responseText.trim();
            }

            return wallpaperPath;
        } catch (e) {
            return wallpaperPath;
        }
    }

    function loadScheme(): void {
        try {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "file://" + statePath + '/scheme.json', false);
            xhr.send();

            if (xhr.status === 200 || xhr.status === 0) {
                const scheme = JSON.parse(xhr.responseText);
                applyScheme(scheme);
            }
        } catch (e) {
            // Silently use defaults if file doesn't exist or can't be read
        }
    }

    function flattenColours(obj: var, prefix: string): var {
        const result = {};

        for (const [key, value] of Object.entries(obj)) {
            const newKey = prefix ? prefix + key.charAt(0).toUpperCase() + key.slice(1) : key;

            if (value !== null && typeof value === "object" && !Array.isArray(value) && typeof value !== "string") {
                Object.assign(result, flattenColours(value, newKey));
            } else if (typeof value === "string") {
                result[newKey] = value;
            }
        }

        return result;
    }

    function applyScheme(scheme: var): void {
        if (scheme.mode)
            palette.mode = scheme.mode;

        const flat = flattenColours(scheme.colours || {}, "");

        for (const [name, colour] of Object.entries(flat)) {
            const propName = name.startsWith("term") ? name : `m3${name}`;
            if (palette.hasOwnProperty(propName)) {
                palette[propName] = `#${colour}`;
            }
        }
    }

    function getLuminance(c: color): real {
        if (c.r == 0 && c.g == 0 && c.b == 0)
            return 0;

        return Math.sqrt(0.299 * (c.r ** 2) + 0.587 * (c.g ** 2) + 0.114 * (c.b ** 2))
    }

    function alterColour(c: color, a: real, layer: int): color {
        const luminance = getLuminance(c);
        const light = palette.mode === "light";

        const offset = (!light || layer == 1 ? 1 : -layer / 2) * (light ? 0.2 : 0.3) * (1 - Config.appearance.transparency.base) * (1 + wallLuminance * (light ? (layer == 1 ? 3 : 1) : 2.5));
        const scale = (luminance + offset) / luminance;

        const r = Math.max(0, Math.min(1, c.r * scale));
        const g = Math.max(0, Math.min(1, c.g * scale));
        const b = Math.max(0, Math.min(1, c.b * scale));

        return Qt.rgba(r, g, b, a);
    }

    function layer(c: color, layerNum: var): color {
        if (!Config.appearance.transparency.enabled)
            return c;

        return layerNum === 0 ? Qt.alpha(c, Config.appearance.transparency.base) : alterColour(c, Config.appearance.transparency.layers, layerNum ?? 1);
    }

    ImageAnalyser {
        id: analyser

        source: root.getWallpaperPath()
    }

    Timer {
        id: fileWatcher
        interval: 500
        running: true
        repeat: true
        onTriggered: root.loadScheme()
    }

    Component.onCompleted: {
        loadScheme();
    }
}
