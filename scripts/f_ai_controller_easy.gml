var ball = instance_find(o_ball,0);

if (ball == noone) exit;

var ball_team;

if (ball.sprite_index == ball.sprite_ball[0]) { ball_team = 0; }
if (ball.sprite_index == ball.sprite_ball[1]) { ball_team = 1; }

if (ball_team == team)
{
     //Ir hacia el punto inicial.
     var dist = ystart-y;
     if (abs(dist)>4) { v_in = sign(dist); }
}
else
{
    //AI básica: seguir la bola en Y. Se podría calcular para intersectarla.
    var distx = abs(ball.x-x);
    if (distx > 200)
    {
        v_in = sign(ball.v_speed);
    }
    else
    {
        v_in = sign(ball.y-y);
    }
}
