#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .
#= require highcharts
#= require chartkick
#= require leaflet

window.onload = () ->

  map = L.map('map', {
    center: [53.90, 27.5666],
    zoom: 10
  })
  L.tileLayer('http://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
    maxZoom: 18
  }).addTo(map)

  L.geoJson(gon.districts_geojson).addTo(map)



