let googleMap;

function initMap() {
    googleMap = new google.maps.Map(document.getElementById('googleMap'), {
        center: { lat: 37.7749, lng: -122.4194 },
        zoom: 12
    });
}

window.onload = initMap;
