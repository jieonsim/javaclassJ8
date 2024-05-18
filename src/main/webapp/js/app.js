let googleMap;

function initMap() {
    googleMap = new google.maps.Map(document.getElementById('googleMap'), {
        center: { lat: 37.7749, lng: -122.4194 },
        zoom: 12
    });
    
    // Fetch saved places for the user from the backend
/*    fetch('/api/saved-places')
        .then(response => response.json())
        .then(data => {
            data.places.forEach(place => {
                new google.maps.Marker({
                    position: { lat: place.latitude, lng: place.longitude },
                    map: googleMap,
                    title: place.name
                });
            });
        })
        .catch(error => console.error('Error fetching saved places:', error));*/
}

// Load the map when the window loads
window.onload = initMap;
