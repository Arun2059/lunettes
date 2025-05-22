<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty product ? 'Add' : 'Edit'} Product</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/logo.png" />
    <!-- External CSS files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Inline CSS as fallback -->
    <style>
    :root {
        --primary: #4361ee;
        --secondary: #3f37c9;
        --dark: #1b263b;
        --light: #f8f9fa;
        --success: #4cc9f0;
        --warning: #f8961e;
        --danger: #f72585;
        --gray: #adb5bd;
    }
    
    body {
        margin: 0;
        padding: 0;
        background-color: var(--light);
        color: var(--dark);
        line-height: 1.6;
        font-family: Arial, sans-serif;
    }

    .section-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    /* Main Banner Styles */
    .main-banner {
        background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                    url('../images/eyewear-banner.jpg') center/cover no-repeat;
        color: white;
        text-align: center;
        padding: 100px 20px;
        margin-bottom: 40px;
    }

    .main-title {
        font-size: 3rem;
        margin-bottom: 1rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        animation: fadeInDown 1s ease;
    }

    .subtitle {
        font-size: 1.5rem;
        margin-bottom: 0;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        animation: fadeInUp 1s ease;
    }

    /* Main content area styles */
    .main-content {
        margin-left: 250px; /* Adjust based on your sidebar width */
        padding: 20px;
        transition: margin-left 0.3s;
    }

    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .page-title h1 {
        margin: 0;
        color: var(--dark);
    }

    .user-profile {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .user-profile img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    /* Card styles for form container */
    .card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    .card-header {
        padding: 15px 20px;
        border-bottom: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-header h3 {
        margin: 0;
        color: var(--dark);
    }

    .card-body {
        padding: 20px;
    }

    /* Form styles */
    .product-form {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-row {
        display: flex;
        gap: 20px;
    }

    .form-row .form-group {
        flex: 1;
    }

    label {
        font-weight: 600;
        color: var(--dark);
    }

    input, select, textarea {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 1rem;
    }

    input:focus, select:focus, textarea:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
    }

    .current-image {
        margin-top: 10px;
    }

    .current-image p {
        margin: 5px 0;
        font-size: 0.9rem;
    }

    .form-actions {
        display: flex;
        gap: 10px;
        margin-top: 10px;
    }

    /* Button styles */
    .btn {
        padding: 10px 15px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    .btn-primary {
        background-color: var(--primary);
        color: white;
    }

    .btn-primary:hover {
        background-color: var(--secondary);
    }

    .btn-secondary {
        background-color: var(--gray);
        color: white;
    }

    .btn-secondary:hover {
        background-color: #95a5a6;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .main-content {
            margin-left: 0;
        }
        
        .form-row {
            flex-direction: column;
            gap: 20px;
        }
        
        .user-profile span {
            display: none;
        }
    }

    /* Animation keyframes */
    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="products" />
    </jsp:include>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">
                <h1>${empty product ? 'Add New' : 'Edit'} Product</h1>
            </div>
             
        </div>

        <div class="card">
            <div class="card-header">
                <h3>Product Details</h3>
                <a href="${pageContext.request.contextPath}/admin/products?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
            
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/products?action=${empty product ? 'add' : 'update'}" 
                      method="post" enctype="multipart/form-data" class="product-form">
                    <c:if test="${not empty product}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>
                    
                    <div class="form-group">
                        <label for="name">Product Name</label>
                        <input type="text" id="name" name="name" value="${product.name}" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="category" required>
                                <option value="">Select Category</option>
           

                                <option value="Prescription Glasses" ${product.category == 'Prescription Glasses' ? 'selected' : ''}>Prescription Glasses</option>
                                <option value="Googles" ${product.category == 'Goggles' ? 'selected' : ''}>Goggles</option>
                                <option value="Sunglasses" ${product.category == 'Sunglasses' ? 'selected' : ''}>Sunglasses</option>
                                <option value="Best Sellers" ${product.category == 'Best Sellers' ? 'selected' : ''}>Best Sellers</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="price">Price (Rs.)</label>
                            <input type="number" id="price" name="price" step="0.01" min="0" value="${product.price}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="quantity">Quantity in Stock</label>
                            <input type="number" id="quantity" name="quantity" min="0" value="${product.quantity}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="image">Product Image</label>
                            <input type="file" id="image" name="image" accept="image/*" ${empty product ? 'required' : ''}>
                            <c:if test="${not empty product.imagePath}">
                                <div class="current-image">
                                    <p>Current Image:</p>
                                    <img src="${pageContext.request.contextPath}/resources/images/products/${product.imagePath}" 
                                         alt="Current Product Image" width="100">
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4">${product.description}</textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${empty product ? 'Add' : 'Update'} Product
                        </button>
                        <button type="reset" class="btn btn-secondary">Reset</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Optional: Add JavaScript for enhanced functionality -->
    <script>
        // Validation or other functionality can be added here
        document.addEventListener('DOMContentLoaded', function() {
            // Check if external CSS loaded
            const checkStylesLoaded = () => {
                const links = document.querySelectorAll('link[rel="stylesheet"]');
                let allLoaded = true;
                
                links.forEach(link => {
                    // Skip CDN links as they're usually reliable
                    if (link.href.includes('cdnjs')) return;
                    
                    // Create a test element to check if styles are applied
                    const testElement = document.createElement('div');
                    testElement.className = 'css-test';
                    document.body.appendChild(testElement);
                    
                    // If computed style doesn't match expected, CSS likely not loaded
                    const style = window.getComputedStyle(testElement);
                    if (style.getPropertyValue('display') !== 'block') {
                        allLoaded = false;
                        console.warn('CSS file not loaded properly:', link.href);
                    }
                    
                    document.body.removeChild(testElement);
                });
                
                if (!allLoaded) {
                    console.warn('Some CSS files failed to load. Using inline styles as fallback.');
                }
            };
            
            // Run check after a delay to allow for CSS loading
            setTimeout(checkStylesLoaded, 1000);
        });
    </script>
</body>
</html>