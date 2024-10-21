@REM moon build --target wasm
@REM npx wasm4 run target/wasm/release/build/GAME.wasm
moon build --target wasm -g
npx wasm4 run target/wasm/debug/build/GAME.wasm