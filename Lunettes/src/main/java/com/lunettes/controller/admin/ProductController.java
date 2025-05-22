package com.lunettes.controller.admin;

import com.lunettes.model.Product;

import com.lunettes.service.ProductService;
import com.lunettes.utils.ImageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
@MultipartConfig
@WebServlet(name = "ProductController", urlPatterns = { "/admin/products" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private ImageUtil imageUtil;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        imageUtil = new ImageUtil();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
			try {
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            return;
        }
        
        switch (action) {
            case "add":
			try {
				addProduct(request, response);
			} catch (ClassNotFoundException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            case "update":
			try {
				updateProduct(request, response);
			} catch (ClassNotFoundException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
    			try {
    	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
    			} catch (IOException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
                return;
            }

        switch (action) {
            case "list":
                try {
                    listProducts(request, response);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            case "add":
                showAddProductForm(request, response);
                break;
            case "delete":
                try {
                    deleteProduct(request, response);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            case "get":
                try {
                    getProduct(request, response);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void showAddProductForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/admin/product-form.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        // Get form parameters
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        System.out.println(request.getParameter("category"));

        System.out.println(request.getParameter("quantity"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        System.out.print(name+ category+quantity+price+description);
        
        // Handle image upload
        Part imagePart = request.getPart("image");
        String imageName = imageUtil.getImageNameFromPart(imagePart);
        String imagePath = "products/" + imageName;
        
        // Create product object
        Product product = new Product();
        product.setName(name);
        product.setCategory(category);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setImagePath(imagePath);
        product.setDescription(description);
        
        // Save product and image
        if (productService.addProduct(product) && imageUtil.uploadImage(imagePart, request.getServletContext().getRealPath(""), "products")) {
            response.sendRedirect("products?action=list&success=Product added successfully");
            
        } else {
            response.sendRedirect("/Lunettes/admin/products?action=add&message=Something went wrong");
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        
        // Get existing product to preserve image path if new image isn't uploaded
        Product existingProduct = productService.getProductById(id);
        String imagePath = existingProduct.getImagePath();
        
        // Handle image upload if new image is provided
        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            String imageName = imageUtil.getImageNameFromPart(imagePart);
            imagePath = "products/" + imageName;
            imageUtil.uploadImage(imagePart, request.getServletContext().getRealPath(""), "products");
        }
        
        // Update product
        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setCategory(category);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setImagePath(imagePath);
        product.setDescription(description);
        
        if (productService.updateProduct(product)) {
            response.sendRedirect("products?action=list&success=Product updated successfully");
        } else {
            response.sendRedirect("products?action=get?id=" + id + "&status=error");
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
    	request.setAttribute("products", productService.getAllProducts());
    	request.getRequestDispatcher("/WEB-INF/pages/admin/product.jsp").forward(request, response);

    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (productService.deleteProduct(id)) {
            response.sendRedirect("products?action=list&success=Product deleted successfully");

        } else {
            response.sendRedirect("products?action=list&error=getting error while delete");
        }
    }
    
    private void getProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(id);
        
        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/pages/admin/edit-product.jsp").forward(request, response);

            request.getRequestDispatcher("edit-product.jsp").forward(request, response);
        } else {
            response.sendRedirect("products.jsp?status=not_found");
        }
    }
}