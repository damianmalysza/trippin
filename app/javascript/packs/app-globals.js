window.isNumberKey = function(evt)
{
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57)) {
       alert("Please Enter Only Numeric Value:");
       return false;
   }

   return true;
}