document.addEventListener("DOMContentLoaded", function() {
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const loginForm = document.getElementById("loginForm");

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    function validaEmail() {
        const erroreEmail = document.getElementById("erroreEmail");
        if (!emailRegex.test(emailInput.value)) {
            erroreEmail.innerText = "Formato email non valido (es. nome@dominio.it)";
            erroreEmail.style.color = "#FF4136";
            return false;
        } else {
            erroreEmail.innerText = "";
            return true;
        }
    }

    function validaPassword() {
        const errorePassword = document.getElementById("errorePassword");
        if (passwordInput.value.trim() === "" || passwordInput.value.length < 6) {
            errorePassword.innerText = "La password deve contenere almeno 6 caratteri";
            errorePassword.style.color = "#FF4136";
            return false;
        } else {
            errorePassword.innerText = "";
            return true;
        }
    }

    emailInput.addEventListener("change", validaEmail);
    passwordInput.addEventListener("change", validaPassword);

    loginForm.addEventListener("submit", function(event) {
        const isEmailValida = validaEmail();
        const isPasswordValida = validaPassword();

        if (!isEmailValida || !isPasswordValida) {
            event.preventDefault(); 
        }
    });
});