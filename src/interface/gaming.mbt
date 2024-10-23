fn gaming1()->Unit{
  gaming_logic()
  // @antity.player_Plane_1.print()
}
type Instant
fn Instant::now() = "__moonbit_time_unstable" "instant_now"
fn Instant::elapsed_as_secs_f64(self : Instant) -> Double = "__moonbit_time_unstable" "instant_elapsed_as_secs_f64"

let random:@random.Rand=@random.Rand::new()
let aircraft:Array[@antity.Aircraft]=[]
let bullet:Array[@antity.Bullet]=[]
let bullet_my:Array[@antity.Bullet]=[]
let laser:Array[@antity.Laser]=[]
let effect:Array[@antity.Effects]=[]
let cartridge:Array[@antity.Cartridge]=[]
let player_plane=@antity.player_Plane
let died:Ref[Bool]=Ref::new(false)
fn gaming_logic()->Unit{
  //get_next_pos################################################################################################################
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
  //判断碰撞####################################################################################################################
  for i=0;i<laser.length();i=i+1{

  }
  let bullet_crashed:Array[Int]=[]
  let bullet_crashed_my:Array[Int]=[]
  for i=0;i<bullet.length();i=i+1{
    if(bullet[i].crash(@antity.player_Plane)){
      bullet_crashed.push(i)
    }
  }
  for i=0;i<bullet_my.length();i=i+1{
    for j=0;j<aircraft.length();j=j+1{
      if(bullet_my[i].crash(aircraft[j])){
        bullet_crashed_my.push(i)
      }
    }
  }
  for i=0;i<aircraft.length();i=i+1{
    if(aircraft[i].crash(player_plane)){
      died.val=true
    }
  }
  for i=0;i<laser.length();i=i+1{
    //waiting
  }
  //淘汰#########################################################################################################################
  for i=bullet_crashed_my.length()-1;i>=0;i=i-1{
    bullet_my.remove(bullet_crashed_my[i]) |> ignore
    //加入子弹爆炸特效
  }
  for i=bullet_crashed.length()-1;i>=0;i=i-1{
    bullet.remove(bullet_crashed[i]) |> ignore
    //加入子弹爆炸特效
  }
  for i=aircraft.length()-1;i>=0;i=i-1{
    if(aircraft[i].is_out_all()){
      aircraft.remove(i)|> ignore
    }
    else if(aircraft[i].die()){
      aircraft.remove(i)|> ignore
      //特效
    }
  }
  for i=bullet.length()-1;i>=0;i=i-1{
    if(bullet[i].is_out_all()){
      bullet.remove(i)|> ignore
    }
  }
  for i=bullet_my.length()-1;i>=0;i=i-1{
    if(bullet_my[i].is_out_all()){
      bullet_my.remove(i)|> ignore
    }
  }
  for i=laser.length();i>=0;i=i-1{
    //waiting
  }
  
  //生成##############################################################################################################

  if(random.uint()%500<=1){
    generate_pane(5)
  }
  if(random.uint()%1000<=3){
    generate_pane(4)
  }
  for i=aircraft.length()-1;i>=0;i=i-1{
    // shoot(aircraft[i])
  }
  // shoot(player_plane)
  //子弹袋生成！！！

  //打印##############################################################################################################

  for i=bullet.length()-1;i>=0;i=i-1{
    bullet[i].print()
  }
  player_plane.print()
  for i=aircraft.length()-1;i>=0;i=i-1{
    aircraft[i].print()
  }
  for i=laser.length()-1;i>=0;i=i-1{
    laser[i].print()
  }
  for i=cartridge.length()-1;i>=0;i=i-1{
    cartridge[i].print()
  }
  died.val=died.val||player_plane.die()
  //打印底部状态栏######################################################################################################
  // column()
}

//生成################################################################################################################################################
fn generate_pane(type_:Int)->Unit{
  aircraft.push({..@antity.plans[type_].unwrap(),pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})
  // if type_==4 {aircraft.push({..@antity.middle_plane,pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})}
  // else if type_==5 {aircraft.push({..@antity.small_plane,pos:@antity.Location::new(x=(random.uint()%160).to_float().to_double(),y=0,type_.reinterpret_as_uint())})}
}

fn shoot(plane:@antity.Aircraft)->Unit{
  for i=plane.bullet_exit_point.length()-1;i>=0;i=i-1{
    if(plane.bullet_exit_point[i].last_shoot>=plane.bullet_exit_point[i].shoot_speed) {
      if(plane.type_==3) {bullet_my.push({..@antity.bullet[plane.bullet_exit_point[i].type_].unwrap(),pos:@antity.Location::new(x=plane.bullet_exit_point[i].x.to_double()+plane.pos.x,y=plane.bullet_exit_point[i].y.to_double()+plane.pos.y,plane.bullet_exit_point[i].type_.reinterpret_as_uint())})}
      else {bullet.push({..@antity.bullet[plane.bullet_exit_point[i].type_].unwrap(),pos:@antity.Location::new(x=plane.bullet_exit_point[i].x.to_double()+plane.pos.x,y=plane.bullet_exit_point[i].y.to_double()+plane.pos.y,plane.bullet_exit_point[i].type_.reinterpret_as_uint())})}
      plane.bullet_exit_point[i].last_shoot=plane.bullet_exit_point[i].last_shoot%plane.bullet_exit_point[i].shoot_speed
    }
    else {plane.bullet_exit_point[i].last_shoot=plane.bullet_exit_point[i].last_shoot+1}
  }
}

//生成################################################################################################################################################

//自身飞机操作控制########################################################################################################################################
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
  player_plane.dir=dir
  player_plane.update_pos()
}
//自身飞机操作控制########################################################################################################################################
