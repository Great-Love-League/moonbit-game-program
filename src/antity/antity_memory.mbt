let low_y:Int=150

// 玩家飞机正常一般形态
pub let player_Plane_1_frame : Frame_effects={
  xlen:13,
  ylen:15,
  sprite:@bitset.Bitset::new(2,"000000000000110000000000000000000000001100000000000000000000000011000000000000000000000000110000000000000000000000111111000000000000000000001110110000000000000000000011001100000000000000000011101010110000000000001111100010001011110000001110100010101000101011001111111111100010111111111111000000001110110000000011000000001110101011000000000000000011111111110000000000000011110100011111000000"),
  back_ground:@bitset.Bitset::new(1,"111111011111111111100000011111110000001111111000000111111000000011111100000001111110000000111110000000011100000000001100000000000100000000000000111100000000111100000000111110000000011110001000111")
}

pub let small_plane_:Frame_effects={
  xlen:7,
  ylen:9,
  sprite:@bitset.Bitset::new(2,"000001000100000010110011100000001011100000000010111000001011001100111000101100111000000010001000000000101110000000000010000000"),
  back_ground:@bitset.Bitset::new(1,"110101110000011100001110000100000001000001110000111000011110111")
}

pub let middle_plane_:Frame_effects={
  xlen:11,
  ylen:17,
  sprite:@bitset.Bitset::new(2,"00000001000000010000000000000100000001000000000001010000000101000000101110000000101110000000101110001011100000000010111110111110000000000010101110100000001000001011001110000010100010110000001110001011101110001100101110111011101000000010101110001011101000101011100000001011000000111000000000001011001110000000000000101100111000000000000000101110000000000000000000100000000000"),
  back_ground:@bitset.Bitset::new(1,"1110111011111100000001110000000011000000000111000000001110000000011110000000101100000000010000000000000000000000000000000100000000011100000000111100000001111000000011111000000111111011111")
}

pub let small_plane:Aircraft={
	type_:4,
	pos:Location::new(x=0,y=0,4),
	bullet_exit_point:[],
	speed:1.2666666666666667,
	dir:90,
	frame:small_plane_,
	hp:10
}

pub let middle_plane:Aircraft={
	type_:5,
	pos:Location::new(x=0,y=0,5),
	bullet_exit_point:[Bullet_exit_point::new(4,17,1,95,90)],
	speed:0.6666666666666667,
	dir:90,
	frame:middle_plane_,
	hp:40
}

pub let player_Plane:Aircraft={
	type_:3,
	pos:Location::new(x=73,y=120,3),
	bullet_exit_point:[Bullet_exit_point::new(5,5,9,0,10)],
	speed:0.8666666666666667,
	dir:180,
	frame:player_Plane_1_frame,
	hp:100
}

pub let bullet1_:Frame_effects={
  xlen:2,
  ylen:2,
  sprite:@bitset.Bitset::new(2,"01010101"),
  back_ground:@bitset.Bitset::new(1,"0000")
}

pub let bullet2_:Frame_effects={
  xlen:2,
  ylen:2,
  sprite:@bitset.Bitset::new(2,"11111111"),
  back_ground:@bitset.Bitset::new(1,"0000")
}


pub let bullet1:Bullet={
	type_:9,
	harm:10,
	pos:Location::new(9),
	dir:270,
	speed:1,
	frame:bullet1_
}

pub let bullet2:Bullet={
	type_:1,
	harm:10,
	pos:Location::new(1),
	dir:90,
	speed:1,
	frame:bullet2_
}

pub let hp_recovery_pack:Cartridge={
	type_:8,
	pos:Location::new(8),
	speed:0.5,
	dir:90,
	effect:50,
	frame:hp_recovery_pack_
}

pub let hp_recovery_pack_:Frame_effects={
  xlen:8,
  ylen:8,
  sprite:@bitset.Bitset::new(2,"01111101011111011101101111100111111001101001101111100101010110110111100101101101011110010110110101011110101101010101011111010101"),
  back_ground:@bitset.Bitset::new(1,"0000000000000000000000000000000000000000000000000000000000000000")
}

pub let bullet:Map[Int,Bullet]={9:bullet1,1:bullet2}
pub let plans:Map[Int,Aircraft]={3:player_Plane,4:small_plane,5:middle_plane}
pub let cartridge:Map[Int,Cartridge]={8:hp_recovery_pack}
pub let default_bullet:Map[Int,Int]={3:1,5:9}

//pub var of music
pub let adsrSTD:@wasm4.ADSR=@wasm4.ADSR::new(attack=0, decay=0,30, release=0);//ADSR指播放时声音的变化形式，具体自己查
pub let volumeSTD:@wasm4.ADSRVolume=@wasm4.ADSRVolume::new(100,peak=100);//音量
pub let channelSTD:@wasm4.ToneFlag=@wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,//音色
        mode = @wasm4.ToneMode::Duty_1_2,//波形
        pan = @wasm4.TonePan::Center//左右，中心声道
    );
//音乐用途tones数组
pub let tones: Array[ToneParams] = setup_tone_params();
