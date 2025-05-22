<%@ page import="com.lunettes.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account</title>
    <link rel="shortcut icon" type="x-icon" href="<%= request.getContextPath() %>/images/logo.png" />
    <link rel="stylesheet" href="/Lunettes/css/header.css" />
    <link rel="stylesheet" href="/Lunettes/css/footer.css" />
    <link rel="stylesheet" href="/Lunettes/css/my-account.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    
</head>

<body>
        <jsp:include page="header.jsp" />

  <div class="container">
    <div class="profile-sidebar">
        <%
        User user = (User) session.getAttribute("user");
        if (user != null) {
            String avatarPath = user.getAvatarPath() != null && !user.getAvatarPath().isEmpty() ? 
              "/" + user.getAvatarPath() : 
                request.getContextPath() + "/images/profile-avatar.jpg";
        %>
            <img src="/Lunettes/resources/images/profile<%= avatarPath %>" alt="Profile" class="profile-pic">
            <h2 class="profile-name"><%= user.getFirstName() + " " + user.getLastName() %></h2>
            <p class="profile-email"><%= user.getEmail() %></p>
        <%
        }
        %>
        
        <a href="#" class="menu-item active" onclick="showSection('edit-profile')">
            <i class="fas fa-user-edit"></i> Edit Profile
        </a>

        
        <button class="btn btn-logout" onclick="logout()">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
    </div>
    
    <div class="main-content">
        <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <%
        }
        
        String successMessage = (String) request.getAttribute("successMessage");
        if (successMessage != null) {
        %>
            <div class="success-message"><%= successMessage %></div>
        <%
        }
        %>
        
        <!-- Edit Profile Section (default visible) -->
        <div id="edit-profile">
            <h2 class="section-title">Edit Profile</h2>
          <%request.getAttribute("errorMessage") ;%>  
            
            <form action="<%= request.getContextPath() %>/myaccount" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updateProfile">
                
                <div class="avatar-upload">
                    <div>
                        <%
                        if (user != null) {
                            String avatarPath = user.getAvatarPath() != null && !user.getAvatarPath().isEmpty() ? 
                            		"/Lunettes/resources/images/profile" +"/" + user.getAvatarPath() : 
                                request.getContextPath() + "/images/profile-avatar.jpg";
                        %>
                            <img src="<%= avatarPath %>" alt="Profile" class="profile-pic" id="avatar-preview">
                        <%
                        }
                        %>
                    </div>
                    <div class="avatar-upload-btn">
                        <label for="avatar" class="btn">Change Avatar</label>
                        <input type="file" id="avatar" name="avatar" accept="image/*" style="display: none;" onchange="previewAvatar(this)">
                        <input type="hidden" name="action" value="updateAvatar">
                    </div>
                </div>
                
                <%
                if (user != null) {
                %>
                <div class="form-group">
                    <label class="form-label">First Name</label>
                    <input type="text" class="form-control" name="firstName" value="<%= user.getFirstName() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Middle Name</label>
                    <input type="text" class="form-control" name="middleName" value="<%= user.getMiddleName() != null ? user.getMiddleName() : "" %>">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Last Name</label>
                    <input type="text" class="form-control" name="lastName" value="<%= user.getLastName() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" value="<%= user.getUsername() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" value="<%= user.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" class="form-control" name="dob" value="<%= user.getDob() != null ? user.getDob() : "" %>">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Gender</label>
                    <select class="form-control" name="gender">
                        <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <div style="display: flex; gap: 10px;">
                        <select class="form-control" name="countryCode" style="flex: 0 0 100px;">
                            <option value="+1" <%= "+1".equals(user.getCountryCode()) ? "selected" : "" %>>+1 (US)</option>
                            <option value="+44" <%= "+44".equals(user.getCountryCode()) ? "selected" : "" %>>+44 (UK)</option>
                            <option value="+91" <%= "+91".equals(user.getCountryCode()) ? "selected" : "" %>>+91 (IN)</option>
                        </select>
                        <input type="tel" class="form-control" name="contactNumber" value="<%= user.getContactNumber() != null ? user.getContactNumber() : "" %>" style="flex: 1;">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Address</label>
                    <textarea class="form-control" name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                </div>
                <%
                }
                %>
                <button type="submit" class="btn">Save Changes</button>
            </form>
        </div>
        
      

<script>
    // Function to show the selected section
    function showSection(sectionId) {
        // Hide all sections
        document.querySelectorAll('.main-content > div').forEach(section => {
            section.style.display = 'none';
        });
        
        // Show the selected section
        document.getElementById(sectionId).style.display = 'block';
        
        // Update active menu item
        document.querySelectorAll('.menu-item').forEach(item => {
            item.classList.remove('active');
        });
        
        // Find and activate the corresponding menu item
        let menuItem;
        if (sectionId === 'edit-profile') {
            menuItem = document.querySelector('.menu-item:nth-child(1)');
        } else if (sectionId === 'order-history') {
            menuItem = document.querySelector('.menu-item:nth-child(2)');
        } else if (sectionId === 'payment-history') {
            menuItem = document.querySelector('.menu-item:nth-child(3)');
        }
        
        if (menuItem) {
            menuItem.classList.add('active');
        }
    }
    
    // Function to preview avatar before upload
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                document.getElementById('avatar-preview').src = e.target.result;
                
                // Create a FormData object and submit the avatar
                const formData = new FormData();
                formData.append('avatar', input.files[0]);
                formData.append('action', 'updateAvatar');
                
                fetch('<%= request.getContextPath() %>/myaccount', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        window.location.reload(); // Reload to show updated avatar
                    } else {
                        alert('Failed to update avatar');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while updating avatar');
                });
            };
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = '<%= request.getContextPath() %>/logout';
        }
    }
    
    // Initialize the page with the edit profile section visible
    document.addEventListener('DOMContentLoaded', function() {
        showSection('edit-profile');
    });
</script>
</body>
</html>