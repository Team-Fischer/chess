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
  drawBoard();
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

function drawBoard() {
  var gameId = document.getElementById("board").getAttribute("data-game");
  var getUrl = "/games/" + gameId + ".json";
  $.ajax({
    url: getUrl,
    method: "GET",
    dataType: "json"
  })
    .done(function (json){
      var board = json.game.board_state;
      for (var cols=0;cols<8;cols++){
        for (var row=0;row<8;row++){
          if(board[cols][row] != null){
            var square = (board[cols][row].x_coord * 8) + (board[cols][row].y_coord + 1);
            $("#" + square.toString()).html("<span class='glyphicon glyphicon-" + board[cols][row].glyph +
                " piece " + board[cols][row].color + "' aria-hidden='true' ondragstart='drag(event)' " +
                "draggable='true' data-piece='" + board[cols][row].id + "' id='" + square + "p'></span>");
          } else {
            var emptySquare = (row * 8) + (cols + 1);
            $("#" + emptySquare.toString()).html("");
          }
        }
      }
    }
  );
}

