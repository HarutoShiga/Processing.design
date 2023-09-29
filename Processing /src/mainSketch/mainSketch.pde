window.addEventListener( "load", loadFunc, false );
 
function loadFunc()-> {
 
    var canvas = document.getElementById( "stage" );
    var ctx = canvas.getContext( "2d" );
     
    var pointNum = 100; //座標の数
    var pointArray = new Array();   //座標の配列
     
    //描画単位の軌跡を決める座標を配列に格納
    for( var i = 0; i < pointNum; i++ ) {
        pointArray[i] = new Array();
        pointArray[i][0] = Math.floor( Math.random() * canvas.width ) + 1;
        pointArray[i][1] = Math.floor( Math.random() * canvas.height ) + 1;
    }
 
    var shapeSize = canvas.width / 30;  //描画単位のサイズ
 
    ctx.fillStyle = "#333333";
    ctx.fillRect( 0, 0, canvas.width, canvas.height );
     
    ctx.strokeStyle = "rgb( 255, 255, 255 )";
 
    //軌跡用の座標を結ぶ直線と、描画単位を描画
    for( var i = 0; i < pointNum-1; i++ ) {
        ctx.beginPath();
        ctx.moveTo( pointArray[i][0], pointArray[i][1] );
        ctx.lineTo( pointArray[i+1][0], pointArray[i+1][1] );
        ctx.stroke();
         
        var lineRepeatNum = Math.floor( Math.random() * 6 ) + 1;
        makeLines( ctx, pointArray[i][0], pointArray[i][1], shapeSize, lineRepeatNum );
    }
 
}
 
//描画単位　複数の線をまとめて描く
function makeLines( argCtx, centerX, centerY, radius, num ) {
    for( var i = 0; i < num; i++ ) {
        makeLine( argCtx, centerX, centerY, radius) ;
    }
}
 
//描画単位を構成する線
function makeLine( argCtx, centerX, centerY, radius) {
 
    //描画範囲の左右上下の範囲を計算
    var leftX = centerX - radius;
    var rightX = centerX + radius;
    var topY = centerY - radius;
    var bottomY = centerY + radius;
     
    var ctlPoint = radius * 0.55;
     
    //描画範囲の中心に正円を描画
    /*
    argCtx.beginPath();
    argCtx.arc( centerX, centerY, radius-10, 0, Math.PI*2, false );
    argCtx.stroke();
    */
 
    //中心と左右上下のポイントを少しずらす
    var centerX2 = centerX + Math.floor( Math.random() * radius*2/3 ) - radius/3;
    var centerY2 = centerY + Math.floor( Math.random() * radius*2/3 ) - radius/3;
     
    leftX = leftX + Math.floor( Math.random() * radius*2/3 ) - radius/3;
    rightX = rightX + Math.floor( Math.random() * radius*2/3 ) - radius/3;
    topY = topY + Math.floor( Math.random() * radius*2/3 ) - radius/3;
    bottomY = bottomY + Math.floor( Math.random() * radius/3 ) - radius/3;
 
    //ベジエ曲線を描画する
    argCtx.beginPath();
    argCtx.moveTo( centerX2,  topY );
    argCtx.bezierCurveTo( centerX2 + ctlPoint, topY,
                          rightX, centerY2 - ctlPoint,
                          rightX, centerY2 );
    argCtx.bezierCurveTo( rightX, centerY2 + ctlPoint,
                          centerX2 + ctlPoint, bottomY,
                          centerX2, bottomY );
    argCtx.bezierCurveTo( centerX2 - ctlPoint, bottomY,
                          leftX, centerY2 + ctlPoint,
                          leftX, centerY2 );
    argCtx.bezierCurveTo( leftX, centerY2 - ctlPoint,
                          centerX2 - ctlPoint, topY,
                          centerX2, topY );
 
    argCtx.closePath();
    argCtx.stroke();
 
}