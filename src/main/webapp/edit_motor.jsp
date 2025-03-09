<%-- 
    Document   : edit_motor
    Created on : Feb 21, 2025, 3:47:35 PM
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
        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            }
            
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
            }
            
            .form-control, .form-select {
                background-color: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                color: white;
            }
            
            .form-control:focus, .form-select:focus {
                background-color: var(--rich-black);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
                color: white;
            }
            
            .btn-success {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
            }
            
            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
            }
            
            .btn-secondary:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            
            .card {
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4 luxury-text">Edit Motorbike</h2>
            <div class="card p-4 luxury-card">
                <form action="editMotor" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="motorId" value="${motor.motorId}">
                    <input type="hidden" name="existingPicture" value="${motor.picture}">

                    <div class="mb-3">
                        <label class="form-label">Motor Name</label>
                        <input type="text" class="form-control" name="motorName" value="${motor.motorName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Brand</label>
                        <select class="form-control form-select" name="brandId">
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.brandId}" ${brand.brandId == motor.brandId ? 'selected' : ''}>${brand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Model</label>
                        <select class="form-control form-select" name="modelId">
                            <c:forEach var="model" items="${models}">
                                <option value="${model.modelId}" ${model.modelId == motor.modelId ? 'selected' : ''}>${model.modelName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fuel Type</label>
                        <select class="form-control form-select" name="fuelId">
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

                    <div class="form-group mb-4">
                        <label class="form-label">Current Image:</label>
                        <img src="${pageContext.request.contextPath}/images/${motor.picture}" alt="${motor.motorName}" style="max-width: 200px; border: 2px solid var(--primary-gold); border-radius: 5px;" class="d-block mb-2">
                        <input type="hidden" name="existingPicture" value="${motor.picture}">
                        <label for="picture" class="form-label">New Image (optional):</label>
                        <input type="file" class="form-control" id="picture" name="picture" accept="image/*">
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success ">Update Motor</button>
                        <a href="motorDetail?id=${motor.motorId}" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById("picture").addEventListener("change", function (event) {
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
