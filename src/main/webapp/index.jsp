<%

    HttpSession s = request.getSession();
    Object o = s.getAttribute("userid");
    if (o == null) {
        response.sendRedirect("login.html");
    }
%>


<body>

<head>
    <title>To Do App</title>

    <link rel="stylesheet" href="css.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>


<div id="welcome">
    <h1>Welcome to ToDoApp!</h1>
    <h2>Your life has never been more organised!</h2>
</div>

<div id="newtodo">
    <input type="text" id="nameToDo" name="nameToDo" placeholder="Do something"/>
    <input type="button" id="add" value="Trimite" onClick="addNewToDo()"/>
</div>

</br>

<div id="listOfToDo">
    <ul></ul>
</div>

</br>

<div id="doneTasks" onclick="seeAllDone()" style="cursor: pointer"></div>

<div id="listOfDone" style="display:none">
    <ul id="listDone"></ul>
</div>

</body>

<script>

    //submit task on enter
    document.getElementById("nameToDo").addEventListener("keydown", function(e){
        if (e.keyCode == 13) { addNewToDo(); }
    }, false);

    // just doing an ajax call
    function loadToDo() {
        $.ajax({
            url: 'tl?action=read'
        }).done(function (response) {
            putToDoInHTML(response.todo);
        });
    }

    function putToDoInHTML(todo) {
        var list = document.getElementById('listOfToDo').getElementsByTagName('ul')[0];
        var listHtml = '';

        for (var i = 0; i < todo.length; i++) {
            var task = todo[i];
            var priority = task["prioritytask"];

            if(priority === 0) {
                var taskHtml =
                    '<li>' +
                    '<input type="checkbox" value="' + task.id + '"style="cursor: pointer" onclick=markDone("' + task.id + '")>' +
                    task.name + '<div id="star-five" style="float: right;  cursor: pointer" onclick=priority("' + task.id + '")></div>' +
                    '</li>';
                listHtml += taskHtml;
            }
            else{
                var taskHtml =
                    '<li>' +
                    '<input type="checkbox" value="' + task.id + '"style="cursor: pointer" onclick=markDone("' + task.id + '")>' +
                    task.name + '<div id="star-five-prior" style="float: right; cursor: pointer" onclick=notPriority("' + task.id + '")></div>' +
                    '</li>';
                listHtml = taskHtml + listHtml;
            }
        }
        list.innerHTML = listHtml;
    }

    loadToDo();


    function addNewToDo() {          //trimitem date
        var nametodo = document.getElementById('nameToDo').value;

        if (nametodo.trim().length > 0) {
            $.ajax({
                url: 'tl?action=write&newName=' + nametodo
            }).done(function (response) {
                location.href = "index.jsp";
            });
        }
        else {
            var alertDiv = document.createElement("p");
            alertDiv.setAttribute("id", "alertMessage");
            var alertContent = document.createTextNode("You must insert data!");
            alertDiv.appendChild(alertContent);
            var fieldsDiv = document.getElementById("newtodo");
            fieldsDiv.appendChild(alertDiv);
        }
    }

    function markDone(id) {
        $.ajax({
            url: 'tl?action=markdone&id=' + id
        }).done(function (response) {
            location.href = "index.jsp";
        });
    }

    function loadDone() {
        $.ajax({
            url: 'tl?action=viewDone'
        }).done(function (response) {
            viewDoneTasks(response.done);
        });
    }

    function viewDoneTasks(done) {
        document.getElementById("doneTasks").innerHTML='You have ' + done.length + ' completed tasks: ';

        var list = document.getElementById('listOfDone').getElementsByTagName('ul')[0];
        var listHtml = '';

        for (var i = done.length-1; i >= 0; i--) {
            var task = done[i];
            var taskHtml =
                '<li>' +
                '<input type="checkbox" value="' + task.id + '" onclick=markUndone("' + task.id + '")>' +
                task.name +
                '</li>';
            listHtml += taskHtml;
        }
        list.innerHTML = listHtml;
    }
    loadDone();

    function seeAllDone() {
        var x = document.getElementById("listOfDone");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

    function markUndone(id) {
        $.ajax({
            url: 'tl?action=markundone&id=' + id
        }).done(function (response) {
            location.href = "index.jsp";
        });
    }

    function priority(id) {

        $.ajax({
            url: 'tl?action=markpriority&id=' + id
        }).done(function (response) {
            location.href = "index.jsp";
        });
    }

    function notPriority(id) {
        $.ajax({
            url: 'tl?action=unmarkpriority&id=' + id
        }).done(function (response) {
            location.href = "index.jsp";
        });
    }
</script>


<p id="logout">
    <a href="logout">Logout</a>
</p>


</body>

</html>
