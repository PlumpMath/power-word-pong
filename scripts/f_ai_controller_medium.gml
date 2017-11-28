if (!variable_instance_exists(id,"ai_ready") || ai_ready==false)
{
    ai_ready = true;
    last_score = -1;
    enemy_team = (team+1)%2;
}

if (global.scores[enemy_team] != last_score)
{
    last_score = global.scores[enemy_team];
    targetX = random_range(global.boundaries[3]+200, global.boundaries[1]-200);
    targetY = random_range(global.boundaries[0]+200, global.boundaries[2]-200);
}


var ball = instance_find(o_ball,0);

if (ball == noone) exit;

var ball_team;


if (ball.sprite_index == ball.sprite_ball[0]) { ball_team = 0; }
if (ball.sprite_index == ball.sprite_ball[1]) { ball_team = 1; }

if (ball_team == team)
{
     //Ir hacia el punto inicial.
     var dist = targetY-y;
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

if (sign(ball.h_speed)!=sign(team*2-1))
{
    var dist = targetX-x;
    if (abs(dist)>4) { h_in = sign(dist); }
}
else if (ball_team != team)
{
    h_in = sign(ball.h_speed);
}
