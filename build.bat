@REM moon build --target wasm
@REM npx wasm4 run target/wasm/release/build/GAME.wasm
@REM moon build --target wasm -g
@REM npx wasm4 run target/wasm/debug/build/GAME.wasm
moon build --source-dir  ./ --target wasm-gc
npx wasm4 run target/wasm-gc/release/build/GAME.wasm