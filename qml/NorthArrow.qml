/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2014 Osmo Salomaa, 2018 Rinigus
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
import "."
import "platform"

IconButtonPL {
    id: master
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: centerButton.horizontalCenter
    height: icon.height
    icon.height: icon.sourceSize.height
    icon.rotation: -map.bearing
    icon.smooth: true
    icon.source: app.getIcon("icons/north")
    icon.width: icon.sourceSize.width
    width: icon.width
    z: 500

    Bubble {
        id: bubble
        anchorItem: parent
        showArrow: false
        state: (app.mode === modes.navigate || app.mode === modes.followMe) ? "bottom-left" : "top-left"
        visible: false
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false
        onTriggered: bubble.visible = false;
    }

    onClicked: {
        map.autoRotate = !map.autoRotate;
        bubble.text = map.autoRotate ?
            app.tr("Auto-rotate on") :
            app.tr("Auto-rotate off");
        bubble.visible = true;
        timer.restart();
    }

}
