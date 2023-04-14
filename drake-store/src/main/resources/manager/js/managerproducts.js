//js multi range price
var inputLeft = document.getElementById("input-left");
var inputRight = document.getElementById("input-right");
var thumbLeft =  document.querySelector(".slider > .thumb.left");
var thumbRight = document.querySelector(".slider > .thumb.right");
var range = document.querySelector(".slider > .range");
function setLeftValue(){
   var _this = inputLeft;
   min = parseInt(_this.min);
   max = parseInt(_this.max);
   _this.value = Math.min(parseInt(_this.value),parseInt(inputRight.value));

   var percent = ((_this.value - min)/(max - min))*100;
   thumbLeft.style.left = percent + "%";
   range.style.left = percent + "%"; 
   document.getElementById("span1").innerHTML=new Intl.NumberFormat('es-EP', { maximumSignificantDigits: 3 }).format(_this.value) + " VND";
}
setLeftValue();
function setRightValue(){
   var _this = inputRight;
   min = parseInt(_this.min);
   max = parseInt(_this.max);
   _this.value = Math.max(parseInt(_this.value),parseInt(inputLeft.value));

   var percent = ((_this.value - min)/(max - min))*100;
   thumbRight.style.right = (100 - percent) + "%";
   range.style.right=  (100 - percent) + "%"; 
   document.getElementById("span2").innerHTML=new Intl.NumberFormat('es-EP', { maximumSignificantDigits: 3 }).format(_this.value)+" VND";
}
setRightValue();
inputLeft.addEventListener("input",setLeftValue);
inputRight.addEventListener("input",setRightValue);