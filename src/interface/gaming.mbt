fn gaming1()->Unit{
  gaming_logic()
  // @antity.player_Plane_1.print()
}
let random:@random.Rand=@random.Rand::new(seed=b"ABCDEFGHIJKSMNOPQRSTUVWXYZ123456")
let aircraft:Array[@antity.Aircraft]=[]
let bullet:Array[@antity.Bullet]=[]
let bullet_my:Array[@antity.Bullet]=[]
let laser:Array[@antity.Laser]=[]
let cartridge:Array[@antity.Cartridge]=[]
let player_plane=@antity.player_Plane
let died:Ref[Bool]=Ref::new(false)

// let 
fn gaming_logic()->Unit{
	if(died.val){
		if(((@time_cnt.get_time()-@antity.player_Plane_effect.begin)/16).to_int()<4){
			@antity.showp(@antity.player_Plane_effect,(player_plane.pos.x-3).to_int(),(player_plane.pos.y).to_int(),((@time_cnt.get_time()-@antity.player_Plane_effect.begin)/16).to_int());
		}
		else{
			//Game Over
		}
	}
	else{
		
		//get_next_pos################################################################################################################
		//self_plane_update_pos
		if (button_state.val.button_down||button_state.val.button_up||button_state.val.button_left||button_state.val.button_right)&&(button_state.val.button_down&&button_state.val.button_up&&button_state.val.button_left&&button_state.val.button_right).not()&&((button_state.val.button_down&&button_state.val.button_up)&&button_state.val.button_left.not()&&button_state.val.button_right.not()).not()&&(button_state.val.button_down.not()&&button_state.val.button_up.not()&&(button_state.val.button_left&&button_state.val.button_right)).not(){
			update_self()
		}
		for i=aircraft.length()-1;i>=0;i=i-1{
			aircraft[i].update_pos()
		}
		for i=bullet_my.length()-1;i>=0;i=i-1{
			bullet_my[i].update_pos()
		}
		for i=bullet.length()-1;i>=0;i=i-1{
			bullet[i].update_pos()
		}
		for i=cartridge.length()-1;i>=0;i=i-1{
			cartridge[i].update_pos()
		}
		for i=laser.length();i>=0;i=i-1{
			//waiting
		}
		//判断碰撞####################################################################################################################
		for i=0;i<laser.length();i=i+1{


		}
		let bullet_crashed:Array[Int]=[]
		let bullet_crashed_my:Array[Int]=[]
		for i=bullet.length()-1;i>=0;i=i-1{
			if(bullet[i].crash(player_plane)){
				bullet_crashed.push(i)
        @antity.play_sound_effects({effects:@antity.generate_noise()})
			}
		}
		for i=bullet_my.length()-1;i>=0;i=i-1{
			for j=aircraft.length()-1;j>=0;j=j-1{
        //@antity.play_tone(@antity.tones.effects[1])
				if(bullet_my[i].crash(aircraft[j])){
					bullet_crashed_my.push(i)
          @antity.play_sound_effects({effects:@antity.generate_noise()})
          //@antity.play_tone(@antity.tones.effects[1])
				}
			}
		}
		for i=aircraft.length()-1;i>=0;i=i-1{
			if(aircraft[i].crash(player_plane)){
				died.val=true
        @antity.play_sound_effects({effects:@antity.generate_noise()})
				aircraft.remove(i) |> ignore
			}
		}
		if(died.val){
			@antity.player_Plane_effect.begin=@time_cnt.get_time()+1
			return 
		}
		for i=cartridge.length()-1;i>=0;i=i-1{
			if(cartridge[i].crash(player_plane)){
				cartridge.remove(i)|> ignore
			}
		}
		for i=0;i<laser.length();i=i+1{
			//waiting
		}
		//淘汰#########################################################################################################################
		for i=bullet_crashed_my.length()-1;i>=0;i=i-1{
			bullet_my.remove(bullet_crashed_my[i]) |> ignore
      @antity.play_sound_effects({effects:@antity.generate_noise()})
			//加入子弹爆炸特效
		}
		for i=bullet_crashed.length()-1;i>=0;i=i-1{
			bullet.remove(bullet_crashed[i]) |> ignore
      @antity.play_sound_effects({effects:@antity.generate_noise()})
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
		for i=cartridge.length()-1;i>=0;i=i-1{
			if(cartridge[i].is_out_all()){
				cartridge.remove(i)|> ignore
			}
		}
		for i=laser.length()-1;i>=0;i=i-1{
			//waiting
		}
		
		//生成##############################################################################################################


		if(random.uint()%500<=1){
			generate_plane(5)
		}
		if(random.uint()%1000<=3){
			generate_plane(4)
		}
		if(random.uint()%1000<=3){
			generate_cartridge()
		}
		for i=aircraft.length()-1;i>=0;i=i-1{
			shoot(aircraft[i])
		}
		shoot(player_plane)
		//子弹袋生成！！！
		@wasm4.text(bullet_my.length().to_string(),0,0)
		@wasm4.text(bullet.length().to_string(),0,8)
		@wasm4.text(aircraft.length().to_string(),0,16)
		@wasm4.text(player_plane.hp.to_string(),0,24)
		@wasm4.text(bullet_crashed_my.length().to_string(),0,32)
		@wasm4.text(bullet_crashed.length().to_string(),0,40)
	}
  //打印##############################################################################################################
  for i=bullet.length()-1;i>=0;i=i-1{
    bullet[i].print()
  }
  for i=bullet_my.length()-1;i>=0;i=i-1{
    bullet_my[i].print()
  }
  if(died.val.not()){player_plane.print()}
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
fn generate_plane(type_:Int)->Unit{
  let x={
    ..@antity.plans(type_),
    pos:@antity.Location::new(
      x=(random.uint()%160).to_float().to_double(),
      y=0,type_.reinterpret_as_uint()
    ),
  }
  while(x.is_out_partly()) {
    x.pos.x=(random.uint()%160).to_float().to_double()
  }
  aircraft.push(x)
}

fn shoot(plane:@antity.Aircraft)->Unit{
  for i=plane.bullet_exit_point.length()-1;i>=0;i=i-1{
    if(plane.bullet_exit_point[i].last_shoot>=plane.bullet_exit_point[i].shoot_speed) {
      if(plane.type_==3) {
        bullet_my.push({
          ..@antity.bullet(plane.bullet_exit_point[i].type_),
          pos:@antity.Location::new(
            x=plane.bullet_exit_point[i].x.to_double()+plane.pos.x,
            y=plane.bullet_exit_point[i].y.to_double()+plane.pos.y,
            plane.bullet_exit_point[i].type_.reinterpret_as_uint())
          })}
      else {
        let mut omg:Double=@math.atan((plane.bullet_exit_point[i].y.to_double()+plane.pos.y-player_plane.pos.y)/(plane.bullet_exit_point[i].x.to_double()+plane.pos.x-player_plane.pos.x))*57.30
        if(plane.pos.x>=player_plane.pos.x){ omg=omg+180}
        bullet.push({
        ..@antity.bullet(plane.bullet_exit_point[i].type_),
        pos:@antity.Location::new(
          x=plane.bullet_exit_point[i].x.to_double()+plane.pos.x,
          y=plane.bullet_exit_point[i].y.to_double()+plane.pos.y,
          plane.bullet_exit_point[i].type_.reinterpret_as_uint()),
          dir:omg})}
      plane.bullet_exit_point[i].last_shoot=plane.bullet_exit_point[i].last_shoot%plane.bullet_exit_point[i].shoot_speed
      update_shoot(plane)
    }
    else {plane.bullet_exit_point[i].last_shoot=plane.bullet_exit_point[i].last_shoot+1}
  }
}

fn update_shoot(plane:@antity.Aircraft)->Unit{
  if(plane.type_==4) {return}
  for i=plane.bullet_exit_point.length()-1;i>=0;i=i-1{
    if(plane.bullet_exit_point[i].limit==0){
      plane.bullet_exit_point.remove(i) |> ignore
      continue;
    }
    if(plane.bullet_exit_point[i].limit==-1) {continue;}
    plane.bullet_exit_point[i].limit=plane.bullet_exit_point[i].limit-1;
  }
  if(plane.bullet_exit_point.length()==0){
    let lin=@antity.default_bullet(plane.type_)
    plane.bullet_exit_point.resize(lin.length(),@antity.Bullet_exit_point::new(1,1,1,1,1))
    for i=plane.bullet_exit_point.length()-1;i>=0;i=i-1{
      plane.bullet_exit_point[i]={..@antity.default_bullet(plane.type_)[i]}
    }
  }
}

fn generate_cartridge()->Unit{
  if(random.uint()%100<=20){
    let x={
      ..@antity.cartridge(8),
      pos:@antity.Location::new(
        x=(random.uint()%160).to_float().to_double(),
        y=0,
        8
      )
    }
    while(x.is_out_partly()) {
      x.pos.x=(random.uint()%160).to_float().to_double()
    }
    cartridge.push(x)
  }
  if(random.uint()%100<=20){
    let x={
      ..@antity.cartridge(6),
      pos:@antity.Location::new(
        x=(random.uint()%160).to_float().to_double(),
        y=0,
        6
      )
    }
    while(x.is_out_partly()) {
      x.pos.x=(random.uint()%160).to_float().to_double()
    }
    cartridge.push(x)
  }
  if(random.uint()%100<=20){
    let x={
      ..@antity.cartridge(7),
      pos:@antity.Location::new(
        x=(random.uint()%160).to_float().to_double(),
        y=0,
        7
      )
    }
    while(x.is_out_partly()) {
      x.pos.x=(random.uint()%160).to_float().to_double()
    }
    cartridge.push(x)
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
