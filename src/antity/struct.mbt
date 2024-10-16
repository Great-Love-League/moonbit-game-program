pub struct Location{
  mut x:Double
  mut y:Double
  mut newx:Double
  mut newy:Double
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
	sprite:Array[Sprite_parameter]
	time_management:Array[Frame_time_config]
	//time_management与sprite的长度一致，time_management用于控制sprite的每一帧显示时间
}

pub struct ToneParams {
    frequency: (UInt, UInt)
    adsr: @wasm4.ADSR
    volume: @wasm4.ADSRVolume
    channel: @wasm4.ToneFlag
}
pub struct Sound_effects{
	//具体实现待研究QWQ
}

pub struct Effects{
	frame:Frame_effects
	sound:Frame_effects
}

struct Bullet{
	type_:UInt
	harm:UInt
	pos:Location
	dir:UInt
	speed:Double
	frame:Frame_effects
}

struct Aircraft{
  type_:UInt
  pos:Location
  speed:UInt
  dir:UInt
  mut weapon:UInt
	frame:Frame_effects
  mut hp:Int
}

struct Cartridge{
  type_:UInt
  pos:Location
  mut speed:UInt
  dir:UInt
	frame:Frame_effects
}

// type_ 分配规则
// 普通子弹 1
// 高爆子弹 2
// 自机 3
// 敌机小型机 4
// 敌机中型机 5
// 高爆子弹包 6
// 双倍子弹包 7
// 血量恢复包 8