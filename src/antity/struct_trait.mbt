pub trait Print{
	print(Self)->Unit
}

pub trait Strike{
	is_strike(Self,Self)->Bool
}

pub trait Updata_pos{
	updata_pos(Self)->Unit
}

pub trait Get_new_pos{
	get_new_pos(Self)->Unit
}
pub trait Setmusic{
		setup_tone_params() -> Array[ToneParams]
}
pub fn show(self:Sprite_parameter)->Unit{
	@wasm4.set_frame_buffer(get_index(self.x,self.y),self.color)
}

pub fn show(self:Frame_effects,x:Int)->Unit{
	{..self.sprite[x],x:self.sprite[x].x+self.x,y:self.sprite[x].y+self.y}.show()
}

pub fn check_in_time(self:Frame_effects,x:Int,time:UInt64)->Bool{
	(self.time_management[x].begin.reinterpret_as_uint64()+self.begin_time<=time)&&(time<=self.time_management[x].end.reinterpret_as_uint64()+self.begin_time)
}

pub fn get_index(x:UInt,y:UInt)->UInt{
	y*160+x
}
pub fn print(sub:Frame_effects)->Unit{
	let len=sub.sprite.length();
	if sub.time_management.length()!=len {}
	let time=@time_cnt.get_time()
	for i=0;i<len;i=i+1{
		if(sub.check_in_time(i,time)){
			sub.show(i)
		}
	}
}
//function of music 
pub fn setup_tone_params() -> Array[ToneParams] {
    let adsr = @wasm4.ADSR::new(attack=0, decay=0,30, release=0);
    let volume = @wasm4.ADSRVolume::new(100,peak=100);

    let channel1 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_4,
        pan = @wasm4.TonePan::Left
    );

    let channel2 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Right
    );

    let channel3 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Pulse1,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Center
    );

    let tone1 = {
        frequency: (261, 523),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone2 = {
        frequency: (293, 587),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone3 = {
        frequency: (329, 659),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone4 = {
        frequency: (349, 698),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone5 =  {
        frequency: (392, 784),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone6 = {
        frequency: (440, 880),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone7 = {
        frequency: (493, 987),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone8 = {
        frequency: (523, 1046),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    return [tone1, tone2, tone3, tone4, tone5, tone6, tone7, tone8];
}

pub fn play_tone(params: ToneParams) -> Unit {
    @wasm4.tone(params.frequency, params.adsr, params.volume, params.channel);
}
fn play_sound_effects(effects: Sound_effects) -> Unit {
    let mut startcnt=@time_cnt.get_time();
    for effect in effects.effects {
        let tone_for_pub = { tone: effect, startfps: startcnt.to_uint() };
        ignore(pubsound_effects.push(tone_for_pub));
        startcnt+=(effect.adsr.release+effect.adsr.attack+effect.adsr.decay+effect.adsr.sustain).to_uint64();

    }
}
pub fn musicplay() -> Unit {
    let frame_counter :UInt64= @time_cnt.get_time();
		    // 每秒运行60次，假设每个音调播放0.5秒（30帧）
    let tone_duration :Int= 30;
    let index :Int64= ((frame_counter.to_int64() / tone_duration.to_int64()) % 8);
    // 根据frame_counter的值播放不同的音调
    let index=index.to_int();
    play_tone(tones.effects[index])
}
//play_tone的用法如下:
//let toneExample = {
//    frequency: (261, 523),//frequency可以自己定义,其他有需求再定义
//    adsr: adsrSTD,
//    volume: volumeSTD,
//    channel: channelSTD
//};//这里的adsrSTD,volumeSTD,channelSTD是在antity_memory.mbt中定义的标准量
//play_tone(toneExample)
pub fn compare(self:ToneForPub,other:ToneForPub)->Int{
    self.startfps.compare(other.startfps)
}

pub fn op_equal(self: ToneForPub, other: ToneForPub) -> Bool {
    self.startfps == other.startfps
}