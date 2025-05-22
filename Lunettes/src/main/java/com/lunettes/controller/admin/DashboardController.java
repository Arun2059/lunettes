package com.lunettes.controller.admin;

import com.lunettes.model.DashboardData;
import com.lunettes.service.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DashboardData data = dashboardService.getDashboardOverview();
            request.setAttribute("dashboardData", data);
    		request.getRequestDispatcher("/WEB-INF/pages/admin/admindashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Internal Server Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            log("Error loading dashboard overview", e);
        }
    }
}
