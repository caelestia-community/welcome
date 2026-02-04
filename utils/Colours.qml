pragma Singleton

import QtQuick
import caelestia.welcome

Item {
    id: root

    property Palette palette: Palette {}

    // Get scheme path from C++ context property, with fallback
    property string schemePath: {
        if (typeof schemeFilePath !== "undefined") {
            return schemeFilePath;
        }
        // Default XDG location fallback
        const home = Qt.application.arguments.includes("--home")
            ? Qt.application.arguments[Qt.application.arguments.indexOf("--home") + 1]
            : null;

        if (home) {
            return `${home}/scheme.json`;
        }

        // Default XDG location
        return `${Qt.application.arguments[0].substring(0, Qt.application.arguments[0].lastIndexOf("/"))}/../../.local/state/caelestia/scheme.json`;
    }

    function loadScheme(): void {
        try {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "file://" + schemePath, false);
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
        const flat = flattenColours(scheme.colours || {}, "");

        for (const [name, colour] of Object.entries(flat)) {
            const propName = name.startsWith("term") ? name : `m3${name}`;
            if (palette.hasOwnProperty(propName)) {
                palette[propName] = `#${colour}`;
            }
        }
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
