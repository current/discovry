initialize = (position) ->
  elem = $("div.map")[0]

  mapOptions =
    mapTypeControl: false
    streetViewControl: false
    panControl: false
    center: new google.maps.LatLng(-23.554113,-46.641769)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoom: 7

  map = new google.maps.Map(elem, mapOptions)

  updateMap = ->
    center = map.getCenter()
    zoom = map.getZoom()

    [lat, lng] = [center.lat(), center.lng()]

    jQuery.ajax
      url: '/'
      success: update
      data:
        format: 'json'
        zoom: zoom
        lat: lat
        lng: lng

  setTimeout updateMap, 500

  clean = ->
    $('.summary').html('')
    $('.title').html('')

  google.maps.event.addListener map, 'dragstart', clean
  google.maps.event.addListener map, 'dragend', updateMap
  google.maps.event.addListener map, 'zoom_changed', updateMap

  update = (data) ->
    console.log(data)
    if data.summary isnt null
      $('.summary').text(data.summary)
      link = $('<a>').attr('href', data.wikipediaUrl).text(data.title)
      $('.title').append(link)

$(initialize)
