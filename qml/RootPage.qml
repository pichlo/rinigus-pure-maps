/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2018 Rinigus
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
import "platform"

PageEmptyPL {
    id: page

    NavigationBlock { id: navigationBlock }
    Map {
        id: map

        AttributionButton { id: attributionButton }
        CenterButton { id: centerButton }
        MenuButton { id: menuButton }
        Meters { id: meters }
        NarrativeLabel { id: narrativeLabel }
        NavigationSign { id: navigationSign }
        NorthArrow { id: northArrow }
        Notification { id: notification }
        PoiPanel { id: poiPanel }
        ScaleBar { id: scaleBar }
        SpeedLimit { id: speedLimit }
        StreetName { id: streetName }
        ZoomLevel { id: zoomLevel }
    }
    RemorsePopupPL { id: remorse; z: 1000 }

    Component.onCompleted: {
        app.map = map;
        app.notification = notification;
        app.remorse = remorse;
    }

}
