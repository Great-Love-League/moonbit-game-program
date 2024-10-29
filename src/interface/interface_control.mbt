pub let interface_type:Ref[Int]=Ref::new(1);
let button_state:Ref[@wasm4.GamePad]=Ref::new(@wasm4.GamePad::default())
// pub let pubsound_effects:@immut/priority_queue.T[@antity.ToneForPub]=@immut/priority_queue.new();
pub let low_y=150

let interface_gaming1:Int=1

pub fn interface()->Unit{
  @antity.musicplay();
  let currenttime:UInt = @time_cnt.get_time()
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
  button_state.val=@wasm4.get_gamepad()
  if interface_type.val==interface_gaming1 {gaming1()}
}