<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Your Item</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    <style>
        :root {
            --glass-white: rgba(255, 255, 255, 0.95);
            --glass-border: rgba(0, 0, 0, 0.1);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --primary-color: #0066cc;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --text-dark: #333;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            color: var(--text-dark);
        }

        .container {
            max-width: 1100px;
            margin: auto;
            padding: 2rem;
        }

        .glass-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            box-shadow: var(--glass-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        h1, h2, h3 {
            color: var(--primary-color);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .btn {
            display: inline-block;
            padding: 0.7rem 1.4rem;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-align: center;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #004a99;
        }

        .btn-success {
            background: var(--success-color);
            color: white;
        }

        .btn-success:hover {
            background: #218838;
        }

        .btn-danger {
            background: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
        }

        .center {
            text-align: center;
        }

        .return-items {
            margin-top: 2rem;
        }

        .return-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 1rem;
            background: white;
        }

        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 1rem;
        }

        .item-details {
            flex-grow: 1;
        }

        .item-actions {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .reason-select {
            margin-top: 0.5rem;
        }

        /* Popup Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            max-width: 500px;
            width: 90%;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .modal-icon {
            font-size: 3rem;
            color: var(--success-color);
            margin-bottom: 1rem;
        }

        .modal-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--success-color);
        }

        .modal-message {
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .modal-close {
            background: var(--success-color);
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }

        .modal-close:hover {
            background: #218838;
        }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" />
	
    <div class="container">
        <div class="glass-card">
            <h1>Return Items</h1>
            <p>Start your return process by adding the items you'd like to return below.</p>
            
            <div class="form-group">
                <label for="order-number">Order Number</label>
                <input type="text" id="order-number" placeholder="Enter your order number" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" placeholder="Enter the email used for this order" required>
            </div>
            
            <h3>Add Items to Return</h3>
            
            <div class="form-group">
                <label for="product-search">Search for Product</label>
                <input type="text" id="product-search" placeholder="Search by product name or SKU">
                <div id="search-results" style="display: none;"></div>
            </div>
            
            <div id="return-items" class="return-items">
                <p id="no-items-message">No items added yet. Search for products above to add items to return.</p>
            </div>
            
            <div class="form-group">
                <label for="return-reason">Overall Return Reason</label>
                <select id="return-reason" required>
                    <option value="">Select a reason</option>
                    <option value="wrong-item">Received wrong item</option>
                    <option value="damaged">Item arrived damaged</option>
                    <option value="not-as-described">Item not as described</option>
                    <option value="no-longer-needed">No longer needed</option>
                    <option value="better-price-found">Found better price elsewhere</option>
                    <option value="other">Other reason</option>
                </select>
            </div>
            
            <div class="form-group" id="additional-notes-group">
                <label for="additional-notes">Additional Notes</label>
                <textarea id="additional-notes" placeholder="Please provide any additional information about your return"></textarea>
            </div>
            
            <div class="form-group">
                <label for="return-method">Return Method</label>
                <select id="return-method" required>
                    <option value="">Select return method</option>
                    <option value="mail">Mail return (free)</option>
                    <option value="drop-off">In-store drop-off</option>
                    <option value="pickup">Schedule a pickup ($5 fee)</option>
                </select>
            </div>
            
            <div class="center">
                <button id="submit-return" class="btn btn-success" style="padding: 1rem 2rem; font-size: 1.1rem;">Submit Return Request</button>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <div class="modal-icon">✓</div>
            <h2 class="modal-title">Return Request Successful!</h2>
            <p class="modal-message">
                Your return request has been submitted successfully.<br>
                Return ID: <strong id="returnIdDisplay">RMA-2023-12345</strong><br>
                We've sent the return instructions to your email.
            </p>
            <button class="modal-close" id="modalClose">Close</button>
        </div>
    </div>

    <script>
        // Sample product data
        const sampleProducts = [
            { id: 1, name: "Classic White T-Shirt", sku: "TS-WHITE-M", price: 24.99, image: "https://via.placeholder.com/80?text=T-Shirt" },
            { id: 2, name: "Blue Jeans", sku: "JEANS-BLUE-32", price: 59.99, image: "https://via.placeholder.com/80?text=Jeans" },
            { id: 3, name: "Running Shoes", sku: "SHOES-RUN-BLK", price: 89.99, image: "https://via.placeholder.com/80?text=Shoes" },
            { id: 4, name: "Winter Jacket", sku: "JACKET-WNTR-L", price: 129.99, image: "https://via.placeholder.com/80?text=Jacket" }
        ];

        // DOM elements
        const productSearch = document.getElementById('product-search');
        const searchResults = document.getElementById('search-results');
        const returnItems = document.getElementById('return-items');
        const noItemsMessage = document.getElementById('no-items-message');
        const submitBtn = document.getElementById('submit-return');
        const successModal = document.getElementById('successModal');
        const modalClose = document.getElementById('modalClose');
        const returnIdDisplay = document.getElementById('returnIdDisplay');
        
        // Track added products
        let addedProducts = [];
        
        // Search functionality
        productSearch.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            
            if (searchTerm.length < 2) {
                searchResults.style.display = 'none';
                return;
            }
            
            const filteredProducts = sampleProducts.filter(product => 
                (product.name.toLowerCase().includes(searchTerm) || 
                 product.sku.toLowerCase().includes(searchTerm)) &&
                !addedProducts.includes(product.id));
            
            if (filteredProducts.length > 0) {
                searchResults.innerHTML = filteredProducts.map(product => `
                    <div class="return-item" data-id="${product.id}" style="margin-top: 0.5rem;">
                        <img src="${product.image}" alt="${product.name}" class="item-image">
                        <div class="item-details">
                            <h4 style="margin: 0;">${product.name}</h4>
                            <p style="margin: 0.25rem 0;">SKU: ${product.sku} | $${product.price.toFixed(2)}</p>
                        </div>
                        <button class="btn btn-primary add-item">Add to Return</button>
                    </div>
                `).join('');
                searchResults.style.display = 'block';
                
                // Add event listeners to the add buttons
                document.querySelectorAll('.add-item').forEach(button => {
                    button.addEventListener('click', function() {
                        const productId = parseInt(this.closest('.return-item').getAttribute('data-id'));
                        addProductToReturn(productId);
                    });
                });
            } else {
                searchResults.innerHTML = '<p style="padding: 1rem; background: white; border-radius: 5px;">No products found</p>';
                searchResults.style.display = 'block';
            }
        });
        
        // Add product to return list
        function addProductToReturn(productId) {
            const product = sampleProducts.find(p => p.id === productId);
            
            if (product && !addedProducts.includes(productId)) {
                addedProducts.push(productId);
                
                const itemElement = document.createElement('div');
                itemElement.className = 'return-item';
                itemElement.setAttribute('data-id', productId);
                itemElement.innerHTML = `
                    <img src="${product.image}" alt="${product.name}" class="item-image">
                    <div class="item-details">
                        <h4 style="margin: 0;">${product.name}</h4>
                        <p style="margin: 0.25rem 0;">SKU: ${product.sku} | $${product.price.toFixed(2)}</p>
                        <div class="reason-select">
                            <select class="item-reason" required style="width: 100%; padding: 0.5rem;">
                                <option value="">Select reason</option>
                                <option value="wrong-item">Wrong item</option>
                                <option value="damaged">Damaged</option>
                                <option value="defective">Defective</option>
                                <option value="no-longer-needed">No longer needed</option>
                            </select>
                        </div>
                    </div>
                    <div class="item-actions">
                        <button class="btn btn-danger remove-item">Remove</button>
                    </div>
                `;
                
                returnItems.insertBefore(itemElement, noItemsMessage);
                noItemsMessage.style.display = 'none';
                
                // Add event listener to remove button
                itemElement.querySelector('.remove-item').addEventListener('click', function() {
                    removeProductFromReturn(productId);
                });
                
                // Clear search
                productSearch.value = '';
                searchResults.style.display = 'none';
            }
        }
        
        // Remove product from return list
        function removeProductFromReturn(productId) {
            addedProducts = addedProducts.filter(id => id !== productId);
            const itemElement = document.querySelector(`.return-item[data-id="${productId}"]`);
            if (itemElement) {
                itemElement.remove();
            }
            
            if (addedProducts.length === 0) {
                noItemsMessage.style.display = 'block';
            }
        }
        
        // Form submission
        submitBtn.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Validate form
            const orderNumber = document.getElementById('order-number').value;
            const email = document.getElementById('email').value;
            const returnReason = document.getElementById('return-reason').value;
            const returnMethod = document.getElementById('return-method').value;
            
            if (!orderNumber || !email || !returnReason || !returnMethod || addedProducts.length === 0) {
                alert('Please fill in all required fields and add at least one item to return');
                return;
            }
            
            // Check all items have a reason selected
            const itemReasons = document.querySelectorAll('.item-reason');
            let allReasonsSelected = true;
            
            itemReasons.forEach(select => {
                if (!select.value) {
                    allReasonsSelected = false;
                    select.style.border = '1px solid red';
                } else {
                    select.style.border = '';
                }
            });
            
            if (!allReasonsSelected) {
                alert('Please select a reason for each item you are returning');
                return;
            }
            
            // Generate random return ID
            const returnId = 'RMA-' + new Date().getFullYear() + '-' + Math.floor(10000 + Math.random() * 90000);
            returnIdDisplay.textContent = returnId;
            
            // Show success modal
            successModal.style.display = 'flex';
            
            // In a real app, you would send this data to your server
            console.log('Submitting return request:', {
                orderNumber,
                email,
                returnReason,
                returnMethod,
                returnId,
                items: addedProducts.map(id => {
                    const product = sampleProducts.find(p => p.id === id);
                    return {
                        id,
                        name: product.name,
                        sku: product.sku,
                        reason: document.querySelector(`.return-item[data-id="${id}"] .item-reason`).value
                    };
                }),
                notes: document.getElementById('additional-notes').value
            });
        });
        
        // Close modal
        modalClose.addEventListener('click', function() {
            successModal.style.display = 'none';
        });
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === successModal) {
                successModal.style.display = 'none';
            }
        });
    </script>
    
    <!-- Include Footer -->
        <jsp:include page="footer.jsp" />
</body>
</html>