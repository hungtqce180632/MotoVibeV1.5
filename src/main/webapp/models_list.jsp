<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Model List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background: #1a1a1a;
                color: #f8f9fa;
                padding-top: 80px;
            }

            .container {
                max-width: 900px;
                margin: auto;
            }

            .list-container {
                padding-top: 100px;
                padding-bottom: 50px;
            }

            h2 {
                color: #D4AF37;
                text-transform: uppercase;
                text-align: center;
                margin-bottom: 20px;
            }

            .table {
                background: #222;
                border-radius: 10px;
                overflow: hidden;
            }

            .table th {
                background: #D4AF37;
                color: black;
                text-align: center;
            }

            .table td {
                text-align: center;
                vertical-align: middle;
                color: #f8f9fa;
            }

            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.2);
            }

            .btn-add {
                display: block;
                width: fit-content;
                margin: 20px 0px;
                background: linear-gradient(145deg, #D4AF37, #C5A028);
                color: black;
                font-weight: bold;
                font-size: 16px;
                text-transform: uppercase;
                border: none;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(212, 175, 55, 0.3);
            }

            .btn-add i {
                margin-right: 8px;
            }

            .btn-add:hover {
                background: linear-gradient(145deg, #C5A028, #D4AF37);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(212, 175, 55, 0.5);
            }

            .d-flex {
                gap: 25px;
            }

            .form-control {
                background: linear-gradient(145deg, #C5A028, #D4AF37);
                width: 100%;
                max-width: 950px;
                padding: 10px;
                font-size: 1rem;
                color: #ffffff;
                border: 1px solid #D4AF37;
            }

            .form-control::placeholder {
                color: #f8f9fa;
                opacity: 1;
            }

            .action-buttons i {
                margin-right: 5px;
            }

            .btn-secondary {
                display: block;
                width: fit-content;
                margin: 20px auto;
                background: transparent;
                border: 2px solid #D4AF37;
                color: #D4AF37;
                font-weight: bold;
                text-transform: uppercase;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                background: #D4AF37;
                color: black;
                transform: translateY(-3px);
            }
            
            .alert-custom {
                background-color: #333;  /* Màu nền đen */
                color: white;             /* Màu chữ trắng */
                transition: opacity 1s ease-out;  /* Thêm hiệu ứng ẩn dần */
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

        <div class="container list-container">
            
                <!-- Display error message if there is one -->
            <c:if test="${not empty errorMessage}">
                <div id="error-message" class="alert alert-custom" role="alert">
                    <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                </div>
            </c:if>
            <h2><i class="fas fa-th-list"></i> Model List</h2>

            <div class="container">
                <form action="modelslist" method="POST">
                    <div class="mb-3 d-flex align-items-center">
                        <label for="modelName" class="form-label mr-3">Add Model</label>
                        <input type="text" class="form-control" id="modelName" name="modelName" placeholder="Enter model name" required>
                        <button type="submit" class="btn btn-add ml-3">
                            <i class="fas fa-plus"></i> Add New Model
                        </button>
                    </div>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Model ID</th>
                            <th>Model Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="model" items="${models}">
                            <tr>
                                <td>${model.modelId}</td>
                                <td>${model.modelName}</td>
                                <td class="action-buttons">
                                    <!-- Edit Button -->
                                    <a href="updateModelServlet?modelId=${model.modelId}" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>

                                    <!-- Delete Button -->
                                    <a href="deleteModelServlet?modelId=${model.modelId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this model?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <a href="home" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

    </body>
    
    <script>
        const errorMessage = document.getElementById('error-message');
        if (errorMessage) {
            setTimeout(function () {
                errorMessage.style.opacity = '0'; // Fade out
                // Wait for transition to complete before hiding completely
                setTimeout(function () {
                    errorMessage.style.display = 'none'; // Remove from layout
                }, 1000); // matches CSS transition time
            }, 3000);
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
