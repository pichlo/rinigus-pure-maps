/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2014 Osmo Salomaa
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
import Sailfish.Silica 1.0
import "."

Page {
    allowedOrientations: Orientation.All
    SilicaListView {
        id: listView
        anchors.fill: parent
        delegate: ListItem {
            id: listItem
            Image {
                id: iconImage
                anchors.left: parent.left
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                source: "icons/" + model.icon + ".png"
                verticalAlignment: Image.AlignVCenter
                width: implicitWidth + 2*Theme.paddingMedium
            }
            Label {
                id: narrativeLabel
                anchors.left: iconImage.right
                anchors.leftMargin: Theme.paddingMedium
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                color: model.active || listItem.highlighted?
                    Theme.highlightColor : Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                text: model.narrative
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.WordWrap
            }
            Label {
                id: lengthLabel
                anchors.left: iconImage.right
                anchors.leftMargin: Theme.paddingMedium
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                anchors.top: narrativeLabel.bottom
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                text: model.index < listView.count-1 ?
                    "Continue for " + model.length + "." : ""
                verticalAlignment: Text.AlignTop
            }
            Component.onCompleted: {
                var textHeight = narrativeLabel.height + lengthLabel.height;
                var height = Math.max(iconImage.height, textHeight);
                height = height + 2*Theme.paddingMedium;
                iconImage.height = height;
                narrativeLabel.height += (height - textHeight)/2;
                lengthLabel.height += (height - textHeight)/2;
                listItem.contentHeight = height;
            }
            onClicked: {
                map.autoCenter = false;
                map.setCenter(model.x, model.y);
                map.zoomLevel < 16 && map.setZoomLevel(16);
                app.pageStack.pop(mapPage, PageStackAction.Immediate);
            }
        }
        header: PageHeader { title: "Maneuvers" }
        model: ListModel { id: listModel }
        VerticalScrollDecorator {}
    }
    Component.onCompleted: {
        // Load narrative from the Python backend.
        var args = [map.center.longitude, map.center.latitude];
        py.call("poor.app.narrative.get_maneuvers", args, function(maneuvers) {
            var activeIndex = -1;
            for (var i = 0; i < maneuvers.length; i++) {
                listModel.append(maneuvers[i]);
                if (maneuvers[i].active) activeIndex = i;
            }
            if (activeIndex >= 0)
                listView.positionViewAtIndex(activeIndex, ListView.Center);
        });
    }
}