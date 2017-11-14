    if (selected) {
        // Leer el teclado.
        if (team == 0 && keyboard_check(ord('A')) || team == 1 && keyboard_check(vk_left))
        {
            h_in -= 1;
        }
        if (team == 0 && keyboard_check(ord('D')) || team==1 && keyboard_check(vk_right))
        {
            h_in += 1;
        }
        if (team == 0 && keyboard_check(ord('W')) || team==1 && keyboard_check(vk_up))
        {
            v_in -=1;
        }
        if (team == 0 && keyboard_check(ord('S')) || team==1 && keyboard_check(vk_down))
        {
            v_in +=1;
        }
    }
