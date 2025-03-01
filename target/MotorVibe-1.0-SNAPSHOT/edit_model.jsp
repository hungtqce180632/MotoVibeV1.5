<%-- 
    Document   : edit_model
    Created on : Mar 1, 2025, 7:27:31 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Model</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="text-center mt-5">Edit Model</h2>

            <form action="updateModelServlet" method="POST">
                <input type="hidden" name="modelId" value="${model.modelId}" />
                <div class="mb-3">
                    <label for="modelName" class="form-label">Model Name</label>
                    <input type="text" class="form-control" id="modelName" name="modelName" value="${model.modelName}" required />
                </div>

                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="modelslist" class="btn btn-secondary ml-3"><i class="fas fa-arrow-left"></i> Cancel</a>
            </form>
        </div>
    </body>
</html>
