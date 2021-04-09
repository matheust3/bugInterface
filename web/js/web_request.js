
window.WebRequest = {
  get: async function (url) {
    return new Promise((resolve, reject) => {
      var xmlHttp = new XMLHttpRequest();
      xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
          resolve(xmlHttp.responseText);
        else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
          resolve('STATUS_CODE:' + xmlHttp.status.toString())
        }
      }
      xmlHttp.open("GET", url, true); // true for asynchronous 
      xmlHttp.send(null);
    });
  }
}
