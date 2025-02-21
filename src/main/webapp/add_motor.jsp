<%-- 
    Document   : add_motor
    Created on : Feb 21, 2025
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Add New Motorbike</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Add New Motorbike</h2>

            <form action="addMotor" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label">Motor Name</label>
                    <input type="text" class="form-control" name="motorName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Brand</label>
                    <select class="form-select" name="brandId" required>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.brandId}">${brand.brandName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Model</label>
                    <select class="form-select" name="modelId" required>
                        <c:forEach var="model" items="${models}">
                            <option value="${model.modelId}">${model.modelName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Fuel Type</label>
                    <select class="form-select" name="fuelId" required>
                        <c:forEach var="fuel" items="${fuels}">
                            <option value="${fuel.fuelId}">${fuel.fuelName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Color</label>
                    <input type="text" class="form-control" name="color" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number" step="0.01" class="form-control" name="price" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" rows="3" required></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Upload Picture</label>
                    <input type="file" class="form-control" name="picture" accept="image/*" required onchange="previewImage(event)">
                    <img id="imagePreview" class="mt-3" style="max-width: 100%; display: none;"/>
                </div>

                <button type="submit" class="btn btn-primary">Add Motorbike</button>
                <a href="motorManagement" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

        <script>
            function previewImage(event) {
                const imagePreview = document.getElementById('imagePreview');
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        imagePreview.src = e.target.result;
                        imagePreview.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                } else {
                    imagePreview.style.display = 'none';
                }
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
