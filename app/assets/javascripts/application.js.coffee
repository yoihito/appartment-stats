#= require lodash
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .
#= require highcharts
#= require chartkick
#= require leaflet
#= require leaflet.markercluster/dist/leaflet.markercluster-src.js

window.onload = () ->

  map = L.map('map', {
    center: [53.90, 27.5666],
    zoom: 10
  })
  L.tileLayer('http://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
    maxZoom: 19
  }).addTo(map)

  icon = new L.Icon({
    iconUrl: $('#map').data('marker-url'),
    retinaUrl: $('#map').data('marker-2x-url'),
    shadowUrl: $('#map').data('marker-shadow-url'),
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
  })

  markers = L.markerClusterGroup(
    iconCreateFunction: (cluster) ->

      childCount = cluster.getChildCount()
      c = ' marker-cluster-'
      if childCount < 10
        c += 'small'
      else if childCount < 100
        c += 'medium'
      else
        c += 'large'

      new L.DivIcon({ html: '<div><span>' + childCount + '</span></div>', className: 'marker-cluster' + c, iconSize: new L.Point(40, 40) })
    )

  apartments = L.geoJson(
    gon.apartments_geojson,
    pointToLayer: (feature, latlng) ->
      icon = new L.DivIcon({ html: '<div><span>'+"$"+feature.price_usd+'</span></div>', className: 'marker-cluster marker-cluster-small', iconSize: new L.Point(40, 40) })

      marker =  L.marker(latlng, {icon: icon})
      marker.bindPopup("$"+feature.price_usd)
      marker.on('mouseover', (e) ->
        @openPopup();
      );
      marker.on('mouseout', (e) ->
        @closePopup();
      );
  )
  markers.addLayer(apartments)
  map.addLayer(markers)
