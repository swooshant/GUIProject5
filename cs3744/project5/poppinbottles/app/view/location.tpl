<div id="bodyWrapper">

	<h2 class="aboutUsHeadings" > Locations </h2>

  <form action="<?= BASE_URL ?>/locations/" method="POST">
    <div class="zipcodecontainer">
      <input type='text' name='address' placeholder='Enter address or zip code' />
      <input type='submit' value='Find!' />
    </div>
  </form>

  <!-- The following gets the latitude and longitude from the user's input -->
  <?php
    if($_POST) {
      // get latitude, longitude and formatted address
      $data_arr = $this->geocode($_POST['address']);

      // if able to geocode the address
      if($data_arr){
        $latitude = $data_arr[0];
        $longitude = $data_arr[1];
        $formatted_address = $data_arr[2]; 
  ?>

  <!-- google map will be shown here -->
  <div id="map"></div>
  <div id='map-label'>Map shows local vineyards 5 miles from your location!</div>

  <!-- JavaScript to show google map -->
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAWgxNoCo1FVZSm6azr-hXBV9Okvmzz3uI&libraries=places"></script>    
  <script type="text/javascript">
    var map;

    //This function creates the map when the user clicks "Find!"
    function init_map() {
      var myOptions = {
        zoom: 10,
        center: new google.maps.LatLng(<?php echo $latitude; ?>, <?php echo $longitude; ?>),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById("map"), myOptions);

      var request = {
        location: myOptions.center,
        radius: 10000,
        query: 'vineyard'
      }

      var service = new google.maps.places.PlacesService(map);
      service.textSearch(request, callback);
      
      marker = new google.maps.Marker({
        map: map,
        position: new google.maps.LatLng(<?php echo $latitude; ?>, <?php echo $longitude; ?>)
      });
      infowindow = new google.maps.InfoWindow({
        content: "Your Location: <?php echo $formatted_address; ?>"
      });

      google.maps.event.addListener(marker, "click", function () {
        infowindow.close(map, marker);
      });
      infowindow.open(map, marker);
    }

    //This function is called in init_map and traverses through the results of the Places Search
    function callback(results, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
          var place = results[i];

          marker = new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng())
          });
          infowindow = new google.maps.InfoWindow({
            content: place.name + ": " + place.formatted_address
          });
          infowindow.open(map, marker);
        }
      }
    }

    google.maps.event.addDomListener(window, 'load', init_map);

</script>

<?php

// if unable to geocode the address
}
else
{
  echo "No map found.";
}
}
?>

    </div>