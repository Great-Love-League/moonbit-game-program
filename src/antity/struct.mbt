pub struct Location{
  mut x:Double
  mut y:Double
  // mut newx:Double
  // mut newy:Double
  type_:UInt
//用于记录实体的位置
}

struct Sprite_parameter{
	 x:UInt
	 y:UInt
	//相对于基准像素的偏移量
	color:UInt
}

pub struct Frame{
	mut x:Int
	mut y:Int
	//代表左上角的基准像素
	sprite:Array[Sprite_parameter]
	//这个代表一帧！！
}

pub struct Frame_time_config{
	mut begin:Int64
	mut end:Int64
}

pub struct Frame_effects{
	mut begin_time:UInt64
	mut end_time:UInt64
	mut x:UInt
	mut y:UInt
	xlen:UInt
	ylen:UInt
	sprite:Array[Sprite_parameter]
	// time_management:Array[Frame_time_config]
	//time_management与sprite的长度一致，time_management用于控制sprite的每一帧显示时间
}

pub struct Frame_effects_{
	mut begin_time:UInt64
	mut end_time:UInt64
	mut x:UInt
	mut y:UInt
	sprite:Array[Frame]
	time_management:Array[Frame_time_config]
	//time_management与sprite的长度一致，time_management用于控制sprite的每一帧显示时间
}

pub struct ToneParams {
    frequency: (UInt, UInt)
    adsr: @wasm4.ADSR
    volume: @wasm4.ADSRVolume
    channel: @wasm4.ToneFlag
}

pub struct Effects{
	frame:Frame_effects_
	sound:Array[ToneParams]
}

pub struct Bullet{
	type_:UInt
	harm:UInt
	pos:Location
	dir:Double
	speed:Double
	frame:Frame_effects
}

pub struct Laser{
	type_:UInt
	pos:Location
	//表示激光最顶点的位置
	dir:UInt
	//激光方向
	harm:UInt
	warming:Frame_effects
	
}
//激光应当还有一个方向改变函数！！！

pub struct Bullet_exit_point{
	x:Int
	y:Int
	type_:Int
	last_shoot:Int64
	shoot_speed:Int64
}

pub struct Aircraft{
  type_:UInt
  pos:Location
  speed:Double
  mut dir:Double
  frame:Frame_effects
  mut hp:Double
  bullet_exit_point:Array[Bullet_exit_point]
}
//方向先不管，是个角度，0度方向与x轴正方向平行，顺时针转
//weapon 1是单发 2是双发
//speed 是每帧速度
pub struct Cartridge{
  type_:UInt
  pos:Location
  mut speed:UInt
  dir:UInt
  frame:Frame_effects
}

// type_ 分配规则
// 普通子弹_敌人 1
// 普通子弹_自己 9
// 高爆子弹 2
// 自机 3
// 敌机小型机 4
// 敌机中型机 5
// 高爆子弹包 6
// 双倍子弹包 7
// 血量恢复包 8