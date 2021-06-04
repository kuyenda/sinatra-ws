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
    ws.onopen = function(ws) {
      // show(ws.data);
    };
    ws.onclose = function(ws) {
      // show(ws.data);
    };
    ws.onmessage = function(ws) {
      show(ws.data);
    };
    ws.onerror = function(ws) {
      console.error(ws);
    }
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