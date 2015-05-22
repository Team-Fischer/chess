//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

function drag(event) {
  event.dataTransfer.setData('Piece', event.target.id);
  event.dataTransfer.setData('id', event.target.getAttribute('data-piece'));
}

function drop(event) {
  event.preventDefault();
  updatePiece(event);
}

function updatePiece(event) {
  var pieceId = event.dataTransfer.getData('id');
  var gameId = document.getElementById("board").getAttribute("data-game");
  var postUrl = "/games/" + gameId + "/pieces/" + pieceId + ".json";
  var xCoord = parseInt(document.getElementById(event.target.id).getAttribute("data-column"));
  var yCoord = parseInt(document.getElementById(event.target.id).getAttribute("data-row"));
  $.ajax({
    url: postUrl,
    method: "PUT",
    data: {
      x_coord: xCoord,
      y_coord: yCoord
    },
    dataType: "json"
  })
    .done(function(data, textStatus, jqXHR){
      $("#piece-warning").removeClass("alert alert-danger").text("");
      drawBoard();
    })
    .fail(function (data, textStatus, jqXHR){
      $("#piece-warning").addClass("alert alert-danger").text("You can't move that piece there.");
    }
  );
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
      for (var row=0;row<8;row++){
        for (var cols=0;cols<8;cols++){
          if(board[row][cols] != null){
            var square = (board[row][cols].y_coord * 8) + (board[row][cols].x_coord + 1);
            $("#" + square.toString()).html("<span class='glyphicon glyphicon-" + board[row][cols].glyph +
                " piece " + board[row][cols].color + "' aria-hidden='true' ondragstart='drag(event)' " +
                "draggable='true' data-piece='" + board[row][cols].id + "' id='" + square + "p'" +
                "data-row='" + row.toString() + "' data-column='" + cols.toString() + "'></span>");
          } else {
            var emptySquare = (row * 8) + (cols + 1);
            $("#" + emptySquare.toString()).html("");
          }
        }
      }
    }
  );
}

function initFirebase() {
  var gameKey = document.getElementById("board").getAttribute("data-firebase");
  var firebaseUri = "https://fischer-chess.firebaseio.com/games/" + gameKey;
  var firebaseConn = new Firebase(firebaseUri);

  firebaseConn.on("child_changed", function(snapshot) {
    drawBoard();
  }, function(errorObject) {
    console.log("The read failed: " + errorObject.code);
  });
}
