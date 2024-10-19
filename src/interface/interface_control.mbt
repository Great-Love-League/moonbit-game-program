pub let interface_type:Ref[Int]=Ref::new(1);
let button_state:Ref[@wasm4.GamePad]=Ref::new(@wasm4.GamePad::default())
pub fn interface()->Unit{
  button_state.val=@wasm4.get_gamepad()
  if interface_type.val==1 {gaming()}
}