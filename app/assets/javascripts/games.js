//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

function drag(event) {
  event.dataTransfer.setData('Piece', event.target.id);
  event.dataTransfer.setData('id', event.target.getAttribute('data-piece'));
}

function drop(event) {
  event.preventDefault();
  updatePiece();
  window.location.reload();
}

function updatePiece() {
  var pieceId = event.dataTransfer.getData('id');
  var gameId = document.getElementById("board").getAttribute("data-game");
  var postUrl = "/games/" + gameId + "/pieces/" + pieceId + ".json";
  var token = $("meta[name='csrf-token']").attr("content");
  if (parseInt(event.target.id) % 8 == 0) {
    var xCoord = parseInt(parseInt(event.target.id) / 8) - 1;
    var yCoord = 7;
  } else {
    var xCoord = parseInt(parseInt(event.target.id) / 8);
    var yCoord = parseInt(parseInt(event.target.id) % 8) - 1;
  }
  $.ajax({
    url: postUrl,
    method: "PUT",
    data: {
      authenticity_token: token,
      x_coord: xCoord,
      y_coord: yCoord
    },
    dataType: "json"
  });
}
