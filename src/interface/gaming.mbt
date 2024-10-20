fn gaming()->Unit{
  gaming_logic()
  // @antity.player_Plane_1.print()
}

let x:Ref[Int]=Ref::new(1)
let y:Ref[Int]=Ref::new(1)
fn gaming_logic()->Unit{
  //get_next_pos
  //self_plane_update_pos
  if (button_state.val.button_down||button_state.val.button_up||button_state.val.button_left||button_state.val.button_right)&&(button_state.val.button_down&&button_state.val.button_up&&button_state.val.button_left&&button_state.val.button_right).not()&&((button_state.val.button_down&&button_state.val.button_up)&&button_state.val.button_left.not()&&button_state.val.button_right.not()).not()&&(button_state.val.button_down.not()&&button_state.val.button_up.not()&&(button_state.val.button_left&&button_state.val.button_right)).not(){
    update_self()
  }
  if button_state.val.button_down {y.val=y.val+1}
  if button_state.val.button_up {{y.val=y.val-1}}
  if button_state.val.button_left {x.val=x.val-1}
  if button_state.val.button_right {{x.val=x.val+1}}
  @antity.Sprite_parameter::new(x.val.reinterpret_as_uint(),y.val.reinterpret_as_uint(),2).show()
  // @antity.Sprite_parameter::new(10,10,2).show()
  //check crash
  //show
  @antity.player_Plane.print()
}

fn update_self()->Unit{
  let mut dir:Double=0;
  if (button_state.val.button_down&&button_state.val.button_up).not()&&(button_state.val.button_down||button_state.val.button_up){
    if button_state.val.button_down {
      if (button_state.val.button_right||button_state.val.button_left).not()||(button_state.val.button_right&&button_state.val.button_left) {dir=90}
      else if(button_state.val.button_right){
        dir=45;
      }
      else if button_state.val.button_left {dir=135.0;}
      
    }
    else{
      if (button_state.val.button_right||button_state.val.button_left).not()||(button_state.val.button_right&&button_state.val.button_left) {dir=270}
      else if(button_state.val.button_right){
        dir=360.0-45;
      }
      else if button_state.val.button_left {dir=225;}
    }

  }
  else{
    if button_state.val.button_right {dir=0}
    else if button_state.val.button_left {dir=180}
  }
  @antity.player_Plane.dir=dir
  @antity.player_Plane.update_pos()
}
