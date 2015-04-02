dogParksCollection = [];

$(document).ready(function(){
  if(dogParksCollection.length === 0){
    console.log('no dog parks there');
    $.ajax({
      type: "get",
      url: 'https://apricot-crisp-1097.herokuapp.com/geojson',
      dataType:"json",
    }).done(function(results) {
      dogParksCollection = results[0];
      console.log('ajax call done');
      buildmap();
    });
  } else {
    console.log(dogParksCollection);
    buildmap();
  }
  function buildmap(){
    L.mapbox.accessToken = 'pk.eyJ1IjoiZGF5eW51aGhoIiwiYSI6IlNrUWlXd0kifQ.PkwjuKO6Clksu2OGIoePeA';
    $('#mapbox_map').load(mapBox());
    console.log('in buildmap');
  }

  function mapBox(){

    console.log('in mapbox');
    var latitude = $('#mapbox_map')[0].dataset.userlatitude;
    var longitude = $('#mapbox_map')[0].dataset.userlongitude;
    var otherlat = $('#mapbox_map')[0].dataset.otherlatitude;
    var otherlong = $('#mapbox_map')[0].dataset.otherlongitude;
    var map = L.mapbox.map('mapbox_map', 'examples.map-i86nkdio').setView([37.7822891, -122.463708], 13);
    console.log('map built');
    map.on('ready', function(){
      $('#mapbox_map .active').removeClass('active');
    });

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

    var dogParksLayer = L.mapbox.featureLayer().setGeoJSON(dogParksCollection).addTo(map);


  }
});
