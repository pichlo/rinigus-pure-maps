/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2015 Osmo Salomaa
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0

import "js/util.js" as Util

Item {
    id: meters
    anchors.right: northArrow.left
    anchors.rightMargin: app.styler.themePaddingSmall
    anchors.verticalCenter: northArrow.verticalCenter
    height: labels.implicitHeight
    opacity: 0.9
    width: parent.width
    visible: !app.poiActive
    z: 400

    Text {
        id: values
        anchors.bottom: parent.bottom
        anchors.right: labels.left
        color: app.styler.fg
        font.bold: true
        font.family: "sans-serif"
        font.pixelSize: Math.round(app.styler.themePixelRatio * 18)
        horizontalAlignment: Text.AlignRight
        lineHeight: 1.25
    }

    Text {
        id: labels
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: app.styler.fg
        font.bold: true
        font.family: "sans-serif"
        font.pixelSize: Math.round(app.styler.themePixelRatio * 18)
        horizontalAlignment: Text.AlignLeft
        lineHeight: 1.25
        text: "\n"
    }

    Timer {
        interval: 3000
        repeat: true
        running: app.running
        triggeredOnStart: true
        onTriggered: meters.update();
    }

    function update() {
        // Update speed and positioning accuracy values in user's preferred units.
        var lines = ["—", "—"];
        if (app.conf.units === "american") {
            labels.text = " %1\n %2".arg(app.tr("mph")).arg(app.tr("ft"))
            if (gps.position.speedValid)
                lines[0] = Util.siground(gps.position.speed * 2.23694, 2);
            if (gps.position.horizontalAccuracyValid)
                lines[1] = Util.siground(gps.position.horizontalAccuracy * 3.28084, 2);
            lines[1] = "\u2300 %1".arg(lines[1]);
            values.text = lines.join("\n");
            values.doLayout();

        } else if (app.conf.units === "british") {
            labels.text = " %1\n %2".arg(app.tr("mph")).arg(app.tr("yd"))
            if (gps.position.speedValid)
                lines[0] = Util.siground(gps.position.speed * 2.23694, 2);
            if (gps.position.horizontalAccuracyValid)
                lines[1] = Util.siground(gps.position.horizontalAccuracy * 1.09361, 2);
            lines[1] = "\u2300 %1".arg(lines[1]);
            values.text = lines.join("\n");
            values.doLayout();

        } else {
            labels.text = " %1\n %2".arg(app.tr("km/h")).arg(app.tr("m"))
            if (gps.position.speedValid)
                lines[0] = Util.siground(gps.position.speed * 3.6, 2);
            if (gps.position.horizontalAccuracyValid)
                lines[1] = Util.siground(gps.position.horizontalAccuracy, 2);
            lines[1] = "\u2300 %1".arg(lines[1]);
            values.text = lines.join("\n");
            values.doLayout();

        }
    }

}
