pub(all) struct Location{
  mut x:Double
  mut y:Double
  type_:UInt
//用于记录实体的位置
}

pub(all) struct Frame_time_config{
	mut begin:Int
	mut end:Int
}

pub(all) struct Frame_effects{
	xlen:UInt
	ylen:UInt
	sprite:@bitset.Bitset
	back_ground:@bitset.Bitset
}

pub(all) struct Frame_effects_{
	mut begin:UInt
	xlen:UInt
	ylen:UInt
	sprite:Array[@bitset.Bitset]
	back_ground:Array[@bitset.Bitset]
}

pub(all) struct ToneParams {
    frequency: (UInt, UInt)
    adsr: @wasm4.ADSR
    volume: @wasm4.ADSRVolume
    channel: @wasm4.ToneFlag
}

pub(all) struct Sound_effects{
	//具体实现待研究QWQ
	effects:Array[ToneParams]
}
pub(all) struct ToneForPub {
	tone:ToneParams
	startfps:UInt
}

pub(all) struct Bullet{
	type_:Int
	harm:Double
	pos:Location
	dir:Double
	speed:Double
	// frame:Frame_effects
}

pub(all) struct Bullet_exit_point{
	x:Int
	y:Int
	type_:Int
	mut last_shoot:Int
	shoot_speed:Int
	mut limit:Int
}

pub(all) struct Aircraft{
  type_:Int
  mut pos:Location
  mut speed:Double
  mut dir:Double
  // frame:Frame_effects
  mut hp:Double
  bullet_exit_point:Array[Bullet_exit_point]
}

pub(all) struct Cartridge{
  type_:Int
  pos:Location
  mut speed:Double
  dir:Double
	effect:Double
  // frame:Frame_effects
}

// type_ 分配规则
// 普通子弹_敌人 1
// 普通子弹_自己 9
// 高爆子弹_自己 2
// 高爆子弹_敌人 11
// 自机 3
// 敌机小型机 4
// 敌机中型机_普通子弹版 5
// 敌机中型机_高爆子弹版 12
// 高爆子弹包 6
// 双倍子弹包 7
// 血量恢复包 8
// 激光子弹包 10