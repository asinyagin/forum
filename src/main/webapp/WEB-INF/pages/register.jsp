<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap-theme.min.css"/>" />

    <link rel="stylesheet" href="<c:url value="/static/css/style.css"/>" />

    <title>Форум :: Регистрация</title>
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
        <form action="" method="post">
        <div <c:if test="${!error}">style="display:none"</c:if> class="text-danger message">При схоранении произошла ошибка</div>
        <div class="form-group">
            <input name="username" type="text" class="form-control" maxlength="32" placeholder="Имя пользователя" required autofocus />
        </div>
        <div class="form-group">
            <input name="password" type="password" class="form-control" maxlength="32" placeholder="Пароль" required />
        </div>
        <button itype="submit" class="btn btn-primary">Регистрация</button>
        </form>
    </div>


</body>
</html>
