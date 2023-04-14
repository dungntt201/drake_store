    //icon tìm kiếm
    function openNav() {
        document.getElementById("myNav").style.height = "100%";
   }

   function closeNav() {
       document.getElementById("myNav").style.height = "0%";
   }
   var cart = 0;
   var money =0;
   $(document).ready(function(){
       //jque phần mục lục ở search bar
       $(".btn2").click(function(){
           var i = $(this).text();
           $("#test2").html(i + "   <span class='caret'></span>");
       });
       //cộng tiền và cart
       $(".btt").click(function(){
           cart= cart+1;
               //  $(".item1").children(".mn1").text();
           var money1 =$(this).parent().children("#pi2").text();
           var money2 = parseFloat(money1.slice(1));
           money = money + money2;
           $("#addcart").text(cart);
           $("#money").text("$"+money.toFixed(2));
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
   //ẩn hiện password login
   var x = true;
   function hide(){ 
       if(x){
           document.getElementById("input-pw").type = "text";
           x=false;
       }
       else{
           document.getElementById("input-pw").type = "password";
           x=true;
       }    
   }
   //ẩn hiện password register
   var i= true;
   function hide1(){ 
       if(i){
           document.getElementById("input-pw1").type = "text";
           i=false;
       }
       else{
           document.getElementById("input-pw1").type = "password";
           i=true;
       }    
   }
   function checkUsnLogin(){
       var us =  document.getElementById("input-usn").value;
       var y = /[a-zA-Z0-9]$/;  
       var y1=/[a-zA-Z]$/;
       var x=0;
       for(var i=1;i<=us.length-1;i++)
        {  
            if(y.test(us.charAt(i)))
            {
                x+=1;
            }
            else
            {
               break;
            }
        } 
        if(us.length >= 8 && x==(us.length-1) && y1.test(us.charAt(0)) && (y1.test(us.charAt(0)))){
             document.getElementById("demo1").innerHTML= "";
             return true;
        } 
        else
           {
               document.getElementById("demo1").innerHTML= "Note:Username >=8 kí tự. Kí tự đầu phải là chữ và không được nhập kí tự đặc biệt.";
               document.getElementById("input-usn").value=us;
               return false;
           }
           
   }
   function checkPwLogin(){
       var pw =  document.getElementById("input-pw").value;
       var y = /[0-9]$/;  
       var y1=/[a-z]$/;
       var y2=/[A-Z]$/;
       var i0 = 0;
       var i1 = 0;
       var i2 = 0;
       for(var i=0;i<=pw.length-1;i++)
       {
           if( !y.test(pw.charAt(i)) && !y1.test(pw.charAt(i)) && !y2.test(pw.charAt(i)))
           {
               i0=1;
               break;
           }
           else
           {
              i0=0;
           }
       }
       for(var i=0;i<=pw.length-1;i++)
       {
           if( y1.test(pw.charAt(i)))
           {
               i1=1;
               break;
           }
           else
           {
              i1=0;
           }
       }
       for(var i=0;i<=pw.length-1;i++)
       {
           if( y2.test(pw.charAt(i)))
           {
               i2=1;
               break;
           }
           else
           {
              i2=0;
           }
       }
       if(pw.length>=8 && i0==1 && i1==1 && i2==1){
           document.getElementById("demo2").innerHTML="";
           return true;
       }else{
           document.getElementById("demo2").innerHTML="Note: Mật khẩu >=8 kí tự và phải có ít nhất 1 kí tự thường, 1 kí tự in hoa, 1 kí tự đặc biệt";
           return false;
       }
   }
   function login(){
       var us =  document.getElementById("input-usn").value;
       var p =  document.getElementById("input-pw").value;
        if(checkPwLogin()==true && checkUsnLogin()==true){
           alert("Đăng nhập thành công.Chào mừng "+us+" trở lại website!!");
           document.getElementById("input-usn").value="";
           document.getElementById("input-pw").value="";
        }
           
       else{
           alert("Bạn nhập sai định dạng.Vui lòng nhập lại!!!")
       }     
   }
   
   function checkNameRegister()
    {

       var g = document.getElementById("input-fn1").value;
      
       if(g==null || g=="")
       {
    	   document.getElementById("input-fn1").style.border = "1px solid red";
           document.getElementById("demo-name").innerHTML="Note: Không được để trống trường này";
           return false;
           
       }else if(/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
    	   document.getElementById("input-fn1").style.border = "1px solid red";
           document.getElementById("demo-name").innerHTML="Note: Không được chứa kí tự đặc biệt!";
           return false;
       }
       else
       {
    	   document.getElementById("demo-name").innerHTML="";
           document.getElementById("input-fn1").style.border = "1px solid gray";
           return true;
       }
    }
   
   function checkUsnRegister(){
       var us =  document.getElementById("input-usn1").value;
       var y = /[a-zA-Z0-9]$/;  
       var y1=/[a-zA-Z]$/;
       var x=0;
       for(var i=1;i<=us.length-1;i++)
        {  
            if(y.test(us.charAt(i)))
            {
                x+=1;
            }
            else
            {
               break;
            }
        } 
        if(us.length >= 8 && x==(us.length-1) && y1.test(us.charAt(0)) && (y1.test(us.charAt(0)))){
             document.getElementById("demo3").innerHTML= "";
             document.getElementById("input-usn1").style.border = "none";
             return true;
        }
        else
           {
               document.getElementById("demo3").innerHTML= "Note:Username >=8 kí tự. Kí tự đầu phải là chữ và không được nhập kí tự đặc biệt.";
               document.getElementById("input-usn1").value=us;
               document.getElementById("input-usn1").style.border = "1px solid red";
               return false;
           }
           
   }
   function checkEmRegister()
    {
      /* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
       var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
       var g = document.getElementById("input-em1").value;
       if(y3.test(g))
       {
           document.getElementById("demo4").innerHTML="";
           document.getElementById("input-em1").style.border = "none";
           return true;
       }
       else
       {
       		document.getElementById("input-em1").style.border = "1px solid red";
           document.getElementById("demo4").innerHTML="Note: Lưu ý định dạng email. Vui lòng nhập đúng email nếu sai bạn sẽ không nhận được email reset mật khẩu nếu bạn mất .";
           return false;
       }
    }
    function checkPwRegister(){
       var pw =  document.getElementById("input-pw1").value;
       var y = /[0-9]$/;  
       var y1=/[a-z]$/;
       var y2=/[A-Z]$/;
       var i0 = 0;
       var i1 = 0;
       var i2 = 0;
       var i3 = 0;
       // check kí tự đặc biệt
		if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?]+/.test(pw)) {
			i0 = 1;

		} else {
			i0 = 0;
		}
		
       for(var i=0;i<=pw.length-1;i++)
       {
           if( y1.test(pw.charAt(i)))
           {
               i1=1;
               break;
           }
           else
           {
              i1=0;
           }
       }
       for(var i=0;i<=pw.length-1;i++)
       {
           if( y2.test(pw.charAt(i)))
           {
               i2=1;
               break;
           }
           else
           {
              i2=0;
           }
       }
       
       // check kí tư TV có dấu
		for (var i = 0; i <= pw.length - 1; i++) {
			if (!y2.test(pw.charAt(i))
					&& !y1.test(pw.charAt(i))
					&& !y.test(pw.charAt(i))
					&& !/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?]+/.test(pw
							.charAt(i))) {
				//alert(true);
				i3 = 1;
				break;
			} else {
				i3 = 0;
			}
		}
		
       if(pw.length>=8 && i0==1 && i1==1 && i2==1 && i3 == 0){
       		document.getElementById("input-pw1").style.border = "none";
           document.getElementById("demo5").innerHTML="";
           return true;
       }else{
       		document.getElementById("input-pw1").style.border = "1px solid red";
          document.getElementById("demo5").innerHTML = "Note: Mật khẩu >=8 kí tự và phải có ít nhất 1 kí tự thường, 1 kí tự in hoa, 1 kí tự đặc biệt và không chứa kí tự tiếng việt có dấu";
           return false;
       }   
   }
   function register(){
       var g = document.getElementById("input-em1").value;
       var pw =  document.getElementById("input-pw1").value;
       var us =  document.getElementById("input-usn1").value;
       if(checkPwRegister()==true && checkUsnRegister()==true && checkEmRegister()==true){
           return true;
       }else{
           //alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
           return false;
       }
   }
	
   //check reset_password
   function checkPassword(){
	var pw =  document.getElementById("reset_pass").value;
	var y = /[0-9]$/;  
	var y1=/[a-z]$/;
	var y2=/[A-Z]$/;
	var i0 = 0;
	var i1 = 0;
	var i2 = 0;
	for(var i=0;i<=pw.length-1;i++)
	{
	   if( !y.test(pw.charAt(i)) && !y1.test(pw.charAt(i)) && !y2.test(pw.charAt(i)))
	   {
	       i0=1;
	       break;
	   }
	   else
	   {
	      i0=0;
	   }
	}
	for(var i=0;i<=pw.length-1;i++)
	{
	   if( y1.test(pw.charAt(i)))
	   {
	       i1=1;
	       break;
	   }
	   else
	   {
	      i1=0;
	   }
	}
	for(var i=0;i<=pw.length-1;i++)
	{
	   if( y2.test(pw.charAt(i)))
	   {
	       i2=1;
	       break;
	   }
	   else
	   {
	      i2=0;
	   }
	}
	if(pw.length>=8 && i0==1 && i1==1 && i2==1){
	   document.getElementById("demox").innerHTML="";
	   document.getElementById("demox").style.display ="none";
	   return true;
	}else{
	   document.getElementById("demox").innerHTML="Note: Mật khẩu >=8 kí tự và phải có ít nhất 1 kí tự thường, 1 kí tự in hoa, 1 kí tự đặc biệt";
	   document.getElementById("demox").style.display ="block";
	   return false;
	}   
}
function checkConfirmPass(){
	var pw1 =  document.getElementById("reset_pass").value;
	var pw2 =  document.getElementById("confirm").value;
	var a=0;
	
	   for(var i=0;i<=pw1.length-1;i++) {
	      if(pw1.charAt(i)==pw2.charAt(i)){
	         a++;
	      }
	      else{
	        a=0;
	        break;
	      }
	   }
	
	if(a==pw1.length && a>0 && pw1.length==pw2.length){
	    document.getElementById("demoy").innerHTML="";
	    document.getElementById("demoy").style.display ="none";
	    return true;
	}else{
	    document.getElementById("demoy").innerHTML="Note: Mật khẩu phải trùng nhau";
	    document.getElementById("demoy").style.display ="block";
	    return false;
	}
}
function resetpass(){
    
    if(checkPassword()==true && checkConfirmPass()==true){
        //alert("Đổi mật khẩu thành công");
         return true;
    }
    else{
        alert("Đổi mật khẩu không thành công.Vui lòng nhập đúng định dạng");
        return false;
        
    }
}