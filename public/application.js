$(document).ready(function() {
  (function() {
    var show = function(e) {
      return function(msg) {
        e.innerHTML = msg + '<br />' + e.innerHTML;
      }
    }($("#messages")[0]);
    // WS
    if (location.protocol == "https:") {
      var ws = new WebSocket('wss://' + window.location.host + window.location.pathname);
    }
    if (location.protocol == "http:") {
      var ws = new WebSocket('ws://' + window.location.host + window.location.pathname);
    }
    ws.onopen = function(e) {
      console.warn(`Opened at ${new Date()}`)
      console.log(e);
    };
    ws.onclose = function(e) {
      console.warn(`Closed at ${new Date()}`)
      console.log(e);
    };
    ws.onerror = function(e) {
      console.error(`Error occured at ${new Date()}`);
      console.error(e);
    }
    ws.onmessage = function(e) {
      show(e.data);
    };
    // DOM
    var sender = function(f) {
      var input = document.getElementById('input');
      f.onsubmit = function() {
        ws.send(input.value);
        input.value = "";
        return false;
      }
    }(document.getElementById('form'));

  })();
});