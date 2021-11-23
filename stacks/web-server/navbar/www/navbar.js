
$(document).ready(function(){
    let currentApp = "NA";
    
    // navbar app navigation
    $(".app-option").click(function(){
        let protocol = "https://",
            prefix = $(this).data('type') + ".",
            host = window.location.host,
            suffix = "/?app=",
            app = $(this).data('app'),
            src = protocol + prefix + host + suffix + app;
        $(".navbar-spinner-div").css('visibility','visible');              
        $('#app-frame').attr('src', src);
    });
    $(".navbar-brand").click(function(){
        $('.active-app').html('');
    });
    
    // control size of iframe (to fill window)
    sizeIFrame = function(){
        let wh = $(window).height(),
            hh = $(".navbar").height(),
            hp = 2 * 5, // navbar top + bottom padding
            fh = wh - hh - hp; 
        $("#app-frame").height(fh + 'px');          
    };    
    $(window).resize(sizeIFrame);
    sizeIFrame();

    // spinner that shows until app first returns as loaded
    $('#app-frame').on('load', function(){
        $(".navbar-spinner-div").css('visibility','hidden');
    });
});




