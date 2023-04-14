 //js icon tìm kiếm
 function openNav() {
    document.getElementById("myNav").style.height = "100%";
}

function closeNav() {
   document.getElementById("myNav").style.height = "0%";
}
// var wd = window.innerWidth;
// var wd = screen.width;
var cart = 0;
var money =0;
$(document).ready(function(){
    //add san pham vao cart
    $(document).on('click', '.slide-product1 .slide-pro .container .carousel .carousel-inner .item .itemm .item1 .btt #add', function(){
        //add cart and money header
        cart= cart+1;
        var money1 =$(this).parents().children("#pi2").text();
        var money2 = parseFloat(money1.slice(1));
        money = money + money2;
        $("#addcart").text(cart);
        $("#money").text("$"+money.toFixed(2));

        //add product vào khung cart
       $("#addcart").text(cart);
       $("#money").text("$"+money.toFixed(2));
        var b = $(".show_cart .cart-products .cart-products1");
        var src1 = $(this).parents(".item1").children("a").children("#img11").attr("src");
        var name  = $(this).parents(".item1").children("#pi1").text()
        var price = $(this).parents(".item1").children("#pi2").text();
        $(b[0]).children(".img-pro-cart").children("img").attr("src",src1);
        $(b[0]).children(".info-pro-cart").children("p").children("#pro-price").text(price);
        $(b[0]).children(".info-pro-cart").children("#pro-name").text(name);
        var dem=0;
        if(b.length<=1){
            var a = $("<div />").append($(b[0]).clone()).html();
            $(".show_cart .cart-products").append(a);
        }
        else{ 
            for(var i=0;i<b.length;i++){
                if(i==0){
                    continue;
                }
                else{
                    if($(b[i]).children(".info-pro-cart").children("#pro-name").text()==name){
                        var pre_sl = parseFloat($(b[i]).children(".info-pro-cart").children("p").children("#sl").text());
                        pre_sl+=1;
                        $(b[i]).children(".info-pro-cart").children("p").children("#sl").text(pre_sl);
                        dem=0;
                        break;
                    }
                    else{
                        dem=1;
                    }
                }
            }
        }
        if(dem==1){
            var c = $("<div />").append($(b[0]).clone()).html();
            $(".show_cart .cart-products").append(c);
        }
        var d = $(".show_cart .cart-products .cart-products1");
        var total_money=0;
        for(var i=0;i<d.length;i++){
            if(i==0){
                continue;
            }
            else{
                 var total = parseFloat($(d[i]).children(".info-pro-cart").children("p").children("#pro-price").text().slice(1));
                 var sll = parseFloat($(d[i]).children(".info-pro-cart").children("p").children("#sl").text());
                 total_money+=(total*sll);
            }
        }
        $(".show_cart .total-money p #t-m").text("$"+total_money.toFixed(2)); 
    });

    //xoa san pham khoi cart
    $(document).on('click', '.show_cart .cart-products .cart-products1 #delete', function(){
        // xóa sp trong khung giỏ hnagf
        $(this).parents(".cart-products1").remove();

        //trừ số lượng icon cart
        var pre_sl1 = parseInt($(this).parents(".cart-products1").children(".info-pro-cart").children("p").children("#sl").text());
        var cart = parseInt($("#addcart").text());
        $("#addcart").text(cart-pre_sl1);

        // trừ tiền trong khung cart
        var money_pre = parseFloat($(".show_cart .total-money p #t-m").text().slice(1));
        var money_minus = parseFloat($(this).parents(".cart-products1").children(".info-pro-cart").children("p").children("#pro-price").text().slice(1));
        var sll_minus = parseFloat($(this).parents(".cart-products1").children(".info-pro-cart").children("p").children("#sl").text());
        $(".show_cart .total-money p #t-m").text("$"+(money_pre-(money_minus*sll_minus)).toFixed(2));
        
        // trừ tiền trên header
        $("#money").text("$"+(money_pre-(money_minus*sll_minus)).toFixed(2));
    });
   //jque phần mục lục ở search bar
   $(".btn2").click(function(){
       var i = $(this).text();
       $("#test2").html(i + "   <span class='caret'></span>");
   });
   //cộng tiền và cart
//    $(".btt").click(function(){
//        cart= cart+1;
//            //  $(".item1").children(".mn1").text();
//        var money1 =$(this).parent().children("#pi2").text();
//        var money2 = parseFloat(money1.slice(1));
//        money = money + money2;
//        $("#addcart").text(cart);
//        $("#money").text("$"+money.toFixed(2));
//    });
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


   // //màn <= 1024
   var wd = window.innerWidth;
   if(wd<=1024){
       $(".dropdown-content").css("display", "none");
       $(".banner .banner1 .menu-banner #x").css("display","none");
       $(".banner .banner1 .menu-banner #mnbn").css("display","block");
       //hiện dấu x tắt bar menu 
       $(".banner .banner1 .menu-banner #mnbn").click(function(){
           $(this).css("display", "none");
           $(this).parents().children("#x").css("display", "block");
           $(".dropdown-content").css("display", "block");
       });
      //hiện bar menu tắt x 
       $(".banner .banner1 .menu-banner #x").click(function(){
           $(this).css("display", "none");
           $(this).parents().children("#mnbn").css("display", "block");
           $(".dropdown-content").css("display", "none");
        });
   }
   else{
       $(".banner .banner1 .menu-banner #x").css("display","none");
       $(".banner .banner1 .menu-banner #mnbn").css("display","block");
       $(".banner .banner1 .menu-banner #mnbn").click(function(){
           $(this).css("display", "block");
           $(this).parents().children("#x").css("display", "none");
           $(".dropdown-content").css("display", "none");
       }); 
   }
   $(window).resize(function(){
       wd = window.innerWidth;
       
      if(wd<=1024){
       $(".dropdown-content").css("display", "none");
       $(".banner .banner1 .menu-banner #x").css("display","none");
       $(".banner .banner1 .menu-banner #mnbn").css("display","block");
       //hiện dấu x tắt bar menu 
       $(".banner .banner1 .menu-banner #mnbn").click(function(){
           $(this).css("display", "none");
           $(this).parents().children("#x").css("display", "block");
           $(".dropdown-content").css("display", "block");
       });
      //hiện bar menu tắt x 
       $(".banner .banner1 .menu-banner #x").click(function(){
           $(this).css("display", "none");
           $(this).parents().children("#mnbn").css("display", "block");
           $(".dropdown-content").css("display", "none");
        });
   }
   else{
       $(".banner .banner1 .menu-banner #x").css("display","none");
       $(".banner .banner1 .menu-banner #mnbn").css("display","block");
       $(".banner .banner1 .menu-banner #mnbn").click(function(){
           $(this).css("display", "block");
           $(this).parents().children("#x").css("display", "none");
           $(".dropdown-content").css("display", "none");
       }); 
   }
   });
   
   //bar menu banner
   // dấu cộng
   $(".openmn").click(function(){
       $(this).css("display","none");
       $(this).parents().children(".closemn").css("display", "block");
       $(this).parents().children(".closemn").css("top", "10px");
       $(this).parents().children(".sub11").css("display","block");
    });
    // dấu trừ
   $(".closemn").click(function(){
       $(this).css("display", "none");
       $(this).parents().children(".openmn").css("display", "block");
       $(this).parents().children(".openmn").css("top", "30%");
       $(this).parents().children(".sub11").css("display","none");
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
// var i = 0;
// function openMenuBanner(){
//     var wd = window.innerWidth;
//     if(i==0){
//         document.getElementById("myDropdown").style.display = "block";
//         document.getElementById("mnbn").style.display = "none";
//         document.getElementById("x").style.display = "block";
//         i=1;
//     }else{
//         document.getElementById("myDropdown").style.display = "block";
//         document.getElementById("mnbn").style.display = "none";
//         document.getElementById("x").style.display = "none";
//         i=0;
//     }
   
// }
// function closeMenuBanner(){
//     var wd = window.innerWidth;
//     if(i==1){
//         document.getElementById("myDropdown").style.display = "none";
//         document.getElementById("mnbn").style.display = "block";
//         document.getElementById("x").style.display = "none";
//         i=0;
//     }else{
//         document.getElementById("myDropdown").style.display = "block";
//         document.getElementById("mnbn").style.display = "none";
//         document.getElementById("x").style.display = "none";
//         i=1;
//     }
   
// }
//mở main menu
function openNav1() {
        document.getElementById("mySidenav").style.transform = "translateX(0%)";
   //alert("nguyen hung tinh");
}
//tắt main menu
function closeNav1() {
   document.getElementById("mySidenav").style.transform = "translateX(100%)";
}
//hien cart
function OpenCart(){
    document.getElementById("sc").style.transform = "translateX(0%)";
}
//dong cart
function CloseCart(){
    document.getElementById("sc").style.transform = "translateX(100%)";
}
//Get the button

// When the user scrolls down 20px from the top of the document, show the button
// window.onscroll = function() {scrollFunction()};
// function scrollFunction() {
// if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
   // mybutton.style.display = "block";
   // mybutton.style.bottom = "10px";
// } else {
   // mybutton.style.display = "none";
   // mybutton.style.bottom = "-60px";
// }
// }
//về đầu trang
function topFunction() {
   document.body.scrollTop = 0;
   document.documentElement.scrollTop = 0;
}