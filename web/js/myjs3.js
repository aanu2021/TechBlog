function doFollow(followerId, followingId)
{
    const d = {
        followerId: followerId,
        followingId: followingId,
        operation: 'follow'
    };

    $.ajax({
        url: "FollowServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim() == 'done'){
                window.location="profile.jsp?userId=" + followingId + "";
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}


function doUnFollow(followerId, followingId)
{
    const d = {
        followerId: followerId,
        followingId: followingId,
        operation: 'unfollow'
    };

    $.ajax({
        url: "FollowServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim() == 'done'){
                window.location="profile.jsp?userId=" + followingId + "";
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}


