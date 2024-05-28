<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:forEach var="place" items="${places}">
    <div class="mb-3" onclick="selectPlace('${place.placeName}')">
        <div style="font-size: 18px; font-weight: bold;">${place.placeName}</div>
        <div style="color: dimgray">
            ${place.region1DepthName}, ${place.region2DepthName} · ${place.categoryName}
        </div>
    </div>
    <hr>
</c:forEach>

<script>
    function selectPlace(placeName) {
        document.getElementById('place').value = placeName;
        $('#searchAPlaceModal').modal('hide');
    }
</script>
