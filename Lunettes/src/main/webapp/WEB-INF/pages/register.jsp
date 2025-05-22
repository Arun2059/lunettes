<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4bb543;
            --error-color: #ff3333;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--dark-color);
            line-height: 1.6;
        }

        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        .form-image {
            flex: 1;
            background: url('images/register.png') center/cover no-repeat;
            display: none;
            position: relative;
        }

        .form-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(67, 97, 238, 0.2);
        }

        .form-container {
            flex: 1;
            padding: 40px;
            position: relative;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            color: var(--primary-color);
            font-size: 2.2rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .form-header p {
            color: #666;
            font-size: 1.1rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .col {
            flex: 1;
            min-width: 200px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 0.95rem;
        }

        input,
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
        }

        input:focus,
        select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        .password-container {
            position: relative;
        }

        .password-container input {
            padding-right: 40px;
        }

        button[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        button[type="submit"]:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4);
        }

        button[type="submit"]:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(67, 97, 238, 0.3);
        }

        .login-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .login-link:hover {
            text-decoration: underline;
            color: var(--secondary-color);
        }

        .avatar-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        .avatar-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            overflow: hidden;
            border: 3px solid var(--accent-color);
            box-shadow: 0 5px 15px rgba(76, 201, 240, 0.3);
            transition: all 0.3s;
        }

        .avatar-preview:hover {
            transform: scale(1.05);
        }

        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-upload label {
            background-color: var(--accent-color);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
            box-shadow: 0 2px 5px rgba(76, 201, 240, 0.3);
        }

        .avatar-upload label:hover {
            background-color: #3aa8d1;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(76, 201, 240, 0.4);
        }

        .avatar-upload label:active {
            transform: translateY(0);
        }

        .avatar-upload input[type="file"] {
            display: none;
        }

        /* Styles for messages */
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-message {
            background-color: rgba(75, 181, 67, 0.1);
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }

        .error-message {
            background-color: rgba(255, 51, 51, 0.1);
            color: var(--error-color);
            border: 1px solid var(--error-color);
        }

        /* Additional styling for input focus and hover states */
        input:hover,
        select:hover {
            border-color: #bbbbbb;
        }

        /* Custom styling for date input */
        input[type="date"] {
            padding-right: 10px;
        }

        /* Add progress step indicator */
        .progress-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }

        .progress-steps::before {
            content: "";
            position: absolute;
            top: 12px;
            left: 10%;
            width: 80%;
            height: 2px;
            background-color: #ddd;
            z-index: 1;
        }

        .step {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .step-number {
            width: 25px;
            height: 25px;
            border-radius: 50%;
            background-color: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-size: 14px;
            font-weight: 600;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 5px;
        }

        .active-step .step-number {
            background-color: var(--primary-color);
            color: white;
        }

        .step-text {
            font-size: 0.8rem;
            color: #777;
            font-weight: 500;
        }

        .active-step .step-text {
            color: var(--primary-color);
            font-weight: 600;
        }

        @media (min-width: 992px) {
            .form-image {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                margin: 20px;
            }

            .form-container {
                padding: 30px;
            }

            .col {
                min-width: 100%;
            }
            
            .progress-steps {
                overflow-x: auto;
                padding-bottom: 10px;
            }
            
            .step {
                margin: 0 10px;
            }
        }
         .form-image {
            flex: 1;
            display: none;
            position: relative;
            overflow: hidden;
        }

        .form-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        .form-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(67, 97, 238, 0.2);
            z-index: 1;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="form-image">
        	<img src="resources/images/register.jpeg"/>
            <!-- This div will display the background image -->
        </div>
        <div class="form-container">
            <div class="form-header">
                <h1>Create Your Account</h1>
                <p>Join our community and start your journey with us</p>
            </div>

            <div class="progress-steps">
                <div class="step active-step">
                    <div class="step-number">1</div>
                    <div class="step-text">Account</div>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <div class="step-text">Verify</div>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <div class="step-text">Complete</div>
                </div>
            </div>

            <!-- Display success message if any -->
            <% if (request.getAttribute("message") != null) { %>
            <div class="message success-message">
                <%= request.getAttribute("message") %>
            </div>
            <% } %>

            <!-- Display error message if any -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="message error-message">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <div class="avatar-upload">
                    <div class="avatar-preview" id="avatarPreview">
                        <i class="fas fa-user" style="font-size: 40px; color: #777;"></i>
                    </div>
                    <label for="avatar">Choose Profile Picture</label>
                    <input type="file" id="avatar" name="avatar" accept="image/*">
                </div>
                
                <div class="row">
                    <div class="col">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" 
                               value="${firstName != null ? firstName : ''}" required>
                    </div>
                    <div class="col">
                        <label for="middleName">Middle Name</label>
                        <input type="text" id="middleName" name="middleName" 
                               value="${middleName != null ? middleName : ''}">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" 
                               value="${lastName != null ? lastName : ''}" required>
                    </div>
                    <div class="col">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" 
                               value="${username != null ? username : ''}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label for="birthday">Date of Birth</label>
                        <input type="date" id="birthday" name="dob" 
                               value="${dob != null ? dob : ''}" required>
                    </div>
                    <div class="col">
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="" ${gender == null ? 'selected' : ''}>Select Gender</option>
                            <option value="male" ${gender == 'male' ? 'selected' : ''}>Male</option>
                            <option value="female" ${gender == 'female' ? 'selected' : ''}>Female</option>
                            <option value="other" ${gender == 'other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" 
                               value="${email != null ? email : ''}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col" style="flex: 0.3;">
                        <label for="country_code">Country Code</label>
                        <select id="country_code" name="country_code" class="country-code-select">
                            <option value="+1" ${country_code == '+1' ? 'selected' : ''}>+1 (US)</option>
                            <option value="+44" ${country_code == '+44' ? 'selected' : ''}>+44 (UK)</option>
                            <option value="+91" ${country_code == '+91' ? 'selected' : ''}>+91 (IN)</option>
                            <option value="+86" ${country_code == '+86' ? 'selected' : ''}>+86 (CN)</option>
                            <option value="+49" ${country_code == '+49' ? 'selected' : ''}>+49 (DE)</option>
                            <option value="+33" ${country_code == '+33' ? 'selected' : ''}>+33 (FR)</option>
                            <option value="+81" ${country_code == '+81' ? 'selected' : ''}>+81 (JP)</option>
                            <option value="+61" ${country_code == '+61' ? 'selected' : ''}>+61 (AU)</option>
                            <option value="+977" ${country_code == '+977' ? 'selected' : ''}>+977 (AU)</option>
                        </select>
                    </div>
                    <div class="col" style="flex: 0.7;">
                        <label for="contactNumber">Phone Number</label>
                        <input type="tel" id="contactNumber" name="contactNumber" 
                               value="${contactNumber != null ? contactNumber : ''}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" 
                               value="${address != null ? address : ''}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col password-container">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="col password-container">
                        <label for="retypePassword">Confirm Password</label>
                        <input type="password" id="retypePassword" name="retypePassword" required>
                    </div>
                </div>

                <button type="submit">Create Account</button>
            </form>

            <a href="${pageContext.request.contextPath}/login" class="login-link">
                Already have an account? Sign in
            </a>
        </div>
    </div>

    <script>
        // Avatar preview
        const avatarInput = document.querySelector('#avatar');
        const avatarPreview = document.querySelector('#avatarPreview');

        avatarInput.addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();

                reader.addEventListener('load', function () {
                    avatarPreview.innerHTML = '';
                    const img = document.createElement('img');
                    img.src = this.result;
                    avatarPreview.appendChild(img);
                });

                reader.readAsDataURL(file);
            }
        });

        // Password matching validation
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('retypePassword');
        const form = document.querySelector('form');

        form.addEventListener('submit', function(e) {
            if (passwordInput.value !== confirmPasswordInput.value) {
                e.preventDefault();
                // Create error message
                const errorDiv = document.createElement('div');
                errorDiv.className = 'message error-message';
                errorDiv.textContent = 'Passwords do not match!';
                
                // Add to page
                const existingError = document.querySelector('.error-message');
                if (existingError) {
                    existingError.remove();
                }
                form.insertBefore(errorDiv, form.firstChild);
                
                // Highlight fields
                passwordInput.style.borderColor = 'var(--error-color)';
                confirmPasswordInput.style.borderColor = 'var(--error-color)';
            }
        });

        // Reset error highlight when typing
        passwordInput.addEventListener('input', function() {
            passwordInput.style.borderColor = '';
            confirmPasswordInput.style.borderColor = '';
        });
        
        confirmPasswordInput.addEventListener('input', function() {
            passwordInput.style.borderColor = '';
            confirmPasswordInput.style.borderColor = '';
        });
    </script>
</body>

</html>