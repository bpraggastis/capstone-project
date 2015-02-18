$(function(){

  var map;
  var geocoder;
  markers = {};
  infoLocation = "";

  function initialize() {

    var mapElement = $("#map-canvas");

    var latitude = parseFloat(mapElement.attr('data-center-latitude'));
    var longitude = parseFloat(mapElement.attr('data-center-longitude'));

    var latLng = new google.maps.LatLng(latitude,longitude);
    var mapOptions = {
      center: latLng,
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

    geocoder = new google.maps.Geocoder();
  }

  // ends initialize

  var content_string = function(my_content,id){ string = '<div '+
              'style="margin:0;padding:10px;background-color:#fffa67;text-align: center;">' +
              ' <h5>'+ my_content + '</h5>' +
              '<button style="background-color: #58f55b; border-radius: 30px; color: navy;}' +
              ' href="#" id="extra-info" data-marker-id='+ id +
              ' >More Information</button>&nbsp&nbsp&nbsp&nbsp' +
              '<button style="background-color: #7f040e; border-radius: 30px; color: white;}' +
              ' href="#" id="remove-marker" data-marker-id='+ id +
              ' >Remove Marker</button></div>';
              return string;
  };

  var myInfoWindow = function(my_content, my_marker){
    var infowindow = new google.maps.InfoWindow({
      content: content_string(my_content, my_marker.event_id),
    });
    infowindow.open(map, my_marker);
    google.maps.event.addListener(infowindow, 'domready', function(){
      $('#remove-marker').click(remove_marker);
      $('#extra-info').click(extra_information);
    });
  };
  var make_mark = function(event){
    var id = event.attr('data-event-id');
    var latitude = parseFloat(event.attr('data-latitude'));
    var longitude = parseFloat(event.attr('data-longitude'));


    if (markers[id] == null && latitude !== 0 && longitude !== 0)
      {
        var disease = event.attr('data-disease').replace(/\_/g, ' ');
        var location = event.attr('data-location').replace(/\_/g, ' ');
        var number = event.attr('data-number-infected');
        var date = event.attr('data-date');

        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(latitude,longitude),
          event_id: id,
          event_disease: disease,
          event_location: location,
          event_number: number,
          event_date: date,

        });
        marker.setMap(map);
        markers[id]= marker;
        google.maps.event.addListener(marker, 'click', function(e){

          geocoder.geocode({"latLng" : marker.position}, function(results,status){
              if(status == google.maps.GeocoderStatus.OK){
                if(results[0] !== null){
                  info = results[0].formatted_address.replace(/(.+),(.+),(.+), USA/g,"$2, $3");
                }
                else{
                  info = marker.location;
                }
              }
              else{
                info = marker.location;
              }
              var infoString = marker.event_disease + " infected " +
                    marker.event_number + " people near " +
                    " "+ info;
              myInfoWindow(infoString, marker);
          });

        });
      }
      else
        {console.log("duplicate");}
  };


  var place_marker = function(e){
    var new_mark = $(e.target);
    make_mark(new_mark);
  };

  var auto_marks = function(){
    var spots = $(".place-marker").children(".location-marker");
    spots.each(function(index,value){
      event = $(value);
      make_mark(event);
    });
  };

  var clear_markers = function(){
    var key_set = Object.keys(markers);
    $.each(key_set, function(index,key){
      markers[key].setMap(null);
    });
    markers = {};
  };

  var remove_marker = function(e){
    id = $(e.target).attr('data-marker-id');
    markers[id].setMap(null);
  };

  var extra_information = function(e){
    id = $(e.target).attr('data-marker-id');
    console.log("Extra Information for event #", id, " goes here.");
  };

  var graph_trigger = function(){
    if ($("#graph").css("height") == "0px") {
      $("#graph").css("height", "350px");
      $("#map-canvas").css("width", "auto");
    } else {
      $("#graph").css("height", "0px");
      $("#map-canvas").css("width", "100%");
    }
  };


  $(".location-marker").click(place_marker);
  $(".clear-markers").click(clear_markers);
  $(".auto-mark").click(auto_marks);
  $("#graph-trigger").click(graph_trigger);

  $(document).click(function(e){
    console.log(e.target);
  });


  google.maps.event.addDomListener(window, 'load', initialize);

});