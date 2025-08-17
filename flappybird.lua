--0

function _init()
    game_over = false;
    make_cave()
    make_player();
end;


function _update()
    if (not game_over) then
        update_cave();
        move_player();
        check_hit();
    end    
end

function _draw()
    cls()
    draw_cave()
    draw_player()
    
    if(game_over) then
    		print("game over!", 44,44,7)
    		print("your score:" ..player.score,34,54,7)
    else
    		print("score:" ..player.score,2,2,2)
    end				
end


--1

function make_player()
    player = {}
    player.score = 0;
    --position:
    player.x = 24;
    player.y = 60;
    
    --physics
    player.dy = 0; --fall speed
    player.speed = 2; --up speed

    --sprites
    player.rise = 1;
    player.fall = 2;
    player.dead = 3;
end

function draw_player()
    if(game_over) then
        spr(player.dead, player.x, player.y);
    elseif (player.dy < 0 ) then
        spr(player.rise, player.x, player.y);
    else
        spr(player.fall, player.x, player.y)
    end        
end   

function move_player()
    gravity = 0.2;
    player.dy = gravity + player.dy;

    if(btnp(2)) then
        player.dy = player.dy - 2;
    end
    player.y = player.y + player.dy
				player.score = player.score + player.speed
end    

function check_hit()
    for i = player.x, player.x + 7 do
        if cave[i+1].top > player.y+7
        or cave[i+1].btm < player.y then
            game_over = true
        end    
    end
end

-- 2

function make_cave()
    cave = {{["top"] = 5, ["btm"] = 119}}
    top = 45
    btm = 85
end

function update_cave()
    if #cave > player.speed then
        for i = 1, player.speed do
            del(cave, cave[1])
        end
    end

    while #cave < 128 do
        local col = {}
        local up = flr(rnd(7) - 3)
        local dwn = flr(rnd(7) - 3)
        col.top = mid(3, cave[#cave].top + up, top)
        col.btm = mid(btm, cave[#cave].btm + dwn, 124)
        add(cave, col)
    end
end

function draw_cave()
    top_color = 8
    btm_color = 12

    for i = 1, #cave do
        line(i-1, 0, i-1, cave[i].top, top_color)
        line(i-1, 127, i-1, cave[i].btm, btm_color)
    end
end

