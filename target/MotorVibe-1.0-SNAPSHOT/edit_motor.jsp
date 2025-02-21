<%-- 
    Document   : edit_motor
    Created on : Feb 21, 2025, 3:47:35 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Motor</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Edit Motorbike</h2>
            <div class="card p-4">
                <form action="editMotor" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="motorId" value="${motor.motorId}">
                    <input type="hidden" name="existingPicture" value="${motor.picture}">

                    <div class="mb-3">
                        <label class="form-label">Motor Name</label>
                        <input type="text" class="form-control" name="motorName" value="${motor.motorName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Brand</label>
                        <select class="form-control" name="brandId">
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.brandId}" ${brand.brandId == motor.brandId ? 'selected' : ''}>${brand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Model</label>
                        <select class="form-control" name="modelId">
                            <c:forEach var="model" items="${models}">
                                <option value="${model.modelId}" ${model.modelId == motor.modelId ? 'selected' : ''}>${model.modelName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fuel Type</label>
                        <select class="form-control" name="fuelId">
                            <c:forEach var="fuel" items="${fuels}">
                                <option value="${fuel.fuelId}" ${fuel.fuelId == motor.fuelId ? 'selected' : ''}>${fuel.fuelName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Color</label>
                        <input type="text" class="form-control" name="color" value="${motor.color}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Price</label>
                        <input type="number" class="form-control" name="price" step="0.01" value="${motor.price}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" required>${motor.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Upload New Picture</label>
                        <input type="file" class="form-control" name="picture" id="pictureInput">
                        <div class="mt-2">
                            <img id="previewImage" src="images/${motor.picture}" class="img-fluid rounded" alt="Current Image" style="max-width: 200px; ${motor.picture == null || motor.picture == '' ? 'display: none;' : ''}">
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success">Update Motor</button>
                        <a href="motorDetail?id=${motor.motorId}" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById("pictureInput").addEventListener("change", function (event) {
                const file = event.target.files[0];
                const preview = document.getElementById("previewImage");

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = "block";
                    };
                    reader.readAsDataURL(file);
                } else {
                    preview.style.display = "none";
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
