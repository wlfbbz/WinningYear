document.addEventListener('DOMContentLoaded', function() {
    var feedbackForm = document.getElementById('feedbackForm');
    var submitButton = feedbackForm.querySelector('button');
    var messageDiv = document.getElementById('message');

    feedbackForm.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent default form submission
        submitButton.classList.add('loading');
        submitButton.disabled = true; // Disable the button to prevent multiple submissions
        submitButton.textContent = 'Submitting...'; // Change button text

        var formData = new FormData(feedbackForm);
        var request = new XMLHttpRequest();
        request.open('POST', feedbackForm.action, true);

        request.onload = function() {
            submitButton.classList.remove('loading');
            submitButton.disabled = false; // Re-enable the button

            if (request.status >= 200 && request.status < 400) {
                var resp = JSON.parse(request.responseText);
                if(resp.result === "success") {
                    feedbackForm.style.display = 'none'; // Hide the form
                    messageDiv.innerHTML = "Thank you for your feedback! :)";
                    messageDiv.style.display = 'block'; // Show the message
                } else {
                    messageDiv.innerHTML = "Submission failed. Please try again.";
                    messageDiv.style.display = 'block';
                }
            } else {
                messageDiv.innerHTML = "Error submitting form. Please try again.";
                messageDiv.style.display = 'block';
            }

            submitButton.textContent = 'Sign up to be first to know'; // Reset button text
        };

        request.onerror = function() {
            submitButton.classList.remove('loading');
            submitButton.disabled = false; // Re-enable the button
            submitButton.textContent = 'Sign up to be first to know'; // Reset button text

            messageDiv.innerHTML = "Error submitting form. Please check your connection and try again.";
            messageDiv.style.display = 'block';
        };

        request.send(formData);
    });
});
