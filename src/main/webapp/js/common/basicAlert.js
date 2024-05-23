function showAlert(message, url) {
	Swal.fire({
		html: message,
		confirmButtonText: '확인',
		customClass: {
			confirmButton: 'swal2-confirm',
			popup: 'custom-swal-popup',
			htmlContainer: 'custom-swal-text'
		}
	}).then((result) => {
		if (result.isConfirmed && url) {
			window.location.href = url;
		}
	});
}

document.addEventListener("DOMContentLoaded", function() {
	var messageElement = document.getElementById("message");
	var urlElement = document.getElementById("url");

	var message = messageElement ? messageElement.value : "";
	var url = urlElement ? urlElement.value : "";

	if (message) {
		showAlert(message, url);
	} else if (url) {
		window.location.href = url;
	}
});