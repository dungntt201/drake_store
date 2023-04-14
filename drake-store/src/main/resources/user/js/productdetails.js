function OpenCart(){
    document.getElementById("sc").style.transform = "translateX(0%)";
}
//dong cart
function CloseCart(){
    document.getElementById("sc").style.transform = "translateX(100%)";
}

//icon tìm kiếm
function openNav() {
    document.getElementById("myNav").style.height = "100%";
}

function closeNav() {
document.getElementById("myNav").style.height = "0%";
}
var cart = 0;
var money =0;
var love =0;
$(document).ready(function(){
   /* //add cart
    $(document).on('click', '.pro-details .info_img_details .select_item .buy .buy1 button#add', function(){
        //add cart and money header
        var sl = parseInt($(this).parents().children("input").val());
        cart = cart + sl;
        var money1 =$(".pro-details .info_img_details .info #price").text();
        var money2 = parseFloat(money1.slice(1));
        money = money + money2*sl;
        $("#addcart").text(cart);
        $("#money").text("$"+money.toFixed(2));
    });*/
    //like
   /* $(document).on('click', '.pro-details .info_img_details .select_item .buy .buy1 button#like', function(){
        if($(this).children("i").attr('class')==("far fa-heart")){
            $(this).html("<i class='fas fa-heart'></i>");
            $(this).find("i").css("color","red");
            love = love +1;
            $("#love1").text(love);
        }else{
            $(this).html("<i class='far fa-heart'></i>");
            // $(this).css("color","unset");
            love = love -1;
            $("#love1").text(love);
        }
    });*/
//thay đổi ảnh chi tiết của sản phẩm
$(".pro-details .select-img button").click(function(){
    $(this).css("opacity","1");
    var src = $(this).children("img").attr("src");
    $(".pro-details .img-zoom-container img").attr("src",src);
    var select = $(".pro-details .select-img button");
    for(var i=0;i<select.length;i++){
        if($(select[i]).children("img").attr("src")==src){
            if($(select[i]).css("opacity")==0.5){
                $(select[i]).css("opacity","1");
            }
        }
        else{
            $(select[i]).css("opacity","0.5");
        }
    }
});
//main menu ẩn	
    $(".sidenav .all-category .category1 p .fa-chevron-down").click(function(){
    	$(this).parents().children(".category2").css("display","block");
    	$(this).parents().children(".fa-chevron-up").css("display","block");
    	$(this).parents().children(".fa-chevron-up").css("top","15px");
    	$(this).css("display", "none");
    });
    $(".sidenav .all-category .category1 p .fa-chevron-up").click(function(){
    	$(this).parents().children(".category2").css("display","none");
    	$(this).parents().children(".fa-chevron-down").css("display","block");
    	$(this).parents().children(".fa-chevron-down").css("top","15px");
    	$(this).css("display", "none");
    });
});
window.onscroll = function() {scrollFunction()};
var mybutton = document.getElementById("myBtn");
// header fixed và hiện  nút về đầu trang
function scrollFunction() {
if (document.body.scrollTop > 100|| document.documentElement.scrollTop > 100) {
mybutton.style.bottom = "10px";
document.getElementById("header").style.transition = "all 0.5s";
document.getElementById("header").style.top = "0";
document.getElementById("header").style.position = "fixed";
document.getElementById("header").style.boxShadow ="0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)";
} else if ((document.body.scrollTop < 100 && document.body.scrollTop > 78) || (document.documentElement.scrollTop < 100 && document.documentElement.scrollTop >78)){
//document.getElementById("header").style.top = "-50px";
// document.getElementById("header").style.position = "unset";
mybutton.style.bottom = "10px";
document.getElementById("header").style.transition = "all 0.5s";
document.getElementById("header").style.boxShadow = "unset";
document.getElementById("header").style.top = "-100%";
document.getElementById("header").style.position = "unset";
}else{
document.getElementById("header").style.transition = "all 0.5s";
document.getElementById("header").style.boxShadow = "unset";
document.getElementById("header").style.position = "unset";
mybutton.style.bottom = "-60px";
}
}
//mở main menu
function openNav1() {
    document.getElementById("mySidenav").style.transform = "translateX(0%)";
//alert("nguyen hung tinh");
}
//tắt main menu
function closeNav1() {
document.getElementById("mySidenav").style.transform = "translateX(100%)";
}
//leen top
function topFunction() {
document.body.scrollTop = 0;
document.documentElement.scrollTop = 0;
}