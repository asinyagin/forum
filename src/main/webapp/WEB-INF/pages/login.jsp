<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap-theme.min.css"/>" />

    <link rel="stylesheet" href="<c:url value="/static/css/style.css"/>" />

    <title>Форум :: Вход</title>
</head>
<body>

    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">Форум</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <form action="<c:url value="/j_spring_security_check"/>" method="post">
            <div class="text-danger message"></div>
            <div class="form-group">
                <input name="j_username" type="text" class="form-control" maxlength="32" placeholder="Имя пользователя" required autofocus />
            </div>
            <div class="form-group">
                <input name="j_password" type="password" class="form-control" maxlength="32" placeholder="Пароль" required />
            </div>
            <button itype="submit" class="btn btn-lg btn-primary">Вход</button>
        </form>
    </div>

</body>
</html>
