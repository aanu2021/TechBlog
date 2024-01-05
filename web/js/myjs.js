function doLike(pid, uid, classReference)
{
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };

//    $(classReference).removeClass("btn-outline-primary");

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim() == 'done'){
                let counter = $(".like-counter").html();
                counter++;
                $(".like-counter").html(counter);
                $(classReference).removeClass("btn-outline-primary");
                $(classReference).addClass("btn-primary");
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
                let counter = $(".like-counter").html();
                counter--;
                $(".like-counter").html(counter);
                $(classReference).removeClass("btn-primary");
                $(classReference).addClass("btn-outline-primary");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}