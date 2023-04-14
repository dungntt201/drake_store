<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Sending Email with Freemarker HTML Template Example</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<!-- Popper JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- use the font -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            font-size: 48px;
        }
        table, th, td {
		  border: 1px solid black;
		  border-collapse: collapse;
		}
		th, td{
			padding:10px;
		}
    </style>
</head>
<body style="margin: 0; padding: 0;width: 100%">
	<p>Xin chào <span style="font-weight:bolder">${saleorder.customer_name}</span</p>
	<p>Cảm ơn bạn đã đặt hàng của <span style="font-weight:bolder">Drake Store</span>. <br>Chúng tôi sẽ sớm liên lạc với bạn để xác nhận đơn hàng.<br> Đây là hóa đơn của bạn:</p>
    <div class="container-fluid" style="width: 90%;border: 2px solid black; margin:50px 0;border-radius: 10px;padding:0 20px;" >
                    
        <h1 class="text-center">Drake Store</h1>
        <h5 class="text-center">Địa chỉ : Tân Lập - Đan Phượng - Hà Nội</h5>
        <h3 class=" text-center">Hóa Đơn Bán Lẻ</h3>
        <p class="text-left"><span style="font-weight: bolder">Ngày :</span>  ${saleorder.created_date?string('dd.MM.yyyy HH:mm:ss') }</p>
        <p class="text-left"><span style="font-weight: bolder">Số HĐ :</span> ${saleorder.code }</p>
        <p class="text-left"><span style="font-weight: bolder">Tên Khách Hàng :</span> ${saleorder.customer_name }</p>
        <p class="text-left"><span style="font-weight: bolder">SĐT :</span> ${saleorder.customer_phone }</p>
        <p class="text-left"><span style="font-weight: bolder">Email :</span> ${saleorder.customer_email }</p>
        <p class="text-left"><span style="font-weight: bolder">Địa chỉ :</span> ${saleorder.customer_address }</p>
            
            	<table>
            			
            		<tr>
            			<!-- <th>ID</th> -->
            			<th>Tên SP</th>
            			<th>Size</th>
            			<th>SL</th>
            			<th>Đơn giá</th>
            			<th>Thành tiền</th>
 
            		</tr>
            		<#list cartItems as item>
		        		<tr>
					
		        			<td>${item.productName}</td>
		        			<td>${item.size}</td>
		        			<td>${item.quanlity}</td>
		        			<td>${item.priceUnit}</td>
		        			<td>${item.quanlity*item.priceUnit}</td> 
		            				
		        		</tr>
        			</#list>
        	</table>
        
        <h3 style="text-align: left">Tổng tiền: ${saleorder.total } VND</h3>
    </div>
    <p style="text-align:right">Trân trọng,</p>
    <p style="text-align:right">Ban quản trị Drake Store</p>

</body>
</html>