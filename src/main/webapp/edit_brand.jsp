<%-- 
    Document   : edit_brand
    Created on : Mar 26, 2025, 11:59:49 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Brand</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="text-center mt-5">Edit Brand</h2>

            <!-- Form to edit the brand -->
            <form action="updateBrandServlet" method="POST">
                <input type="hidden" name="brandId" value="${brand.brandId}" />  <!-- Hidden field for brandId -->
                
                <div class="mb-3">
                    <label for="brandName" class="form-label">Brand Name</label>
                    <input type="text" class="form-control" id="brandName" name="brandName" value="${brand.brandName}" required />
                </div>

                <div class="mb-3">
                    <label for="countryOfOrigin" class="form-label">Country of Origin</label>
                    <input type="text" class="form-control" id="countryOfOrigin" name="countryOfOrigin" value="${brand.countryOfOrigin}" required />
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" required>${brand.description}</textarea>
                </div>

                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="brandslist" class="btn btn-secondary ml-3"><i class="fas fa-arrow-left"></i> Cancel</a>
            </form>
        </div>
    </body>
</html>

