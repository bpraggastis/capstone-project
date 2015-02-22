$(function(){

  var latLngCenter = "";
  var map = "";
  var geocoder = "";
  var markers = {};
  var circles = {};
  var infoLocation = "";
  var latLngBounds = "";
  var visible_markers = {};

  function initialize() {


    var mapElement = $("#map-canvas");

    var latitude = parseFloat(mapElement.attr('data-center-latitude'));
    var longitude = parseFloat(mapElement.attr('data-center-longitude'));

    var latLngCenter = new google.maps.LatLng(latitude,longitude);

    var mapOptions = {
      center: latLngCenter,
      zoom: 4,
      mapTypeControl: true,
      mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
          position: google.maps.ControlPosition.BOTTOM_CENTER
      },
      zoomControl: true,
      zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL,
          position: google.maps.ControlPosition.RIGHT_TOP
      },
      panControl: true,
      panControlOptions: {
        position: google.maps.ControlPosition. RIGHT_TOP
      }
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    latLngBounds = new google.maps.LatLngBounds();
    geocoder = new google.maps.Geocoder();

    var center = latLngCenter;
    var calculateCenter = function(){
      center = map.getCenter();
    };
    google.maps.event.addDomListener(map, 'idle', function() {
      calculateCenter();
    });
    google.maps.event.addDomListener(window, 'resize', function() {
      map.setCenter(center);
    });


  }

  // ------>>>>>>>>>>>>>>>> ends initialize

  var content_string = function(my_content,id){ string = '<div '+
              'style="margin:0;padding:10px;border:solid black;text-align: center;">' +
              ' <h5>'+ my_content + '</h5>' +
              '<button style="background-color: #58f55b; border-radius: 30px; color: navy;}' +
              ' href="#" id="extra-info-'+id+'" data-marker-id='+ id +
              ' data-toggle="modal" data-target="#myModal">More Information</button>&nbsp&nbsp&nbsp&nbsp' +
              '<button style="background-color: #7f040e; border-radius: 30px; color: white;}' +
              ' href="#" id="remove-marker-'+id+'" data-marker-id='+ id +
              ' >Remove Marker</button></div>';
              return string;
  };

  var myInfoWindow = function(my_content, my_marker){
    var infowindow = new google.maps.InfoWindow({

      content: content_string(my_content, my_marker.event_id),
    });
    infowindow.open(map, my_marker);
    google.maps.event.addListener(infowindow, 'domready', function(){
      $('#remove-marker-'+my_marker.event_id).click(remove_marker);
      $('#extra-info-'+my_marker.event_id).click(extra_information);
    });
  };

  var make_mark = function(event){
    var id = event.attr('data-event-id');
    var latitude = parseFloat(event.attr('data-latitude'));
    var longitude = parseFloat(event.attr('data-longitude'));
    if (markers[id] == null && latitude !== 0 && longitude !== 0)
      {
        // var disease = event.data("disease").replace(/\_/g, ' ');
        var disease = event.attr('data-disease').replace(/\_/g, ' ');
        var location = event.attr('data-location').replace(/\_/g, ' ');
        var number = event.attr('data-number-infected');
        var date = event.attr('data-date');

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(latitude,longitude),
          opacity: 1,
          event_id: id,
          event_disease: disease,
          event_location: location,
          event_number: number,
          event_date: date,
        });

        markers[id]= marker;
        latLngBounds.extend(marker.position);
        map.setCenter(latLngBounds.getCenter());
        if(markers.count > 1){
          map.setZoom(24);
          map.fitBounds(latLngBounds);
          }

        // Make a corresponding circle
        var circleCenter = marker.position;
        var circleRadius = marker.event_number * 45000/250.0;
        var circleOpacity = marker.event_number * 0.35/250 + 0.15;

        var populationOptions = {
          strokeColor: '#FF0000',
          strokeOpacity: 0.10,
          strokeWeight: 2,
          fillColor: '#FF0000',
          fillOpacity: circleOpacity,
          map: map,
          center: circleCenter,
          radius: circleRadius,
          clickable: true,
        };
        mycircle = new google.maps.Circle(populationOptions);
        circles[id] = mycircle;
        // mycircle.setMap(null);
        // marker.setMap(map);



        // Geocoder will return the closest community name for display in the infowindow
        // google.maps.event.addListener(mycircle, 'click', function(e){
        google.maps.event.addListener(marker, 'click', function(e){
          geocoder.geocode({"latLng" : marker.position}, function(results,status){
              if(status == google.maps.GeocoderStatus.OK){
                if(results[0] !== null){
                  info = results[0].formatted_address.replace(/(.+),(.+),(.+), USA/g,"$2, $3");
                }
                else{
                  info = marker.event_location;
                }
              }
              else{
                info = marker.event_location;
              }
              var infoString = marker.event_date + ": " +
                  marker.event_disease + " infected " +
                    marker.event_number + " people in " + marker.event_location +
                    "<br> near " + info;


              myInfoWindow(infoString, marker);
          });

        });
        google.maps.event.addListener(mycircle, 'click', function(e){
          marker.setMap(map);
        });

      }
      else
        {console.log("duplicate");}
  };///------------------->>>>>>>>>>>>>>>>>>>>>>>>>>End of make_mark


  var place_marker = function(e){
    var new_mark = $(e.target.parentElement);
    make_mark(new_mark);
  };

  var auto_marks = function(){
    var spots = $(".place-marker").children("tbody").children(".location-marker");
    spots.each(function(index,value){
      event = $(value);
      make_mark(event);
    });

  };


  var clear_markers = function(){
    var key_set = Object.keys(markers);
    $.each(key_set, function(index,key){
      markers[key].setMap(null);
      circles[key].setMap(null);
    });
    visible_markers = {};

  };

  var show_circles = function(){
    var key_set = Object.keys(markers);
    $.each(key_set, function(index,key){
      circles[key].setMap(map);
    });
  };

  var showCircle = function(id){
    circles[id].setMap(map);
  };

  var show_marker = function(e){

    if(visible_markers === {}){
    latLngBounds = new google.maps.LatLngBounds();
    }
    var id = $(e.target.parentElement).attr('data-event-id');
    console.log(id);
    marker = markers[id];
    visible_markers[id] = marker;
    marker.setMap(map);
    showCircle(id);

    latLngBounds.extend(marker.position);


      map.setCenter(latLngBounds.getCenter());


  };

  var remove_marker = function(e){
    id = $(e.target).attr('data-marker-id');
    markers[id].setMap(null);
    visible_markers[id] = null;
    // markers[id] = null;
    // circles[id] = null;
  };

  var extra_information = function(e){
    id = $(e.target).attr('data-marker-id');
    $.get(
      "/medical_conditions/show/"+id,
      function(data){
        var modal = $('#myModal');
        response = data;
        console.log(data);
        modal.find('.modal-content').html('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
          '<div style="display: block;font: 1.5em serif;padding: 30px;">'+
        ' <h3 style="font-size: bold 3em serif">'+response.medical_condition.name+'</h3>'+
        ' <img src='+ response.image+' alt="" style="float:left;margin:10px;max-width:50%;max-height:100;" /><br> ' +
        response.medical_condition.description + '</div>');
        modal.modal('show')
      }

    );

  };

  $(".location-marker").click(show_marker);
  $(".clear-markers").click(clear_markers);
  $(".auto-mark").click(show_circles);

  $(document).click(function(e){
    console.log(e.target);
  });

  var main = function(){initialize(); auto_marks();};

  google.maps.event.addDomListener(window, 'load', main);

});
