current = nil
score = 0
deadline = 0 
game_over = false

function _init()
  add_arrow()
end

function add_arrow()
  current = flr(rnd(4))      
  deadline = time() + 3      
end

function _update()
  if not game_over then
    if time() > deadline then
      game_over = true 
    end

    if btnp(2) then check_input(0) 
    elseif btnp(3) then check_input(3)
    elseif btnp(0) then check_input(1)
    elseif btnp(1) then check_input(2) 
    end
  end
end

function check_input(dir)
  if dir == current then
    score = score + 1
  else
    score = score - 1
  end
  add_arrow()
end

function _draw()
  cls()
  if current ~= nil then
    spr(current, 60, 60)
  end
  print("score:"..score, 5, 5, 7)
  
  if game_over then
    print("game over!", 50, 30, 8)
  end
end