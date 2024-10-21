fn gaming()->Unit{
  gaming_logic()
  // @antity.player_Plane_1.print()
}

let random:@random.Rand=@random.Rand::new(seed=b"")
let aircraft:Array[@antity.Aircraft]=[]
let bullet:Array[@antity.Bullet]=[]
let bullet_my:Array[@antity.Bullet]=[]
let laser:Array[@antity.Laser]=[]
let effect:Array[@antity.Effects]=[]
fn gaming_logic()->Unit{
  //get_next_pos
  //self_plane_update_pos
  if (button_state.val.button_down||button_state.val.button_up||button_state.val.button_left||button_state.val.button_right)&&(button_state.val.button_down&&button_state.val.button_up&&button_state.val.button_left&&button_state.val.button_right).not()&&((button_state.val.button_down&&button_state.val.button_up)&&button_state.val.button_left.not()&&button_state.val.button_right.not()).not()&&(button_state.val.button_down.not()&&button_state.val.button_up.not()&&(button_state.val.button_left&&button_state.val.button_right)).not(){
    update_self()
  }
  for i=0;i<aircraft.length();i=i+1{
    aircraft[i].update_pos()
  }
  for i=0;i<bullet_my.length();i=i+1{
    bullet_my[i].update_pos()
  }
  for i=0;i<bullet.length();i=i+1{
    bullet[i].update_pos()
  }
  for i=0;i<laser.length();i=i+1{
    //waiting
  }
  //check crash
  for i=0;i<laser.length();i=i+1{

  }
  // let bullet_crashed:Array[Int]=[]
  // let bullet_crashed_my:Array[Int]=[]
  // for i=0;i<bullet.length();i=i+1{
  //   if(bullet[i].crash(@antity.player_Plane)){
  //     bullet_crashed.push(i)
  //   }
  // }
  // for i=0;i<bullet_my.length();i=i+1{
  //   for j=0;j<aircraft.length();j=j+1{
  //     if(bullet_my[i].crash(aircraft[j])){
  //       bullet_crashed_my.push(i)
  //     }
  //   }
  // }
  // for i=0;i<aircraft.length();i=i+1{
  //   aircraft[i].crash(@antity.player_Plane)
  // }
  // for i=0;i<laser.length();i=i+1{
  //   //waiting
  // }
  // //淘汰
  // for i=bullet_crashed_my.length()-1;i>=0;i=i-1{
  // }
  // for i=bullet_crashed.length()-1;i>=0;i=i-1{
  // }
  // for i=aircraft.length();i>=0;i=i-1{
  // }
  // for i=laser.length();i>=0;i=i-1{
  //   //waiting
  // }

  //生成

  if(random.uint()%500<=1){
    generate_pane(5)
  }
  if(random.uint()%1000<=3){
    generate_pane(4)
  }

  //show
  @antity.player_Plane.print()
  for i=aircraft.length()-1;i>=0;i=i-1{
    aircraft[i].print()
  }
}

//生成飞机
fn generate_pane(type_:Int)->Unit{
  aircraft.push({..@antity.plans[type_].unwrap(),pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})
  // if type_==4 {aircraft.push({..@antity.middle_plane,pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})}
  // else if type_==5 {aircraft.push({..@antity.small_plane,pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})}
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
