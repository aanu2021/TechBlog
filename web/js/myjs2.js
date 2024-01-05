function doLike(pid, uid, classReference)
{
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim() == 'done'){
                window.location = "profile.jsp";
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}

function doUnLike(pid, uid, classReference)
{
    const d = {
        uid: uid,
        pid: pid,
        operation: 'unlike'
    };

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim() == 'done'){
                window.location = "profile.jsp";
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}

