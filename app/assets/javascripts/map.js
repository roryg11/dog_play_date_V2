$(document).ready(function(){
  L.mapbox.accessToken = 'pk.eyJ1IjoiZGF5eW51aGhoIiwiYSI6IlNrUWlXd0kifQ.PkwjuKO6Clksu2OGIoePeA';
  var map = L.mapbox.map('mapbox_map', 'dayynuhhh.lkhpm9lc');
  map.on('ready', function(){
    $('#mapbox_map .active').removeClass('active');
  });

  mapBox();

  function mapBox(){
    var latitude = $('#mapbox_map')[0].dataset.userlatitude;
    var longitude = $('#mapbox_map')[0].dataset.userlongitude;
    var otherlat = $('#mapbox_map')[0].dataset.otherlatitude;
    var otherlong = $('#mapbox_map')[0].dataset.otherlongitude;

    var featureArray = [];

    featureArray.push({
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [longitude, latitude]
        },
        "properties": {
          'marker-color': '#38a591',
        }
      },
      {
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [otherlong, otherlat]
        },
        "properties": {
          'marker-color': '#38a591',
        }
      });
    var geojson = [{
                    "type": "FeatureCollection",
                    "features": featureArray
                  }];
    var usersLocations = L.mapbox.featureLayer().setGeoJSON(geojson).addTo(map);

    map.fitBounds(usersLocations.getBounds());

    var dogParksCollection = [];
    $.ajax({
      type: "get",
      url: '/parks/geojson',
      dataType:"json",
    }).done(function(results) {
      dogParksCollection = results[0];
      L.mapbox.featureLayer().setGeoJSON(dogParksCollection).addTo(map);
    });
  }
});
