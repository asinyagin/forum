<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap-theme.min.css"/>" />

    <link rel="stylesheet" href="<c:url value="/static/css/style.css"/>" />

    <script type="text/javascript" src="/static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="/static/js/underscore-min.js"></script>
    <script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/static/js/backbone-min.js"></script>

    <title>Форум</title>
</head>
<body>

    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">Форум</a>
            </div>
            <ul class="nav navbar-nav pull-right">
                <sec:authorize var="authed" access="isAuthenticated()" />
                <c:choose>
                    <c:when test="${authed}">
                        <li><a href="#topics/new-topic">Новая тема</a></li>
                        <li><a href="<c:url value="/logout"/>">Выход</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="<c:url value="/register"/>">Регистрация</a></li>
                        <li><a href="<c:url value="/login"/>">Вход</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </nav>

    <div id="topics" class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="text-danger message"></div>
                <table class="col-md-12 table table-striped">
                    <thead>
                        <tr>
                            <th>Тема</th>
                            <th>Автор</th>
                            <th>Действия</th>
                        </tr>
                    </thead>
                    <tbody id="topics-list"></tbody>
                </table>
                <div id="topics-paginator" class="text-center"></div>
            </div>
        </div>
    </div>

    <div id="new-topic" class="container" style="display:none">
        <div class="row">
            <form>
                <div class="text-danger message"></div>
                <div class="form-group">
                    <input name="name" type="text" class="form-control" maxlength="64" placeholder="Тема" />
                </div>
                <div class="form-group">
                    <textarea name="text" class="form-control" placeholder="Сообщение" rows="5"></textarea>
                </div>
                <button id="new-topic-create" type="button" class="btn btn-success">Создать</button>
                <button id="new-topic-cancel" type="button" class="btn btn-default">Отмена</button>
            </form>
        </div>
    </div>

    <div id="topic" class="container" style="display:none">
        <div class="row">
            <a href="#topics/p1">&lt;&lt; Назад</a>
        </div>
        <div class="row">
            <table class="col-md-12 table table-striped">
                <thead>
                <tr>
                    <th>Сообщение</th>
                    <th>Автор</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody id="posts-list"></tbody>
            </table>
        </div>
        <div id="posts-paginator" class="text-center"></div>
        <div class="row">
            <form id="new-post" style="display:none">
                <div class="text-danger message"></div>
                <div class="form-group">
                    <textarea class="form-control" name="text" placeholder="Сообщение" rows="5"></textarea>
                </div>
                <button id="new-post-create" type="button" class="btn btn-success pull-right">Отправить</button>
            </form>
        </div>
    </div>

    <script type="text/template" id="topic-tmpl">
        <tr>
            <td><a href="#topics/<@= id @>/p1"><@= name @></a></td>
            <td><@= user.username @></td>
            <td>
                <@ if (user.username == window.user) { @>
                    <button type="button" class="delete btn btn-warning">Удалить</button>
                    <input type="hidden" value="<@= id @>" />
                <@ } @>
            </td>
        </tr>
    </script>

    <script type="text/template" id="post-tmpl">
        <tr>
            <td><@= text @></td>
            <td><@= user.username @></td>
            <td>
                <@ if (user.username == window.user) { @>
                    <button type="button" class="delete btn btn-warning">Удалить</button>
                    <input type="hidden" value="<@= id @>" />
                <@ } @>
            </td>
        </tr>
    </script>

    <script type="text/template" id="page-tmpl">
        <li<@ if (active) { @> class="active" <@ } @>><a href="#<@= baseUrl @>/p<@= num @>"><@= num @></a>
    </script>

    <c:if test="${user != null}">
        <script type="text/javascript">
            window.user = "${user}";
        </script>
    </c:if>

    <script type="text/javascript" src="/static/js/config/config.js"></script>
    <script type="text/javascript" src="/static/js/models/post.js"></script>
    <script type="text/javascript" src="/static/js/models/posts.js"></script>
    <script type="text/javascript" src="/static/js/models/topic.js"></script>
    <script type="text/javascript" src="/static/js/models/topics.js"></script>
    <script type="text/javascript" src="/static/js/views/pagination.js"></script>
    <script type="text/javascript" src="/static/js/views/topics.js"></script>
    <script type="text/javascript" src="/static/js/views/newTopic.js"></script>
    <script type="text/javascript" src="/static/js/views/topic.js"></script>
    <script type="text/javascript" src="/static/cs/app.js"></script>

</body>
</html>
