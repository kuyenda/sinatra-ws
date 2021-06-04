$(document).ready(function() {
  (function() {
    var show = function(e) {
      return function(msg) {
        e.innerHTML = msg + '<br />' + e.innerHTML;
      }
    }($("#messages")[0]);
    // WS
    var ws = new WebSocket('ws://' + window.location.host + window.location.pathname);
    ws.onopen = function(ws) {
      // show(ws.data);
    };
    ws.onclose = function(ws) {
      show(ws.data);
    }
    ws.onmessage = function(ws) {
      show(ws.data);
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