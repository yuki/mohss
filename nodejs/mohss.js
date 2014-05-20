var io = require('socket.io').listen(8000);
io.set('log level', 1);
var is_mohss_activated = true;
var door_status = "false";

io.sockets.on('connection', function (socket) {
  console.log("mohss-node started");
  console.log("is_mohss_activated: "+ is_mohss_activated);
  console.log("door_status: "+ door_status);

  socket.emit('refresh', { is_mohss_activated: is_mohss_activated });
  socket.emit('refresh', { door_status: door_status });

  socket.on('changes', function (data) {
    console.log("CHANGES DATA: "+JSON.stringify(data));
    if ( data.hasOwnProperty('is_mohss_activated') ) {
        is_mohss_activated = data['is_mohss_activated'];
    }
    if ( data.hasOwnProperty('door_status') ) {
        door_status = data['door_status'] ;
    }
    socket.broadcast.emit('refresh', data);
  });
});
