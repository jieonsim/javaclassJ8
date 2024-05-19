<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/addAPlace.css" />
<div class="modal fade" id="addAPlace">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<div>
					<b>공간 추가</b>
				</div>
				<form name="searchPlace" method="post" action="">
					<div>
						<input class="search-input" type="search" placeholder="공간명 검색" aria-label="Search" id="place-search">
						<button class="search-btn" type="button" onclick="searchPlaces()">
							<i class="ph ph-magnifying-glass"></i>
						</button>
					</div>
				</form>
				<div id="places-list"></div>
			</div>
		</div>
	</div>
</div>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyATyCQj9DTcyGQ3T8sg-QEndzxEz0Df4z8&libraries=places" async defer></script>
<script>
    function initMap() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((position) => {
                const pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                // Call the function to load nearby places
                loadNearbyPlaces(pos);
            });
        } else {
            // Browser doesn't support Geolocation
            console.log("Geolocation is not supported by this browser.");
        }
    }

    function loadNearbyPlaces(pos) {
        const service = new google.maps.places.PlacesService(document.createElement('div'));
        const request = {
            location: pos,
            radius: '500',
            type: ['restaurant', 'cafe', 'museum']
        };

        service.nearbySearch(request, (results, status) => {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                const placesList = document.getElementById('places-list');
                placesList.innerHTML = '';
                results.forEach((place) => {
                    const listItem = document.createElement('div');
                    listItem.classList.add('place-item');
                    listItem.innerHTML = `
                        <strong>${place.name}</strong><br>
                        ${place.vicinity}<br>
                        <button onclick="selectPlace('${place.name}', '${place.geometry.location.lat()}', '${place.geometry.location.lng()}')">Select</button>
                    `;
                    placesList.appendChild(listItem);
                });
            }
        });
    }

    function searchPlaces() {
        const input = document.getElementById('place-search').value;
        const service = new google.maps.places.PlacesService(document.createElement('div'));
        const request = {
            query: input,
            fields: ['name', 'geometry', 'vicinity'],
        };

        service.findPlaceFromQuery(request, (results, status) => {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                const placesList = document.getElementById('places-list');
                placesList.innerHTML = '';
                results.forEach((place) => {
                    const listItem = document.createElement('div');
                    listItem.classList.add('place-item');
                    listItem.innerHTML = `
                        <strong>${place.name}</strong><br>
                        ${place.vicinity}<br>
                        <button onclick="selectPlace('${place.name}', '${place.geometry.location.lat()}', '${place.geometry.location.lng()}')">Select</button>
                    `;
                    placesList.appendChild(listItem);
                });
            }
        });
    }

    function selectPlace(name, lat, lng) {
        alert(`Selected Place: ${name}\nLatitude: ${lat}\nLongitude: ${lng}`);
        document.getElementById('selected-place-name').value = name;
        document.getElementById('selected-place-lat').value = lat;
        document.getElementById('selected-place-lng').value = lng;
    }

    window.onload = initMap;
</script>
