if (!variable_instance_exists(id,"ai_ready") || ai_ready==false)
{
    ai_ready = true;
    last_score = -1;
    enemy_team = (team+1)%2;
}

var ball = instance_find(o_ball,0);
if (ball == noone) exit;

var ball_team;

if (ball.sprite_index == ball.sprite_ball[0]) { ball_team = 0; }
if (ball.sprite_index == ball.sprite_ball[1]) { ball_team = 1; }

switch (number)
{
    case 1: //Defensa; se queda en la primer cuarto de campo propia.
        myLeft = global.boundaries[3] + 3*team*(global.boundaries[1]-global.boundaries[3])/4;
        myRight = myLeft + (global.boundaries[1]-global.boundaries[3])/2;
        break;
    case 2: //Ataque: se va de la mitad hacia adelante.
        myLeft = global.boundaries[3] + enemy_team*(global.boundaries[1]-global.boundaries[3])/2;
        myRight = myLeft + (global.boundaries[1]-global.boundaries[3])/2;
        break;
    case 3: //Líbero; se mueve entre el punto entre Defensa y Ataque y la bola.
        var midPoint = (team_units[0].x+team_units[1].x)/2;
        myLeft = min(ball.x, midPoint);
        myRight = max(ball.x, midPoint);
        break;
}

// Calculamos el punto en Y donde la bola caerá para nuestro x requerido.
// Probamos para el x actual y para ir a la derecha y a la izquierda, y nos movemos al mejor.
var dx_mejor = -10000;
var dx_mejor_distancia;

for (dx = -1; dx<=1; dx++)
{
    var x_req = x+dx*5;
    
    //Si estoy fuera de rango, meterme a la fuerza.
    if (x > myRight && dx!=-1 || x < myLeft && dx!=1) { continue; }
    //Si este movimiento me sacaría de rango, ignorarlo.
    if (x>=myLeft && x<=myRight && (x_req>myRight || x_req<myLeft)) { continue; }

    var x0 = ball.x;
    var y0 = ball.y;
    var sx = max(1, abs(ball.h_speed))*sign(x_req-x0); //Asumir que la bola siempre viene hacia mí.
    var sy = ball.v_speed;
    
    while (true)
    {
        if (abs(sy)<0.1 || abs(sx)<0.1) //Si la bola viene de frente, intersectarla directamente.
        {
            y1 = y0;
            break;
        }
        var m = sy/sx;
        y1 = y0 + m*(x_req-x0);
        if (y1>=global.boundaries[0] && y1<=global.boundaries[2]){ break; }
        y1 = clamp(y1, global.boundaries[0], global.boundaries[2]);
        x0 = (y1-y0)/m+x0;
        y0 = y1;
        sy *= -1;
    }
    if (dx_mejor==-10000 || abs(y1-y)<dx_mejor_distancia)
    {
        dx_mejor = dx;
        dx_mejor_distancia = abs(y1-y);
        targetY = y1;
    }
}

h_in = dx_mejor;

if (abs(targetY-y)>4) { v_in = sign(targetY-y); }
