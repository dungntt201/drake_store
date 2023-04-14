//dong cart
function CloseCart(){
    document.getElementById("sc").style.transform = "translateX(100%)";
}

 //js icon tìm kiếm
 function openNav() {
    document.getElementById("myNav").style.height = "100%";
}

function closeNav() {
   document.getElementById("myNav").style.height = "0%";
}
var love = 0;
$(document).ready(function(){
   
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
   
   	//
    $(".blogs .blogs1 .Toc-blog .all-category .category1 p .fa-chevron-down").click(function(){
    	$(this).parents().children(".category2").css("display","block");
    	$(this).parents().children(".fa-chevron-up").css("display","block");
    	$(this).parents().children(".fa-chevron-up").css("top","15px");
    	$(this).css("display", "none");
    });
    $(".blogs .blogs1 .Toc-blog .all-category .category1 p .fa-chevron-up").click(function(){
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
