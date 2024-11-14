moon build --target wasm
npx wasm4 run target/wasm/release/build/GAME.wasm
@REM moon build --target wasm -g
@REM npx wasm4 run target/wasm/debug/build/GAME.wasm
@REM moon build --target wasm-gc
@REM npx wasm4 run target/wasm-gc/release/build/GAME.wasm