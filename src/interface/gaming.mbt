fn gaming()->Unit{
  gaming_logic()
  // @antity.player_Plane_1.print()
}

fn gaming_logic()->Unit{
  //get_next_pos
  //self_plane_update_pos
  // if (button_state.val.button_down||button_state.val.button_up||button_state.val.button_left||button_state.val.button_right)||(button_state.val.button_down&&button_state.val.button_up&&button_state.val.button_left&&button_state.val.button_right){
  //   update_self()
  // }
  
  //check crash
  //show
  @antity.player_Plane.print()
}

fn update_self()->Unit{
  let mut dir:Double=0;
  if (button_state.val.button_down&&button_state.val.button_up).not(){
    if button_state.val.button_down {
      if (button_state.val.button_right||button_state.val.button_left).not()&&(button_state.val.button_right&&button_state.val.button_left) {dir=90}
      else if(button_state.val.button_right){
        dir=45;
      }
      else if button_state.val.button_left {dir=135.0;}
      
    }
    else{
      if (button_state.val.button_right||button_state.val.button_left).not()&&(button_state.val.button_right&&button_state.val.button_left) {dir=180}
      else if(button_state.val.button_right){
        dir=360.0-45;
      }
      else if button_state.val.button_left {dir=225;}
    }
    @antity.player_Plane.dir=dir
    @antity.player_Plane.update_pos()
  }
}
