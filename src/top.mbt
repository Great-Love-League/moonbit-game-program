pub fn start() -> Unit {
	@wasm4.set_palette(1,@wasm4.rgb(1377129))
	@wasm4.set_palette(4,@wasm4.rgb(11221214))
	@wasm4.set_palette(3,@wasm4.rgb(16754473))
	@wasm4.set_palette(2,@wasm4.rgb(5224703))
	//初始化调色板，之后调色板禁止更改！！
}

pub fn update() -> Unit {
	//@antity.play_sound_effects(@antity.tones);
	@time_cnt.update_time();
	let currenttime=@time_cnt.get_time();
	// @antity.player_Plane_1_frame.print()
	@interface.interface()
	// @antity.player_Plane.print()
  @antity.musicplay();
	// @time_cnt.get_time()
	while true{
		//@antity.play_tone(@antity.tones.effects[1]);
		//let tone = @antity.pubsound_effects.peek().unwrap();
		if(@antity.pubsound_effects.is_empty() ){
			//@antity.play_tone(@antity.tonefortest);
			break;

		}
		let tone = @antity.pubsound_effects.peek().unwrap();
		//@antity.play_tone(@antity.tonefortest);
		if(tone.startfps>currenttime){
			break;
		}
		else{
			
			@antity.play_tone(@antity.tonefortest);
			let tone = @antity.pubsound_effects.pop().unwrap();
			@antity.play_tone(tone.tone);
			//ignore(@antity.pubsound_effects.pop());
			//@antity.pubsound_effects.pop();
		}
	}
}
